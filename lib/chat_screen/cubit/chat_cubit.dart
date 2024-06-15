import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:messenger_test_task/data/models/message.dart';
import 'package:messenger_test_task/data/models/user.dart';
import 'package:messenger_test_task/service/messenger_repository.dart';

part 'chat_state.dart';

class ChatCubit extends Cubit<ChatState> {
  ChatCubit({required MessengerRepository messengerRepository})
      : _messengerRepository = messengerRepository,
        super(ChatInitial());

  //repository
  final MessengerRepository _messengerRepository;

  //get ucurrent 'logged in' user
  User getCurrentUser() => _messengerRepository.getCurrentUser();

  //send messege (submit)
  Future<void> sendMessage(
      {required String messageText,
      File? messegePhoto,
      required User user}) async {
    //check if there is anything to change
    if (messageText.trim().isEmpty && messegePhoto == null) {
      return;
    }

    final currentUser = _messengerRepository.getCurrentUser();

    //send message and emit initial to rerender ui
    try {
      _messengerRepository.addMessage(
        Message(
          dateTime: DateTime.now(),
          senderUserId: currentUser.id,
          receiverUserId: user.id,
          file: messegePhoto,
          text: messageText.trim().isEmpty ? null : messageText,
        ),
      );
      emit(ChatInitial());
    } catch (e) {
      //if error emit this
      emit(ChatError(e.toString()));
    }
  }

  //fetch all chat messages
  Future<void> fetchChatMessages(User user) async {
    try {
      final messages = await _messengerRepository.getChatMessages(user);
      emit(ChatMessagesFetched(messages));
    } catch (e) {
      emit(ChatError(e.toString()));
    }
  }

  //image source dialog
  void showImageSourcePickerDialog(
      {required BuildContext context, required User user}) {
    showDialog(
      context: context,
      builder: (ctx) => SimpleDialog(
        title: Text(
          'Выберите источник',
          style: Theme.of(context)
              .textTheme
              .titleLarge!
              .copyWith(color: Theme.of(context).colorScheme.onSurface),
        ),
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              IconButton(
                  iconSize: 50,
                  onPressed: () {
                    Navigator.of(ctx).pop();
                    pickImage(
                        context: context,
                        user: user,
                        imageSource: ImageSource.gallery);
                  },
                  icon: const Icon(Icons.photo)),
              IconButton(
                  iconSize: 50,
                  onPressed: () {
                    Navigator.of(ctx).pop();
                    pickImage(
                        context: context,
                        user: user,
                        imageSource: ImageSource.camera);
                  },
                  icon: const Icon(Icons.camera_alt))
            ],
          ),
          Align(
            alignment: Alignment.centerRight,
            child: TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text('Отмена')),
          )
        ],
      ),
    );
  }

  //image picker
  void pickImage(
      {required BuildContext context,
      required User user,
      required ImageSource imageSource}) async {
    final pickedImage = await ImagePicker().pickImage(
      source: imageSource,
      imageQuality: 50,
      maxWidth: 400,
    );
    if (pickedImage == null) {
      return null;
    }
    context.mounted
        ? showImageSendingDialog(context, File(pickedImage.path), user)
        : null;
  }

  //image sender dialog
  void showImageSendingDialog(
    BuildContext context,
    File image,
    User user,
  ) {
    final messageController = TextEditingController();
    showDialog(
      context: context,
      builder: (ctx) => SimpleDialog(
        children: [
          Image.file(image),
          TextField(
            controller: messageController,
            textCapitalization: TextCapitalization.sentences,
            autocorrect: true,
            enableSuggestions: true,
            decoration: InputDecoration(
              hintText: 'Сообщение',
              filled: true,
              fillColor: Theme.of(context).colorScheme.surfaceDim,
              border: OutlineInputBorder(
                borderSide: BorderSide.none,
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              TextButton(
                onPressed: () {
                  Navigator.pop(ctx);
                },
                child: const Text("Отмена"),
              ),
              IconButton(
                color: Theme.of(context).colorScheme.primary,
                onPressed: () {
                  sendMessage(
                      messageText: messageController.text,
                      messegePhoto: image,
                      user: user);
                  FocusScope.of(context).unfocus();
                  messageController.clear();
                  Navigator.pop(ctx);
                },
                icon: const Icon(Icons.send),
                iconSize: 40,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:messenger_test_task/chat_screen/cubit/chat_cubit.dart';
import 'package:messenger_test_task/data/models/message.dart';
import 'package:messenger_test_task/data/models/user.dart';

class NewMessages extends StatefulWidget {
  const NewMessages({super.key, required this.user});

  final User user;
  @override
  State<NewMessages> createState() => _NewMessagesState();
}

class _NewMessagesState extends State<NewMessages> {
  final FocusNode _focus = FocusNode();
  final _messageController = TextEditingController();

  bool _isFocused = false;
  @override
  void dispose() {
    _messageController.dispose();
    _focus.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _focus.addListener(_onFocusChange);
  }

  void _onFocusChange() {
    setState(() {
      _isFocused = _focus.hasFocus;
    });
  }

  void _submitMessage() {
    final enteredMessage = _messageController.text;

    if (enteredMessage.trim().isEmpty) {
      return;
    }

    FocusScope.of(context).unfocus();
    _messageController.clear();

    final currentUser = BlocProvider.of<ChatCubit>(context).getCurrentUser();
    //save
    BlocProvider.of<ChatCubit>(context).sendMessage(
      Message(
        dateTime: DateTime.now(),
        text: enteredMessage,
        senderUserId: currentUser.id,
        receiverUserId: widget.user.id,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return Padding(
      padding: const EdgeInsets.only(bottom: 14),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          if (!_isFocused)
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Theme.of(context).colorScheme.surfaceDim,
              ),
              child: IconButton(
                onPressed: () {},
                iconSize: 40,
                icon: const Icon(Icons.attach_file),
              ),
            ),
          SizedBox(
            width: _isFocused ? width / 1.3 : width / 1.7,
            child: TextField(
              focusNode: _focus,
              controller: _messageController,
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
          ),
          AnimatedSwitcher(
            switchInCurve: Curves.easeInBack,
            duration: const Duration(milliseconds: 100),
            child: _isFocused
                ? Container(
                    key: const ValueKey<int>(1),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Theme.of(context).colorScheme.surfaceDim,
                    ),
                    child: IconButton(
                      color: Theme.of(context).colorScheme.primary,
                      onPressed: _submitMessage,
                      icon: const Icon(Icons.send),
                      iconSize: 40,
                    ),
                  )
                : Container(
                    key: const ValueKey<int>(2),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Theme.of(context).colorScheme.surfaceDim,
                    ),
                    child: IconButton(
                      color: Theme.of(context).colorScheme.primary,
                      onPressed: () {},
                      icon: const Icon(Icons.mic),
                      iconSize: 40,
                    ),
                  ),
          ),
        ],
      ),
    );
  }
}

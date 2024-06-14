import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:messenger_test_task/data/models/user.dart';
import 'package:messenger_test_task/home_screen/cubit/home_cubit.dart';
import 'package:messenger_test_task/service/locator.dart';
import 'package:messenger_test_task/service/messenger_repository.dart';

class UserChat extends StatelessWidget {
  const UserChat({super.key, required this.user});

  final User user;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        BlocProvider.of<HomeCubit>(context).navigateToChat(context, user);
      },
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: const BoxDecoration(
          border: Border.symmetric(
            horizontal: BorderSide(color: Color.fromARGB(255, 221, 221, 221)),
          ),
        ),
        child: BlocProvider(
          create: (context) => HomeCubit(
            messengerRepository: locator<MessengerRepository>(),
          ),
          child: BlocBuilder<HomeCubit, HomeState>(
            builder: (context, state) {
              //formatter
              final dateFormatter = DateFormat('dd.MM.yy');
              //get current date and time
              final now = DateTime.now();
              //get last messege in the chat
              final lastChatMessage =
                  BlocProvider.of<HomeCubit>(context).getChatLastMessage(user);
              String timeStampToDisplay = '';
              if (lastChatMessage != null) {
                //check the difference between last messege sent date and now and make according timestamp
                if (lastChatMessage.dateTime.difference(now).inDays.abs() < 1) {
                  if (lastChatMessage.dateTime.difference(now).inHours.abs() <
                      1) {
                    if (lastChatMessage.dateTime
                            .difference(now)
                            .inMinutes
                            .abs() ==
                        0) {
                      timeStampToDisplay = 'только что';
                    } else {
                      timeStampToDisplay =
                          '${lastChatMessage.dateTime.difference(now).inMinutes.abs()} минуты назад';
                    }
                  } else {
                    timeStampToDisplay =
                        '${lastChatMessage.dateTime.hour}:${lastChatMessage.dateTime.minute}';
                  }
                } else if (lastChatMessage.dateTime
                        .difference(now)
                        .inDays
                        .abs() <
                    2) {
                  timeStampToDisplay = "Вчера";
                } else {
                  timeStampToDisplay =
                      dateFormatter.format(lastChatMessage.dateTime);
                }
              }

              String lastMessageToDisplay = '';

              if (lastChatMessage != null) {
                //check if the messege was sent by you or not
                if (lastChatMessage.senderUserId != user.id) {
                  lastMessageToDisplay = 'Вы: ';
                }
                //check if the last messsega was photo only
                if (lastChatMessage.filePath != null) {
                  lastMessageToDisplay = '$lastMessageToDisplayфотография';
                } else {
                  lastMessageToDisplay += lastChatMessage.text!;
                }
              }

              return ListTile(
                titleAlignment: ListTileTitleAlignment.top,
                contentPadding: EdgeInsets.zero,
                leading: CircleAvatar(
                  radius: 30,
                  backgroundColor: user.color,
                  child: user.userImagePath == null
                      //if there is profile photo display it, if no display the initials
                      ? Text(
                          "${user.fullname.split(' ').first[0]}${user.fullname.split(' ')[1][0]}",
                          style: Theme.of(context)
                              .textTheme
                              .titleLarge!
                              .copyWith(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                        )
                      : Image.file(File(user.userImagePath!)),
                ),
                title: Text(
                  user.fullname,
                  style: Theme.of(context).textTheme.titleMedium!.copyWith(
                      color: Theme.of(context).colorScheme.onSurface,
                      fontWeight: FontWeight.w600),
                ),
                subtitle: Text(lastMessageToDisplay),
                //check if there is any message)
                trailing: Text(timeStampToDisplay),
              );
            },
          ),
        ),
      ),
    );
  }
}

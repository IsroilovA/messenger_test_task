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
              final dateFormatter = DateFormat('dd.MM.yy');
              final now = DateTime.now();
              final message =
                  BlocProvider.of<HomeCubit>(context).getChatLastMessage(user);
              String timeStampToDisplay = '';
              if (message != null) {
                if (message.dateTime.difference(now).inDays.abs() < 1) {
                  if (message.dateTime.difference(now).inHours.abs() < 1) {
                    if (message.dateTime.difference(now).inMinutes.abs() == 0) {
                      timeStampToDisplay = 'только что';
                    } else {
                      timeStampToDisplay =
                          '${message.dateTime.difference(now).inMinutes.abs()} минуты назад';
                    }
                  } else {
                    timeStampToDisplay =
                        '${message.dateTime.hour}:${message.dateTime.minute}';
                  }
                } else if (message.dateTime.difference(now).inDays.abs() < 2) {
                  timeStampToDisplay = "Вчера";
                } else {
                  timeStampToDisplay = dateFormatter.format(message.dateTime);
                }
              }

              return ListTile(
                titleAlignment: ListTileTitleAlignment.top,
                contentPadding: EdgeInsets.zero,
                leading: CircleAvatar(
                  radius: 30,
                  backgroundColor: user.color,
                  child: user.userImagePath == null
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
                subtitle:
                    //check if there is any message
                    message == null
                        ? null
                        : Text(
                            //check if the last message was photo or message
                            message.text == null ? "photo" : message.text!,
                          ),
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

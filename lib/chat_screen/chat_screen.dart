import 'dart:io';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:messenger_test_task/chat_screen/widgets/chat_messages.dart';
import 'package:messenger_test_task/chat_screen/widgets/new_nessages.dart';
import 'package:messenger_test_task/data/models/user.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({super.key, required this.user});

  final User user;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: ListTile(
          titleAlignment: ListTileTitleAlignment.top,
          contentPadding: EdgeInsets.zero,
          leading: CircleAvatar(
            radius: 30,
            //random color
            backgroundColor: Color((Random().nextDouble() * 0xFFFFFF).toInt())
                .withOpacity(1.0),
            child: user.userImagePath == null
                ? Text(
                    "${user.fullname.split(' ').first[0]}${user.fullname.split(' ')[1][0]}",
                    style: Theme.of(context).textTheme.titleLarge!.copyWith(
                        color: Colors.white, fontWeight: FontWeight.bold),
                  )
                : Image.file(File(user.userImagePath!)),
          ),
          title: Text(
            user.fullname,
            style: Theme.of(context).textTheme.titleMedium!.copyWith(
                color: Theme.of(context).colorScheme.onSurface,
                fontWeight: FontWeight.w600),
          ),
          subtitle: Text(user.isOnline ? 'online' : 'offline'),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(bottom: 30),
        child: Column(
          children: [
            Expanded(
              child: ChatMessages(user: user),
            ),
            const NewMessages(),
          ],
        ),
      ),
    );
  }
}

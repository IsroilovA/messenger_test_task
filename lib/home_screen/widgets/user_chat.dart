import 'dart:io';

import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:messenger_test_task/data/models/user.dart';

class UserChat extends StatelessWidget {
  const UserChat({super.key, required this.user});

  final User user;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: const BoxDecoration(
        border: Border.symmetric(
          horizontal: BorderSide(color: Color.fromARGB(255, 221, 221, 221)),
        ),
      ),
      child: ListTile(
        contentPadding: EdgeInsets.zero,
        leading: CircleAvatar(
          radius: 30,
          //random color
          backgroundColor:
              Color((math.Random().nextDouble() * 0xFFFFFF).toInt())
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
        subtitle: const Text('placeholder'),
        trailing: const Text('placeholder'),
      ),
    );
  }
}

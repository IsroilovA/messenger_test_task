import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:messenger_test_task/chat_screen/cubit/chat_cubit.dart';
import 'package:messenger_test_task/chat_screen/widgets/message_buble.dart';
import 'package:messenger_test_task/data/models/user.dart';
import 'package:messenger_test_task/service/locator.dart';
import 'package:messenger_test_task/service/messenger_repository.dart';

class ChatMessages extends StatelessWidget {
  const ChatMessages({super.key, required this.user});

  final User user;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          ChatCubit(messengerRepository: locator<MessengerRepository>()),
      child: BlocBuilder<ChatCubit, ChatState>(
        builder: (context, state) {
          if (state is ChatInitial) {
            BlocProvider.of<ChatCubit>(context).fetchChatMessages(user);
            return const Center(child: CircularProgressIndicator.adaptive());
          } else if (state is ChatMessagesFetched) {
            return ListView.builder(
              itemCount: state.messages.length,
              itemBuilder: (context, index) {
                return MessageBubble.first(
                    message: state.messages[index], isMe: false);
              },
            );
          } else if (state is ChatError) {
            return Center(
              child: Text(
                state.error,
                style: Theme.of(context).textTheme.titleLarge!.copyWith(
                      color: Theme.of(context).colorScheme.onSurface,
                    ),
              ),
            );
          } else {
            return Center(
              child: Text(
                "something went wrong",
                style: Theme.of(context).textTheme.titleLarge!.copyWith(
                      color: Theme.of(context).colorScheme.onSurface,
                    ),
              ),
            );
          }
        },
      ),
    );
  }
}

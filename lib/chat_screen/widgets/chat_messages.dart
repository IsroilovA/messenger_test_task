import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:messenger_test_task/chat_screen/cubit/chat_cubit.dart';
import 'package:messenger_test_task/chat_screen/widgets/message_buble.dart';
import 'package:messenger_test_task/data/models/user.dart';

class ChatMessages extends StatelessWidget {
  const ChatMessages({super.key, required this.user});

  final User user;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ChatCubit, ChatState>(
      builder: (context, state) {
        final currentUser =
            BlocProvider.of<ChatCubit>(context).getCurrentUser();
        if (state is ChatInitial) {
          BlocProvider.of<ChatCubit>(context).fetchChatMessages(user);
          return const Center(child: CircularProgressIndicator.adaptive());
        } else if (state is ChatMessagesFetched) {
          return ListView.builder(
            itemCount: state.messages.length,
            itemBuilder: (context, index) {
              final chatMessage = state.messages[index];
              final nextChatMessage = index + 1 < state.messages.length
                  ? state.messages[index + 1]
                  : null;
              final currentMessageUserId = chatMessage.senderUserId;
              final nextMessageUserId = nextChatMessage?.senderUserId;
              final nextUserIsSame = currentMessageUserId == nextMessageUserId;
              if (nextUserIsSame) {
                return MessageBubble.next(
                  message: chatMessage,
                  isMe: currentUser.id == currentMessageUserId,
                );
              } else {
                return MessageBubble.last(
                  message: chatMessage,
                  isMe: currentUser.id == currentMessageUserId,
                );
              }
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
    );
  }
}

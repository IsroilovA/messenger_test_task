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
          return SingleChildScrollView(
            child: ListView.builder(
              physics: const NeverScrollableScrollPhysics(),
              itemCount: state.messages.length,
              shrinkWrap: true,
              itemBuilder: (context, index1) {
                return Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      state.messages.keys.toList()[index1],
                      style: Theme.of(context).textTheme.titleMedium!.copyWith(
                            color:
                                Theme.of(context).colorScheme.onSurfaceVariant,
                          ),
                    ),
                    ListView.builder(
                      padding: const EdgeInsets.symmetric(vertical: 20),
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: state.messages.values.toList()[index1].length,
                      itemBuilder: (context, index) {
                        final chatMessage =
                            state.messages.values.toList()[index1][index];
                        final nextChatMessage = index + 1 <
                                state.messages.values.toList()[index1].length
                            ? state.messages.values.toList()[index1][index + 1]
                            : null;
                        final currentMessageUserId = chatMessage.senderUserId;
                        final nextMessageUserId = nextChatMessage?.senderUserId;
                        final nextUserIsSame =
                            currentMessageUserId == nextMessageUserId;
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
                    ),
                  ],
                );
              },
            ),
          );

          //   ListView.builder(
          //     shrinkWrap: true,
          //     physics: const NeverScrollableScrollPhysics(),
          //     itemCount: state.messages.length,
          //     itemBuilder: (context, index) {
          //       final chatMessage = state.messages[index];
          //       final nextChatMessage = index + 1 < state.messages.length
          //           ? state.messages[index + 1]
          //           : null;
          //       final currentMessageUserId = chatMessage.senderUserId;
          //       final nextMessageUserId = nextChatMessage?.senderUserId;
          //       final nextUserIsSame =
          //           currentMessageUserId == nextMessageUserId;
          //       if (nextUserIsSame) {
          //         return MessageBubble.next(
          //           message: chatMessage,
          //           isMe: currentUser.id == currentMessageUserId,
          //         );
          //       } else {
          //         return MessageBubble.last(
          //           message: chatMessage,
          //           isMe: currentUser.id == currentMessageUserId,
          //         );
          //       }
          //     },
          //   ),
          // );
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

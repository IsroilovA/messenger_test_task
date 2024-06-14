import 'package:flutter/material.dart';
import 'package:messenger_test_task/data/models/message.dart';

class MessageBubble extends StatelessWidget {
  // Create a message bubble which is meant to be the first in the sequence.
  const MessageBubble.last({
    super.key,
    required this.message,
    required this.isMe,
  }) : isFirstInSequence = true;

  // Create a amessage bubble that continues the sequence.
  const MessageBubble.next({
    super.key,
    required this.message,
    required this.isMe,
  }) : isFirstInSequence = false;

  final bool isFirstInSequence;
  final Message message;

  // Controls how the MessageBubble will be aligned.
  final bool isMe;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Row(
      // The side of the chat screen the message should show at.
      mainAxisAlignment: isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
      children: [
        Column(
          crossAxisAlignment:
              isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
          children: [
            if (isFirstInSequence) const SizedBox(height: 8),
            Container(
              decoration: BoxDecoration(
                color: isMe
                    ? const Color.fromARGB(255, 118, 227, 121)
                    : theme.colorScheme.surfaceContainerHighest.withAlpha(200),
                borderRadius: BorderRadius.only(
                  topLeft: const Radius.circular(12),
                  topRight: const Radius.circular(12),
                  bottomLeft: !isMe && isFirstInSequence
                      ? Radius.zero
                      : const Radius.circular(12),
                  bottomRight: isMe && isFirstInSequence
                      ? Radius.zero
                      : const Radius.circular(12),
                ),
              ),
              constraints: const BoxConstraints(maxWidth: 200),
              padding: const EdgeInsets.symmetric(
                vertical: 10,
                horizontal: 14,
              ),
              // Margin around the bubble.
              margin: const EdgeInsets.symmetric(
                horizontal: 12,
              ),
              child: Text(
                message.text!,
                style: const TextStyle(
                  height: 1.5,
                  color: Colors.black,
                ),
                softWrap: true,
              ),
            ),
          ],
        ),
      ],
    );
  }
}

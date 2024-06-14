part of 'chat_cubit.dart';

sealed class ChatState extends Equatable {
  const ChatState();

  @override
  List<Object> get props => [];
}

final class ChatInitial extends ChatState {}

final class ChatMessagesFetched extends ChatState {
  final Map<String, List<Message>> messages;

  const ChatMessagesFetched(this.messages);
}

final class ChatError extends ChatState {
  final String error;

  const ChatError(this.error);
}

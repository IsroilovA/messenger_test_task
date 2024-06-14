import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:messenger_test_task/data/models/message.dart';
import 'package:messenger_test_task/data/models/user.dart';
import 'package:messenger_test_task/service/messenger_repository.dart';

part 'chat_state.dart';

class ChatCubit extends Cubit<ChatState> {
  ChatCubit({required MessengerRepository messengerRepository})
      : _messengerRepository = messengerRepository,
        super(ChatInitial());

  final MessengerRepository _messengerRepository;

  User getCurrentUser() => _messengerRepository.getCurrentUser();

  Future<void> sendMessage(Message message) async {
    try {
      _messengerRepository.addMessage(message);
      emit(ChatInitial());
    } catch (e) {
      emit(ChatError(e.toString()));
    }
  }

  Future<void> fetchChatMessages(User user) async {
    try {
      final messages = await _messengerRepository.getChatMessages(user);
      emit(ChatMessagesFetched(messages));
    } catch (e) {
      emit(ChatError(e.toString()));
    }
  }
}

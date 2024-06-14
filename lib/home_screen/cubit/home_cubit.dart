import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:messenger_test_task/chat_screen/chat_screen.dart';
import 'package:messenger_test_task/data/models/message.dart';
import 'package:messenger_test_task/data/models/user.dart';
import 'package:equatable/equatable.dart';
import 'package:messenger_test_task/service/messenger_repository.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit({required MessengerRepository messengerRepository})
      : _messengerRepository = messengerRepository,
        super(HomeInitial());

  final MessengerRepository _messengerRepository;

  Future<void> getUsers() async {
    emit(HomeUsersLoading());
    try {
      final users = await _messengerRepository.getUsers();
      emit(HomeUsersFetched(users));
    } catch (e) {
      emit(HomeError(e.toString()));
    }
  }

  void navigateToChat(BuildContext context, User user) async {
    await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => ChatScreen(user: user),
      ),
    );
    emit(HomeInitial());
  }

  Message? getChatLastMessage(User user) {
    try {
      return _messengerRepository.getChatLastMessage(user);
    } catch (e) {
      return null;
    }
  }
}

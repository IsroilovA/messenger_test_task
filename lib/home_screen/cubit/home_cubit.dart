import 'package:bloc/bloc.dart';
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
}

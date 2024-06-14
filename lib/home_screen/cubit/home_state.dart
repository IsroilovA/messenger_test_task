part of 'home_cubit.dart';

sealed class HomeState extends Equatable {
  const HomeState();

  @override
  List<Object> get props => [];
}

final class HomeInitial extends HomeState {}

final class HomeError extends HomeState {
  final String message;
  const HomeError(this.message);
}

final class HomeUsersFetched extends HomeState {
  final List<User> users;
  const HomeUsersFetched(this.users);
}

final class HomeUsersLoading extends HomeState {}

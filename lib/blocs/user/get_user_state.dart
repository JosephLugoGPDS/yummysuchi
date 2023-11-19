part of 'get_user_bloc.dart';

abstract class GetUserState {}

class GetUserInitial extends GetUserState {}
class GetUserLoading extends GetUserState {}

class GetUserSuccess extends GetUserState {
  final User user;

  GetUserSuccess(this.user);
}

class GetUserFailure extends GetUserState {
  final String errorMessage;

  GetUserFailure(this.errorMessage);
}

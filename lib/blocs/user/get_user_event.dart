part of 'get_user_bloc.dart';

abstract class GetUserEvent {}

class FetchUserEvent extends GetUserEvent {
  FetchUserEvent({
    required this.uuid,
    this.name = 'Usuario',
  });
  final String uuid;
  final String name;
}

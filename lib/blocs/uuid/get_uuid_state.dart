part of 'get_uuid_bloc.dart';

abstract class GetUuidState {}

class GetUuidInitial extends GetUuidState {}

class GetUuidLoading extends GetUuidState {}

class GetUuidFailure extends GetUuidState {
  final String failure;
  

  GetUuidFailure(this.failure);
}

class GetUuidSuccess extends GetUuidState {
  final String deviceName;
  

  GetUuidSuccess(this.deviceName);
}
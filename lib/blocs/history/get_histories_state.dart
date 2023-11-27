part of 'get_histories_bloc.dart';

abstract class GetHistoriesState {}

class GetHistoriesInitial extends GetHistoriesState {}

class GetHistoriesLoading extends GetHistoriesState {}

class GetHistoriesLoaded extends GetHistoriesState {
  final List<History> histories;

  GetHistoriesLoaded({required this.histories});
}

class GetHistoriesError extends GetHistoriesState {
  final String errorMessage;

  GetHistoriesError({required this.errorMessage});
}

part of 'get_histories_bloc.dart';

abstract class GetHistoriesEvent {}

class FetchHistoriesEvent extends GetHistoriesEvent {
  final String uuid;
  final String inventory;

  FetchHistoriesEvent({required this.uuid, required this.inventory});
}

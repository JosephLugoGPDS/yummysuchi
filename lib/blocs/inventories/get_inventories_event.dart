part of 'get_inventories_bloc.dart';

abstract class GetInventoriesEvent {}

class FetchInventoriesEvent extends GetInventoriesEvent {
  final String uuid;

  FetchInventoriesEvent({required this.uuid});
}

part of 'get_inventories_bloc.dart';

abstract class GetInventoriesState {}

class GetInventoriesInitial extends GetInventoriesState {}

class GetInventoriesLoading extends GetInventoriesState {}

class GetInventoriesLoaded extends GetInventoriesState {
  final List<Inventory> inventories;

  GetInventoriesLoaded(this.inventories);
}

class GetInventoriesError extends GetInventoriesState {
  final String errorMessage;

  GetInventoriesError(this.errorMessage);
}

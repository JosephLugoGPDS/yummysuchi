part of 'delete_inventory_bloc.dart';

abstract class DeleteInventoryState {
  const DeleteInventoryState();
}

class DeleteInventoryInitial extends DeleteInventoryState {
  const DeleteInventoryInitial();
}

class DeleteInventoryLoading extends DeleteInventoryState {
  const DeleteInventoryLoading();
}

class DeleteInventorySuccess extends DeleteInventoryState {
  final bool success;

  const DeleteInventorySuccess({required this.success});
}

class DeleteInventoryFailure extends DeleteInventoryState {
  final String error;

  const DeleteInventoryFailure({required this.error});
}

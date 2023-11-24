part of 'create_inventory_bloc.dart';

abstract class CreateInventoryState {
  const CreateInventoryState();
}

class CreateInventoryInitial extends CreateInventoryState {
  const CreateInventoryInitial();
}

class CreateInventoryLoading extends CreateInventoryState {
  const CreateInventoryLoading();
}

class CreateInventorySuccess extends CreateInventoryState {
  final bool success;

  const CreateInventorySuccess({required this.success});
}

class CreateInventoryFailure extends CreateInventoryState {
  final String error;

  const CreateInventoryFailure({required this.error});
}

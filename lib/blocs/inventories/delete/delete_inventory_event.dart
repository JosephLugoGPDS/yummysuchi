part of 'delete_inventory_bloc.dart';

abstract class DeleteInventoryEvent {
  const DeleteInventoryEvent();
}

class DeleteInventory extends DeleteInventoryEvent {
  const DeleteInventory({
    required this.name,
    required this.uuid,
  });
  final String name;
  final String uuid;
}

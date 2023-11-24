part of 'create_inventory_bloc.dart';

abstract class CreateInventoryEvent {
  const CreateInventoryEvent();
}

class CreateInventory extends CreateInventoryEvent {
  const CreateInventory({
    required this.name,
    required this.uuid,
    this.description,
    required this.providers,
    required this.asset,
  });
  final String name;
  final String uuid;
  final String? description;
  final List<String> providers;
  final String asset;
}

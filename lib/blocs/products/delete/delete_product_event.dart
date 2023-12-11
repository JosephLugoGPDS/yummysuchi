part of 'delete_product_bloc.dart';

abstract class DeleteProductEvent {
  const DeleteProductEvent();
}

class DeleteNewProductEvent extends DeleteProductEvent {
  const DeleteNewProductEvent({
    required this.id,
    required this.uuid,
    required this.inventory,
  });
  final String inventory;
  final int id;
  final String uuid;
}

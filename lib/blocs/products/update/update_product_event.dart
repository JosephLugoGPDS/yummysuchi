part of 'update_product_bloc.dart';

abstract class UpdateProductEvent {
  const UpdateProductEvent();
}

class UpdateNewProductEvent extends UpdateProductEvent {
  const UpdateNewProductEvent({
    required this.product,
    required this.stock,
    required this.uuid,
    required this.inventory,
  });
  final Product product;
  final int stock;
  final String uuid;
  final String inventory;
}

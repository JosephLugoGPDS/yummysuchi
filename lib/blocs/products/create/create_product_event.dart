part of 'create_product_bloc.dart';

abstract class CreateProductEvent {
  const CreateProductEvent();
}

class CreateNewProductEvent extends CreateProductEvent {
  const CreateNewProductEvent({
    required this.productName,
    required this.stock,
    required this.stockMin,
    required this.stockMax,
    required this.uuid,
    required this.inventory,
    required this.providers,
  });
  final String productName;
  final int stock;
  final int stockMin;
  final int stockMax;
  final String uuid;
  final String inventory;
  final List<String> providers;
}

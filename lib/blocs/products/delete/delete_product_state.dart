part of 'delete_product_bloc.dart';

abstract class DeleteProductState {
  const DeleteProductState();
}

class DeleteProductInitial extends DeleteProductState {
  const DeleteProductInitial();
}

class DeleteProductLoading extends DeleteProductState {
  const DeleteProductLoading();
}

class DeleteProductSuccess extends DeleteProductState {
  const DeleteProductSuccess();
}

class DeleteProductFailure extends DeleteProductState {
  final String error;
  const DeleteProductFailure({required this.error});
}

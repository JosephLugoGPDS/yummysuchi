part of 'update_product_bloc.dart';

abstract class UpdateProductState {
  const UpdateProductState();
}

class UpdateProductInitial extends UpdateProductState {
  const UpdateProductInitial();
}

class UpdateProductLoading extends UpdateProductState {
  const UpdateProductLoading();
}

class UpdateProductSuccess extends UpdateProductState {
  const UpdateProductSuccess();
}

class UpdateProductFailure extends UpdateProductState {
  final String error;
  const UpdateProductFailure({required this.error});
}

part of 'create_product_bloc.dart';

abstract class CreateProductState {
  const CreateProductState();
}

class CreateProductInitial extends CreateProductState {
  const CreateProductInitial();
}

class CreateProductLoading extends CreateProductState {
  const CreateProductLoading();
}

class CreateProductSuccess extends CreateProductState {
  const CreateProductSuccess();
}

class CreateProductFailure extends CreateProductState {
  final String error;
  const CreateProductFailure({required this.error});
}

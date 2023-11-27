import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:inventario_yummy_sushi/model/inventory.dart';

class GetCurrentProductCubit extends Cubit<Product?> {
  GetCurrentProductCubit() : super(null);

  void setCurrentProduct(Product product) {
    emit(product);
  }
}

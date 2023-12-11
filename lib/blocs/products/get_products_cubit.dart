import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:inventario_yummy_sushi/model/inventory.dart';

class GetProductsCubit extends Cubit<List<Product>> {
  GetProductsCubit() : super(const []);

  // load products from list products
  void loadProducts(List<Product> products, String icon) {
    iconInventory = icon;
    emit(products);
  }

  String iconInventory = 'Alimentos';
}

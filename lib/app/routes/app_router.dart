import 'package:inventario_yummy_sushi/views/create_inventory_view.dart';
import 'package:inventario_yummy_sushi/views/create_product_view.dart';
import 'package:inventario_yummy_sushi/views/history_list_view.dart';
import 'package:inventario_yummy_sushi/views/home_view.dart';
import 'package:inventario_yummy_sushi/views/products_view.dart';
import 'package:inventario_yummy_sushi/views/splash_view.dart';
import 'package:flutter/widgets.dart';

class AppRoutes {
  static const String splashScreen = '/splash';
  static const String homeScreen = '/home';
  static const String createInventoryScreen = '/inventory/create';
  static const String productsScreen = '/inventory/products';
  static const String createProductsScreen = '/inventory/products/create';
  static const String historyListScreen = '/inventory/history/list';

  static Map<String, WidgetBuilder> get routes {
    return {
      splashScreen: (BuildContext context) => const SplashView(),
      homeScreen: (BuildContext context) => const HomeView(),
      productsScreen: (BuildContext context) => const ProductsView(),
      createInventoryScreen: (BuildContext context) =>
          const CreateInventoryView(),
      createProductsScreen: (BuildContext context) => const CreateProductView(),
      historyListScreen: (BuildContext context) => const HistoryListView(),
    };
  }
}

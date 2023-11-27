import 'package:inventario_yummy_sushi/blocs/history/get_histories_bloc.dart';
import 'package:inventario_yummy_sushi/blocs/inventories/create/create_inventory_bloc.dart';
import 'package:inventario_yummy_sushi/blocs/inventories/get_current_inventory.dart';
import 'package:inventario_yummy_sushi/blocs/inventories/get_inventories_bloc.dart';
import 'package:inventario_yummy_sushi/blocs/inventories/select_assets_cubit.dart';
import 'package:inventario_yummy_sushi/blocs/is_saved_user_cubit.dart';
import 'package:get_it/get_it.dart';
import 'package:inventario_yummy_sushi/blocs/pdf/generated_pdf_cubit.dart';
import 'package:inventario_yummy_sushi/blocs/products/create/create_product_bloc.dart';
import 'package:inventario_yummy_sushi/blocs/products/get_products_cubit.dart';
import 'package:inventario_yummy_sushi/blocs/products/get_selection_providers_cubit.dart';
import 'package:inventario_yummy_sushi/blocs/products/products_controller_cubit.dart';
import 'package:inventario_yummy_sushi/blocs/user/get_user_bloc.dart';
import 'package:inventario_yummy_sushi/blocs/uuid/get_uuid_bloc.dart';

final sl = GetIt.instance;

Future<void> init() async {
  sl.registerLazySingleton<IsSavedUserCubit>(
      () => IsSavedUserCubit()..loadSavedUser());
  sl.registerLazySingleton<GetUuidBloc>(
      () => GetUuidBloc()..add(const FetchUuidEvent()));
  sl.registerLazySingleton<GetUserBloc>(() => GetUserBloc());
  sl.registerLazySingleton<GetInventoriesBloc>(() => GetInventoriesBloc());
  sl.registerLazySingleton<CreateInventoryBloc>(() => CreateInventoryBloc());
  sl.registerLazySingleton<SelectAssetsCubit>(() => SelectAssetsCubit());
  sl.registerLazySingleton<GetProductsCubit>(() => GetProductsCubit());
  sl.registerLazySingleton<GetSelectionProvidersCubit>(
      () => GetSelectionProvidersCubit());
  sl.registerLazySingleton<ProvidersProductControllerCubit>(
      () => ProvidersProductControllerCubit());
  sl.registerLazySingleton<CreateProductBloc>(() => CreateProductBloc());
  sl.registerLazySingleton<GetCurrentInventory>(() => GetCurrentInventory());
  sl.registerLazySingleton<GetHistoriesBloc>(() => GetHistoriesBloc());
  sl.registerLazySingleton<GeneratedPdfCubit>(() => GeneratedPdfCubit());
}

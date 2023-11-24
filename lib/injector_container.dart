import 'package:inventario_yummy_sushi/blocs/inventories/create/create_inventory_bloc.dart';
import 'package:inventario_yummy_sushi/blocs/inventories/get_inventories_bloc.dart';
import 'package:inventario_yummy_sushi/blocs/inventories/select_assets_cubit.dart';
import 'package:inventario_yummy_sushi/blocs/is_saved_user_cubit.dart';
import 'package:get_it/get_it.dart';
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
}

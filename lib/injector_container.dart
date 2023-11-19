import 'package:inventario_yummy_sushi/blocs/is_saved_user_cubit.dart';
import 'package:get_it/get_it.dart';
import 'package:inventario_yummy_sushi/blocs/user/get_user_bloc.dart';
import 'package:inventario_yummy_sushi/blocs/uuid/get_uuid_bloc.dart';

final sl = GetIt.instance;

Future<void> init() async {
  sl.registerLazySingleton<IsSavedUserCubit>(
      () => IsSavedUserCubit()..loadSavedUser());
  sl.registerLazySingleton<GetUuidBloc>(() => GetUuidBloc());
  sl.registerLazySingleton<GetUserBloc>(() => GetUserBloc());
}

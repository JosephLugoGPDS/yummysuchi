import 'package:inventario_yummy_sushi/blocs/is_saved_user_cubit.dart';
import 'package:inventario_yummy_sushi/blocs/splash_cubit.dart';
import 'package:get_it/get_it.dart';

final sl = GetIt.instance;

Future<void> init() async {
    sl.registerLazySingleton<SplashCubit>(() => SplashCubit());
    sl.registerLazySingleton<IsSavedUserCubit>(() => IsSavedUserCubit()..loadSavedUser());
  // sl.registerLazySingleton<UploadRemoteDataSource>(() => const UploadRemoteDataSourceImpl());
  // sl.registerLazySingleton<TicketRemoteDataSource>(() => const TicketRemoteDataSourceImpl());
}

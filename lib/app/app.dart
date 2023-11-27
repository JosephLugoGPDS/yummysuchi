import 'package:inventario_yummy_sushi/app/constants/app_theme.dart';
import 'package:inventario_yummy_sushi/app/l10n/l10n.dart';
import 'package:inventario_yummy_sushi/app/routes/app_router.dart';
import 'package:inventario_yummy_sushi/app/utils/screen_util.dart';
import 'package:inventario_yummy_sushi/blocs/history/get_histories_bloc.dart';
import 'package:inventario_yummy_sushi/blocs/inventories/create/create_inventory_bloc.dart';
import 'package:inventario_yummy_sushi/blocs/inventories/get_current_inventory.dart';
import 'package:inventario_yummy_sushi/blocs/inventories/get_inventories_bloc.dart';
import 'package:inventario_yummy_sushi/blocs/inventories/select_assets_cubit.dart';
import 'package:inventario_yummy_sushi/blocs/products/create/create_product_bloc.dart';
import 'package:inventario_yummy_sushi/blocs/products/get_products_cubit.dart';
import 'package:inventario_yummy_sushi/blocs/products/get_selection_providers_cubit.dart';
import 'package:inventario_yummy_sushi/blocs/products/products_controller_cubit.dart';
import 'package:inventario_yummy_sushi/blocs/user/get_user_bloc.dart';
import 'package:inventario_yummy_sushi/blocs/uuid/get_uuid_bloc.dart';
import 'package:inventario_yummy_sushi/views/splash_view.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'package:inventario_yummy_sushi/injector_container.dart' as di;

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
    return MultiBlocProvider(
      providers: [
        BlocProvider<SelectAssetsCubit>(
            create: (_) => di.sl<SelectAssetsCubit>()),
        BlocProvider<CreateInventoryBloc>(
            create: (_) => di.sl<CreateInventoryBloc>()),
        BlocProvider<CreateInventoryBloc>(
            create: (_) => di.sl<CreateInventoryBloc>()),
        BlocProvider<GetUserBloc>(create: (_) => di.sl<GetUserBloc>()),
        BlocProvider<GetUuidBloc>(create: (_) => di.sl<GetUuidBloc>()),
        BlocProvider<GetProductsCubit>(
            create: (_) => di.sl<GetProductsCubit>()),
        BlocProvider<GetInventoriesBloc>(
            create: (_) => di.sl<GetInventoriesBloc>()),
        BlocProvider<GetSelectionProvidersCubit>(
            create: (_) => di.sl<GetSelectionProvidersCubit>()),
        BlocProvider<ProvidersProductControllerCubit>(
            create: (_) => di.sl<ProvidersProductControllerCubit>()),
        BlocProvider<CreateProductBloc>(
            create: (_) => di.sl<CreateProductBloc>()),
        BlocProvider<GetCurrentInventory>(
            create: (_) => di.sl<GetCurrentInventory>()),
        BlocProvider<GetHistoriesBloc>(
            create: (_) => di.sl<GetHistoriesBloc>()),
      ],
      child: MaterialApp(
        navigatorKey: navigatorKey,
        theme: AppTheme.themeMobile(context).copyWith(
          scrollbarTheme: ScrollbarThemeData(
            thumbColor: MaterialStateProperty.all<Color>(AppTheme.accentColor),
            minThumbLength: 40,
          ),
        ),
        localizationsDelegates: const [
          AppLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
        ],
        routes: AppRoutes.routes,
        // initialRoute: AppRoute.initial,
        home: Builder(
          builder: (contextBuilder) {
            // contextBuilder.read<GetUuidBloc>().add(const FetchUuidEvent());
            ScreenUtil.init(
              allowFontScaling: true,
            );
            return const SplashView();
          },
        ),
        supportedLocales: AppLocalizations.supportedLocales,
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}

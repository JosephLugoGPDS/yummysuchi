import 'package:inventario_yummy_sushi/app/constants/app_theme.dart';
import 'package:inventario_yummy_sushi/app/l10n/l10n.dart';
import 'package:inventario_yummy_sushi/app/routes/app_router.dart';
import 'package:inventario_yummy_sushi/app/utils/screen_util.dart';
import 'package:inventario_yummy_sushi/blocs/splash_cubit.dart';
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
        BlocProvider<SplashCubit>(create: (_) => di.sl<SplashCubit>()),
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

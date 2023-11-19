import 'dart:async';
import 'dart:developer';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:inventario_yummy_sushi/firebase_options.dart';
import 'package:inventario_yummy_sushi/injector_container.dart' as di;

class AppBlocObserver extends BlocObserver {
  @override
  void onChange(BlocBase bloc, Change change) {
    super.onChange(bloc, change);
    log('>>>>>${bloc.runtimeType} $change', name: 'on change');
  }

  @override
  void onError(BlocBase bloc, Object error, StackTrace stackTrace) {
    log('#### ${bloc.runtimeType} $error $stackTrace ####', name: 'on error');
    super.onError(bloc, error, stackTrace);
  }
}


Future<void> bootstrap(FutureOr<Widget> Function() builder) async {
  FlutterError.onError = (details) {
    log(details.exceptionAsString(), stackTrace: details.stack);
  };
  await runZonedGuarded(() async {

    
    WidgetsFlutterBinding.ensureInitialized();
    await di.init();
    // await dotenv.load();
    await Firebase.initializeApp(
  options: DefaultFirebaseOptions.currentPlatform,
);
    // Run App
    // Run Zoned guard
    runApp(await builder());
    Bloc.observer = AppBlocObserver();
  },
  (error, StackTrace stack) async => FlutterError.reportError(FlutterErrorDetails(exception: error, stack: stack)));
  
}


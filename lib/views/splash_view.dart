import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:inventario_yummy_sushi/app/constants/app_theme.dart';
import 'package:inventario_yummy_sushi/app/extensions/size_extension.dart';
import 'package:inventario_yummy_sushi/app/l10n/l10n.dart';
import 'package:inventario_yummy_sushi/blocs/is_saved_user_cubit.dart';
import 'package:inventario_yummy_sushi/gen/assets.gen.dart';
import 'package:flutter/material.dart';
import 'package:inventario_yummy_sushi/injector_container.dart' as di;
import 'package:inventario_yummy_sushi/widgets/theme_dialog.dart';
import 'package:inventario_yummy_sushi/widgets/theme_text_form_field.dart';

class SplashView extends StatelessWidget {
  const SplashView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => di.sl<IsSavedUserCubit>(),
      child: const SplashScreen(),
    );
  }
}

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final TextEditingController _controller = TextEditingController();
    final AppLocalizations l10n = context.l10n;
    return Scaffold(
      backgroundColor: AppTheme.primaryColor,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            BlocListener<IsSavedUserCubit, bool>(
              listener: (context, stateIsSavedUserCubit) async {
                if (stateIsSavedUserCubit) {
                  Navigator.of(context).pushReplacementNamed('/home');
                } else {
                  showDialog(
                    barrierDismissible: false,
                    context: context,
                    builder: (BuildContext _) {
                      return Padding(
                        padding: EdgeInsets.symmetric(horizontal: 15.w),
                        child: ThemeDialog(
                          showIconClose: false,
                          contentPadding:
                              EdgeInsets.fromLTRB(10.w, 10.h, 10.w, 10.h),
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 15.w),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                SizedBox(
                                  height: 60.h,
                                ),
                                Text(
                                  l10n.welcomeNameRequired,
                                  style: const TextStyle(color: Colors.black),
                                ),
                                SizedBox(
                                  height: 20.h,
                                ),
                                ThemeTextFormField(
                                  textEditingController: _controller,
                                  label: l10n.name,
                                ),
                                TextButton(
                                  onPressed: () async {
                                    if (_controller.text.isNotEmpty) {
                                      FocusScope.of(context).unfocus();
                                      Navigator.of(context)
                                          .pushReplacementNamed('/home');

                                      await context
                                          .read<IsSavedUserCubit>()
                                          .saveUser(true);
                                    } else {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        SnackBar(
                                          content: Text(l10n.nameRequired),
                                          backgroundColor: AppTheme.accentColor,
                                        ),
                                      );
                                    }
                                  },
                                  child: Text('Guardar',
                                      style: TextStyle(
                                          color: AppTheme.accentColor,
                                          fontSize: 14.sp)),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  );
                }
              },
              child: const SizedBox(),
            ),
            Assets.splashPng.image(),
            const SizedBox(height: 16),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: BoxDecoration(
                color: AppTheme.accentColor,
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Text(
                'Inventario',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

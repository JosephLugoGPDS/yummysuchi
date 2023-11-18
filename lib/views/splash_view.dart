import 'package:inventario_yummy_sushi/app/constants/app_theme.dart';
import 'package:inventario_yummy_sushi/gen/assets.gen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_countdown_timer/flutter_countdown_timer.dart';
import 'package:inventario_yummy_sushi/views/home_view.dart';

      class SplashView extends StatelessWidget {
        const SplashView({Key? key}) : super(key: key);

        @override
        Widget build(BuildContext context) {
          return Scaffold(
            backgroundColor: AppTheme.primaryColor,
            body: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CountdownTimer(
                    endTime: DateTime.now().millisecondsSinceEpoch + 2000,
                    onEnd: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) => const HomeView()),
                      );
                    },
                    widgetBuilder: (_, time) {
                      return Column(
                        children: [
                                          Assets.splashPng.image(),

                          Text(
                            'Ingresando en ${time?.sec} segundos',
                            style: const TextStyle(fontSize: 24, color: Colors.white),
                          ),
                        ],
                      );
                    },
                  ),
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

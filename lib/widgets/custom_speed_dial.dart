import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:inventario_yummy_sushi/app/constants/app_theme.dart';
import 'package:inventario_yummy_sushi/app/extensions/size_extension.dart';

class CustomDialActions extends StatelessWidget {
  const CustomDialActions({
    super.key,
    this.onDeletePressed,
    this.onSharePressed,
    this.onProductsPressed,
    this.onShowPressed,
  });

  final void Function()? onProductsPressed;
  final void Function()? onSharePressed;
  final void Function()? onShowPressed;
  final void Function()? onDeletePressed;

  @override
  Widget build(BuildContext context) {
    return SpeedDial(
      activeIcon: Icons.close,
      backgroundColor: Colors.transparent,
      foregroundColor: AppTheme.accentColor,
      gradient: null,
      mini: true,
      elevation: 0,
      // gradientBoxShape: BoxShape.circle,
      animatedIconTheme: IconThemeData(size: 22.w),
      icon: Icons.more_vert,
      buttonSize: Size(22.w, 22.w),
      closeManually: false,
      direction: SpeedDialDirection.left,
      children: [
        SpeedDialChild(
          elevation: 0,
          child: Container(
            width: 28.w,
            height: 28.w,
            decoration: const BoxDecoration(
              color: AppTheme.primaryColor,
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.share,
              color: Colors.white,
              size: 20.w,
            ),
          ),
          backgroundColor: Colors.transparent,
          onTap: onSharePressed,
        ),
        // SpeedDialChild(
        //   elevation: 0,
        //   child: Container(
        //     width: 28.w,
        //     height: 28.w,
        //     decoration: const BoxDecoration(
        //       color: AppTheme.secondColor,
        //       shape: BoxShape.circle,
        //     ),
        //     child: Icon(
        //       Icons.storefront_rounded,
        //       color: Colors.white,
        //       size: 20.w,
        //     ),
        //   ),
        //   backgroundColor: Colors.transparent,
        //   onTap: onProductsPressed,
        // ),
        SpeedDialChild(
          elevation: 0,
          child: Container(
            width: 28.w,
            height: 28.w,
            decoration: const BoxDecoration(
              color: AppTheme.accentColor,
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.history,
              color: Colors.white,
              size: 20.w,
            ),
          ),
          backgroundColor: Colors.transparent,
          onTap: onShowPressed,
        ),
      ],
    );
  }
}

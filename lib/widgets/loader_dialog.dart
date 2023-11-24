import 'package:flutter/material.dart';
import 'package:inventario_yummy_sushi/app/constants/app_theme.dart';
import 'package:inventario_yummy_sushi/app/extensions/size_extension.dart';

class LoaderDialog extends StatelessWidget {
  const LoaderDialog({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.transparent,
      width: 21.w,
      height: 21.h,
      child: const Center(
        child: CircularProgressIndicator(
            strokeWidth: 6, color: AppTheme.primaryColor),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:inventario_yummy_sushi/app/constants/app_theme.dart';
import 'package:inventario_yummy_sushi/app/extensions/size_extension.dart';

class CustomReturn extends StatelessWidget {
  const CustomReturn({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: MediaQuery.of(context).padding.top + 25.h,
      left: 0,
      child: GestureDetector(
        onTap: () => Navigator.pop(context),
        child: const Icon(
          Icons.arrow_back_ios,
          color: AppTheme.grayTextColor,
        ),
      ),
    );
  }
}

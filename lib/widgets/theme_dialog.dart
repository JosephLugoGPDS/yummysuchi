import 'package:flutter/material.dart';
import 'package:inventario_yummy_sushi/app/constants/app_theme.dart';
import 'package:inventario_yummy_sushi/app/extensions/size_extension.dart';

class ThemeDialog extends StatelessWidget {
  const ThemeDialog({
    Key? key,
    required this.child,
    this.onTap,
    this.onTapClosed,
    this.showIconClose = true,
    this.contentPadding,
    this.height,
    this.width,
  }) : super(key: key);

  final Widget child;
  final void Function()? onTap;
  final void Function()? onTapClosed;
  final bool showIconClose;
  final EdgeInsets? contentPadding;
  final double? width;
  final double? height;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      buttonPadding: EdgeInsets.zero,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(5.w))),
      contentPadding: contentPadding ?? EdgeInsets.fromLTRB(5.w, 5.h, 5.w, 5.h),
      insetPadding: contentPadding ?? EdgeInsets.fromLTRB(5.w, 5.h, 5.w, 5.h),
      content: SizedBox(
        height: height,
        width: width,
        child: Stack(
          children: <Widget>[
            showIconClose
                ? Positioned(
                    right: 0,
                    top: 0,
                    child: IconButton(
                      onPressed:
                          onTapClosed ?? () => Navigator.of(context).pop(),
                      icon: const Icon(
                        Icons.close,
                        color: AppTheme.grayTextColor,
                      ),
                    ),
                  )
                : const SizedBox(),
            child,
          ],
        ),
      ),
    );
  }
}

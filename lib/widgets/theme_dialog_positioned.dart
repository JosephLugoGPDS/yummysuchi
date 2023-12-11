import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:inventario_yummy_sushi/app/constants/app_theme.dart';
import 'package:inventario_yummy_sushi/app/extensions/size_extension.dart';
import 'package:inventario_yummy_sushi/app/utils/data_util.dart';

class ThemeDialogPositioned extends StatelessWidget {
  const ThemeDialogPositioned({
    Key? key,
    this.onTap,
    this.onTapClosed,
    this.showIconClose = true,
    required this.child,
    required this.icon,
    this.requiredIcon = true,
  }) : super(key: key);

  final void Function()? onTap;
  final void Function()? onTapClosed;
  final bool showIconClose;
  final bool requiredIcon;
  final String icon;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      insetPadding: EdgeInsets.zero,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(5.w),
        ),
      ),
      backgroundColor: Colors.transparent,
      contentPadding: EdgeInsets.symmetric(horizontal: 0.w, vertical: 0),
      content: Stack(
        alignment: Alignment.center,
        clipBehavior: Clip.none,
        children: <Widget>[
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                decoration: ShapeDecoration(
                  color: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(5.w),
                    ),
                  ),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    ...requiredIcon
                        ? [
                            SizedBox(height: 25.h),
                            icon.contains('svg')
                                ? SvgPicture.asset(
                                    icon,
                                    height: 50.h,
                                    width: 50.w,
                                    color: AppTheme.accentColor,
                                  )
                                : Icon(
                                    DataUtil.iconMap[icon]['iconPrimary']
                                        ['iconData'],
                                    size: 50.w,
                                    color: AppTheme.accentColor,
                                  ),
                          ]
                        : [SizedBox(height: 20.h)],
                    child,
                  ],
                ),
              ),
              SizedBox(height: 50.h),
            ],
          ),
          Positioned(
            bottom: 25.h,
            child: GestureDetector(
              onTap: onTap ?? () => Navigator.of(context).pop(),
              child: Container(
                alignment: Alignment.center,
                height: 50.h,
                width: 100.w,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.w),
                    color: AppTheme.primaryColor,
                    boxShadow: const [
                      BoxShadow(
                        offset: Offset(0, 5),
                        blurRadius: 15,
                        color: Color.fromRGBO(7, 205, 254, 0.35),
                      )
                    ]),
                child: const Icon(
                  Icons.check,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

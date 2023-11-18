import 'dart:ui';

abstract class ScreenUtil {
  factory ScreenUtil() {
    return _instance!;
  }

  static ScreenUtil? _instance;
  static const int defaultWidth = 375;
  static const int defaultHeight = 812;

  late num uiWidthPx;
  late num uiHeightPx;
  late bool allowFontScaling;

  double? textScaleFactor;
  double? pixelRatio;
  double? screenWidth;
  double? screenHeight;
  double? screenWidthPx;
  double? screenHeightPx;
  double? statusBarHeight;
  double? statusBarHeightPx;
  double? bottomBarHeight;

  double get scaleWidth => screenWidth! / uiWidthPx;
  double get scaleHeight => screenHeight! / uiHeightPx;
  double get scaleText => scaleWidth;

  num setWidth(num width) => width * scaleWidth;
  num setHeight(num height) => height * scaleHeight;

  num setSp(num fontSize, {bool? allowFontScalingSelf}) => allowFontScalingSelf == null ? (allowFontScaling ? (fontSize * scaleText) : ((fontSize * scaleText) / textScaleFactor!)) : (allowFontScalingSelf ? (fontSize * scaleText) : ((fontSize * scaleText) / textScaleFactor!));

  static void init({num width = defaultWidth, num height = defaultHeight, bool allowFontScaling = false}) {
    _instance ??= ScreenUtilImpl();
    _instance!.uiWidthPx = width;
    _instance!.uiHeightPx = height;
    _instance!.allowFontScaling = allowFontScaling;
    _instance!.textScaleFactor = window.textScaleFactor;
    _instance!.pixelRatio = window.devicePixelRatio;
    _instance!.screenWidth = window.physicalSize.width / window.devicePixelRatio;
    _instance!.screenHeight = window.physicalSize.height / window.devicePixelRatio;
    _instance!.statusBarHeight = window.padding.top / window.devicePixelRatio;
    _instance!.bottomBarHeight = window.padding.bottom / window.devicePixelRatio;
  }
}

class ScreenUtilImpl implements ScreenUtil {
  @override
  num uiWidthPx = 0;
  @override
  num uiHeightPx = 0;
  @override
  bool allowFontScaling = false;
  @override
  double? textScaleFactor;
  @override
  double? pixelRatio;
  @override
  double? screenWidth = 0;
  @override
  double? screenHeight = 0;
  @override
  double? screenWidthPx;
  @override
  double? screenHeightPx;
  @override
  double? statusBarHeight = 0;
  @override
  double? statusBarHeightPx;
  @override
  double? bottomBarHeight;

  @override
  double get scaleWidth => screenWidth! / uiWidthPx;

  @override
  double get scaleHeight => screenHeight! / uiHeightPx;

  @override
  double get scaleText => scaleWidth;

  @override
  num setWidth(num width) => width * scaleWidth;

  @override
  num setHeight(num height) => height * scaleHeight;

  @override
  num setSp(num fontSize, {bool? allowFontScalingSelf}) => allowFontScalingSelf == null ? (allowFontScaling ? (fontSize * scaleText) : ((fontSize * scaleText) / textScaleFactor!)) : (allowFontScalingSelf ? (fontSize * scaleText) : ((fontSize * scaleText) / textScaleFactor!));
  // _ScreenUtilImpl();
}
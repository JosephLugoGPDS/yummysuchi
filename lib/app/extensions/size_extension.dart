

import 'package:inventario_yummy_sushi/app/utils/screen_util.dart';

extension SizeExtension on num {
  double get w => ScreenUtil().setWidth(this) as double;

  double get h => ScreenUtil().setHeight(this) as double;

  double get sp => ScreenUtil().setSp(this) as double;
}
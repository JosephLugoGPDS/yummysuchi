import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:inventario_yummy_sushi/app/constants/svg_list.dart';

class SelectAssetsCubit extends Cubit<String> {
  SelectAssetsCubit() : super(SvgList.list.first);

  Future<void> selectAsset(String asset) async => emit(asset);
}

import 'package:flutter_bloc/flutter_bloc.dart';

class SelectAssetsCubit extends Cubit<String> {
  SelectAssetsCubit() : super('Alimentos');

  Future<void> selectAsset(String asset) async => emit(asset);
}

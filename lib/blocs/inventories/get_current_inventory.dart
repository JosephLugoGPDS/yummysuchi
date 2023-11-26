import 'package:flutter_bloc/flutter_bloc.dart';

class GetCurrentInventory extends Cubit<String> {
  GetCurrentInventory() : super('');

  void loadInventory(String id) {
    emit(id);
  }
}

import 'package:flutter_bloc/flutter_bloc.dart'; 
import 'package:shared_preferences/shared_preferences.dart';

class IsSavedUserCubit extends Cubit<bool> {
  IsSavedUserCubit() : super(false);

  Future<void> loadSavedUser() async {
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      final isSavedUser = prefs.getBool('isSavedUser') ?? false;
      emit(isSavedUser);
    } catch (e) {
      // Handle error
    }
  }

  Future<void> saveUser(bool isSavedUser) async {
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setBool('isSavedUser', isSavedUser);
      emit(isSavedUser);
    } catch (e) {
      // Handle error
    }
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProvidersControllerCubit extends Cubit<List<TextEditingController>> {
  ProvidersControllerCubit() : super([TextEditingController()]);

  Future<void> addProvider() async {
    final TextEditingController providersLoading = TextEditingController();
    emit([...state, providersLoading]);
  }
}

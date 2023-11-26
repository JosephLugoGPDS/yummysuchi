import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NameProductControllerCubit extends Cubit<List<TextEditingController>> {
  NameProductControllerCubit() : super([TextEditingController()]);

  Future<void> addForm() async {
    final TextEditingController providersLoading = TextEditingController();
    emit([...state, providersLoading]);
  }
}

class StockProductControllerCubit extends Cubit<List<TextEditingController>> {
  StockProductControllerCubit() : super([TextEditingController()]);

  Future<void> addForm() async {
    final TextEditingController providersLoading = TextEditingController();
    emit([...state, providersLoading]);
  }
}

class StockMinProductControllerCubit
    extends Cubit<List<TextEditingController>> {
  StockMinProductControllerCubit() : super([TextEditingController()]);

  Future<void> addForm() async {
    final TextEditingController providersLoading = TextEditingController();
    emit([...state, providersLoading]);
  }
}

class StockMaxProductControllerCubit
    extends Cubit<List<TextEditingController>> {
  StockMaxProductControllerCubit() : super([TextEditingController()]);

  Future<void> addForm() async {
    final TextEditingController providersLoading = TextEditingController();
    emit([...state, providersLoading]);
  }
}

class ProvidersProductControllerCubit extends Cubit<List<String>> {
  ProvidersProductControllerCubit() : super(const []);

  Future<void> add(String selection) async {
    emit([...state, selection]);
  }

  Future<void> remove(String selection) async {
    state.remove(selection);
    emit(state);
  }
}

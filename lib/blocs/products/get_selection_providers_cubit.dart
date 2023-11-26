import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class GetSelectionProvidersCubit extends Cubit<List<String>> {
  GetSelectionProvidersCubit() : super(const []);

  // load providers from inventory
  void loadProviders(List<String> providers) {
    providerList = providers;
    emit([]);
  }

  void selectProvider(List<String> providers) {
    debugPrint('provider: $state');
    emit([]);
    emit(providers);
    debugPrint('provider: $state');
  }

  List<String> providerList = [];
}

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:inventario_yummy_sushi/model/history.dart';
part 'get_histories_event.dart';
part 'get_histories_state.dart';

class GetHistoriesBloc extends Bloc<GetHistoriesEvent, GetHistoriesState> {
  GetHistoriesBloc() : super(GetHistoriesInitial()) {
    on<FetchHistoriesEvent>(_onFetchHistoriesEvent);
  }

  Future<void> _onFetchHistoriesEvent(
    FetchHistoriesEvent event,
    Emitter<GetHistoriesState> emit,
  ) async {
    emit(GetHistoriesLoading());
    try {
      final List<History> histories =
          await _fetchHistories(event.uuid, event.inventory);
      emit(GetHistoriesLoaded(histories: histories));
    } catch (e) {
      emit(GetHistoriesError(errorMessage: e.toString()));
    }
  }

  Future<List<History>> _fetchHistories(String uuid, String inventory) async {
    try {
      CollectionReference historiesCollection =
          FirebaseFirestore.instance.collection('history');
      DocumentSnapshot historySnapshot =
          await historiesCollection.doc(uuid).get();

      // QuerySnapshot historySnapshot = await historiesCollection.get();
      if (!historySnapshot.exists) {
        return [];
      }
      List<History> histories = [];
      final Map<String, dynamic> response =
          historySnapshot.data() as Map<String, dynamic>;
      final List<dynamic> responseData = response[inventory];

      histories = History.getHistoriesFromJson(responseData);
      return histories;
    } catch (error) {
      debugPrint(error.toString());
      return [];
    }
  }
}

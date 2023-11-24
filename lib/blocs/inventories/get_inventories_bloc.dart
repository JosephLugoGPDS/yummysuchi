import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:inventario_yummy_sushi/model/inventory.dart';

part 'get_inventories_event.dart';
part 'get_inventories_state.dart';

class GetInventoriesBloc
    extends Bloc<GetInventoriesEvent, GetInventoriesState> {
  GetInventoriesBloc() : super(GetInventoriesInitial()) {
    on<FetchInventoriesEvent>(_onFetchInventoriesEvent);
  }

  Future<void> _onFetchInventoriesEvent(
    FetchInventoriesEvent event,
    Emitter<GetInventoriesState> emit,
  ) async {
    emit(GetInventoriesLoading());
    try {
      final List<Inventory> inventories = await _fetchInventories(event.uuid);
      emit(GetInventoriesLoaded(inventories));
    } catch (e) {
      emit(GetInventoriesError(e.toString()));
    }
  }

  Future<List<Inventory>> _fetchInventories(String uuid) async {
    try {
      CollectionReference inventoriesCollection =
          FirebaseFirestore.instance.collection('inventories');
      DocumentSnapshot inventorySnapshot =
          await inventoriesCollection.doc(uuid).get();

      // QuerySnapshot inventorySnapshot = await inventoriesCollection.get();
      if (!inventorySnapshot.exists) {
        return [];
      }
      List<Inventory> inventories = [];
      final Map<String, dynamic> responseData =
          inventorySnapshot.data() as Map<String, dynamic>;
      for (var i = 0; i < responseData.length; i++) {
        final String key = responseData.keys.elementAt(i);
        final Map<String, dynamic> inventoryData = responseData[key];
        debugPrint(inventoryData.toString());
        inventories.add(Inventory.fromJson(inventoryData));
      }
      return inventories;
    } catch (error) {
      debugPrint(error.toString());
      return [];
    }
  }
}

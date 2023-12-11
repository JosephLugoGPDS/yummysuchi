import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'delete_inventory_event.dart';
part 'delete_inventory_state.dart';

class DeleteInventoryBloc
    extends Bloc<DeleteInventoryEvent, DeleteInventoryState> {
  DeleteInventoryBloc() : super(const DeleteInventoryInitial()) {
    on<DeleteInventory>(_onDeleteInventory);
  }
  Future<void> _onDeleteInventory(
      DeleteInventory event, Emitter<DeleteInventoryState> emit) async {
    emit(const DeleteInventoryLoading());

    CollectionReference inventoriesCollection =
        FirebaseFirestore.instance.collection('inventories');
    DocumentSnapshot inventorySnapshot =
        await inventoriesCollection.doc(event.uuid).get();

    debugPrint('inventorySnapshot: ${inventorySnapshot.data()}');

    Map<String, dynamic>? inventory;
    if (inventorySnapshot.exists) {
      inventory = inventorySnapshot.data() as Map<String, dynamic>;
    } else {
      emit(const DeleteInventoryFailure(
          error: 'Inventory does not exist in database'));
    }

    if (inventory != null) {
      try {
        await inventoriesCollection.doc(event.uuid).get().then(
          (snapshot) async {
            Map<String, dynamic> inventoryData = snapshot.data()
                as Map<String, dynamic>; // Map<String, dynamic>?

            inventoryData.remove(event.name);

            await inventoriesCollection.doc(event.uuid).set(inventoryData);
            emit(const DeleteInventorySuccess(success: true));
          },
        );
      } catch (error) {
        emit(DeleteInventoryFailure(error: error.toString()));
      }
    } else {
      emit(const DeleteInventoryFailure(
          error: 'Inventory does not exist in database'));
    }
  }
}

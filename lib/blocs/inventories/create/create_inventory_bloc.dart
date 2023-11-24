import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'create_inventory_event.dart';
part 'create_inventory_state.dart';

class CreateInventoryBloc
    extends Bloc<CreateInventoryEvent, CreateInventoryState> {
  CreateInventoryBloc() : super(const CreateInventoryInitial()) {
    on<CreateInventory>(_onCreateInventory);
  }
  Future<void> _onCreateInventory(
      CreateInventory event, Emitter<CreateInventoryState> emit) async {
    emit(const CreateInventoryLoading());

    CollectionReference inventoriesCollection =
        FirebaseFirestore.instance.collection('inventories');
    DocumentSnapshot inventorySnapshot =
        await inventoriesCollection.doc(event.uuid).get();

    debugPrint('inventorySnapshot: ${inventorySnapshot.data()}');

    Map<String, dynamic>? inventory;
    if (inventorySnapshot.exists) {
      inventory = inventorySnapshot.data() as Map<String, dynamic>;
    }

    if (inventory != null) {
      inventory[event.name] = {
        'name': event.name,
        'description': event.description ?? '',
        'providers': event.providers,
        'asset': event.asset,
      };
      try {
        await inventoriesCollection.doc(event.uuid).update(inventory);
        emit(const CreateInventorySuccess(success: true));
      } catch (error) {
        emit(CreateInventoryFailure(error: error.toString()));
      }
    } else {
      try {
        await FirebaseFirestore.instance
            .collection('inventories')
            .doc(event.uuid)
            .set({
          event.name: {
            'name': event.name,
            'description': event.description ?? '',
            'providers': event.providers,
            'asset': event.asset,
          },
        });
        emit(const CreateInventorySuccess(success: true));
      } catch (error) {
        emit(CreateInventoryFailure(error: error.toString()));
      }
    }
  }
}

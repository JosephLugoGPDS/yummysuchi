import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'delete_product_event.dart';
part 'delete_product_state.dart';

class DeleteProductBloc extends Bloc<DeleteProductEvent, DeleteProductState> {
  DeleteProductBloc() : super(const DeleteProductInitial()) {
    on<DeleteNewProductEvent>(_onDeleteNewProductEvent);
  }

  void _onDeleteNewProductEvent(
      DeleteNewProductEvent event, Emitter<DeleteProductState> emit) async {
    emit(const DeleteProductLoading());

    // Get inventory
    CollectionReference inventoriesCollection =
        FirebaseFirestore.instance.collection('inventories');
    DocumentSnapshot inventorySnapshot =
        await inventoriesCollection.doc(event.uuid).get();

    debugPrint('inventorySnapshot: ${inventorySnapshot.data()}');

    Map<String, dynamic>? inventory;
    if (!inventorySnapshot.exists) {
      return;
    }
    inventory = inventorySnapshot.data() as Map<String, dynamic>?;

    if (inventory != null) {
      debugPrint('inventory: ${inventory[event.inventory]}');
      try {
        try {
          DocumentSnapshot snapshot =
              await inventoriesCollection.doc(event.uuid).get();
          Map<String, dynamic> inventoryData =
              snapshot.data() as Map<String, dynamic>; // Map<String, dynamic>?
          debugPrint(
              'inventoryData ---------------------: ${inventoryData[event.inventory]}');
          debugPrint(
              'inventoryData ----------------: ${inventoryData[event.inventory]['products']}');

          // Suponiendo que 'products' es la lista de productos en tu inventario
          List<dynamic> products = inventoryData[event.inventory]['products'];

          // Eliminar el producto en el índice especificado
          int indexToRemove = event.id;
          products.removeAt(indexToRemove);

          // Actualizar la lista de productos en el inventario
          inventoryData[event.inventory]['products'] = products;

          debugPrint('inventoryData: $inventoryData');
          // Actualizar el documento con el inventario modificado
          await inventoriesCollection.doc(event.uuid).set(inventoryData);
          emit(const DeleteProductSuccess());
        } catch (error) {
          emit(DeleteProductFailure(error: error.toString()));
        }
      } catch (error) {
        emit(DeleteProductFailure(error: error.toString()));
      }
    } else {
      emit(const DeleteProductFailure(
          error: 'Inventory does not exist in database'));
    }
  }
}

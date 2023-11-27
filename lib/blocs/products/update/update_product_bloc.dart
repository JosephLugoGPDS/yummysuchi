import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:inventario_yummy_sushi/model/inventory.dart';

part 'update_product_event.dart';
part 'update_product_state.dart';

class UpdateProductBloc extends Bloc<UpdateProductEvent, UpdateProductState> {
  UpdateProductBloc() : super(const UpdateProductInitial()) {
    on<UpdateNewProductEvent>(_onUpdateNewProductEvent);
  }

  void _onUpdateNewProductEvent(
      UpdateNewProductEvent event, Emitter<UpdateProductState> emit) async {
    emit(const UpdateProductLoading());

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
    inventory = inventorySnapshot.data() as Map<String, dynamic>;
    debugPrint('inventory: ${inventory[event.inventory]}');
    final inventoryModel = Inventory.fromJson(inventory[event.inventory]);
    // Get histories
    CollectionReference historiesCollection =
        FirebaseFirestore.instance.collection('history');
    DocumentSnapshot historySnapshot =
        await historiesCollection.doc(event.uuid).get();

    debugPrint('historySnapshot: ${historySnapshot.data()}');
    Map<String, dynamic>? history;

    history = historySnapshot.data() as Map<String, dynamic>;
    debugPrint('history: ${history[event.inventory]}');
    final List<dynamic>? historyData = history[event.inventory];
    if (inventoryModel.providers.isNotEmpty) {
      //update product
      debugPrint('products: ${inventory['products']}');
      debugPrint('products: ${inventory['products'].runtimeType}');
      for (var element
          in (inventory[inventoryModel.name]['products'] as List<dynamic>)) {
        debugPrint('element: $element');
        if (element['name'] == event.product.name) {
          element['stock'] = event.stock;
        }
      }
      inventory[inventoryModel.name] = {
        'name': inventoryModel.name,
        'description': inventoryModel.description ?? '',
        'providers': inventoryModel.providers,
        'asset': inventoryModel.asset,
        'products': inventory[inventoryModel.name]['products'],
      };
      //add new history
      history[inventoryModel.name] = [
        ...(historyData ?? []),
        {
          'name': event.product.name,
          'isUp': event.product.stock < event.stock,
          'after': event.stock,
          'before': event.product.stock,
          'date': DateFormat('yyyy-MM-dd').format(DateTime.now()),
        }
      ];

      try {
        await inventoriesCollection.doc(event.uuid).update(inventory);
        await historiesCollection.doc(event.uuid).update(history);
        emit(const UpdateProductSuccess());
      } catch (error) {
        emit(UpdateProductFailure(error: error.toString()));
      }
    } else {
      emit(const UpdateProductFailure(error: 'Unknown'));
    }
  }
}

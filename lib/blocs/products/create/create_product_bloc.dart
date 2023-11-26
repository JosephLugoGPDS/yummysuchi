import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:inventario_yummy_sushi/model/inventory.dart';

part 'create_product_event.dart';
part 'create_product_state.dart';

class CreateProductBloc extends Bloc<CreateProductEvent, CreateProductState> {
  CreateProductBloc() : super(const CreateProductInitial()) {
    on<CreateNewProductEvent>(_onCreateNewProductEvent);
  }

  void _onCreateNewProductEvent(
      CreateNewProductEvent event, Emitter<CreateProductState> emit) async {
    emit(const CreateProductLoading());
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

    if (inventoryModel.providers.isNotEmpty) {
      inventory[inventoryModel.name] = {
        'name': inventoryModel.name,
        'description': inventoryModel.description ?? '',
        'providers': inventoryModel.providers,
        'asset': inventoryModel.asset,
        'products': [
          ...(inventoryModel.products != null
              ? getProductsToJson(inventoryModel.products!)
              : []),
          {
            'name': event.productName,
            'id': inventoryModel.products?.length ?? 0,
            'stock': event.stock,
            'stockMin': event.stockMin,
            'stockMax': event.stockMax,
            'providers': event.providers,
            'date': DateFormat('yyyy-MM-dd').format(DateTime.now()),
          }
        ]
      };
      try {
        await inventoriesCollection.doc(event.uuid).update(inventory);
        emit(const CreateProductSuccess());
      } catch (error) {
        emit(CreateProductFailure(error: error.toString()));
      }
    } else {
      emit(const CreateProductFailure(error: 'Unknown'));
    }
  }
}

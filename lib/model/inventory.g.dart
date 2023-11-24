// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'inventory.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Inventory _$InventoryFromJson(Map<String, dynamic> json) => Inventory(
      name: json['name'] as String,
      products: (json['products'] as List<dynamic>?)
              ?.map((e) => Product.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
      providers:
          (json['providers'] as List<dynamic>).map((e) => e as String).toList(),
      description: json['description'] as String?,
      asset: json['asset'] as String,
    );

Map<String, dynamic> _$InventoryToJson(Inventory instance) => <String, dynamic>{
      'name': instance.name,
      'products': instance.products,
      'providers': instance.providers,
      'description': instance.description,
      'asset': instance.asset,
    };

Product _$ProductFromJson(Map<String, dynamic> json) => Product(
      date: json['date'] as String,
      id: json['id'] as int,
      name: json['name'] as String,
      stock: json['stock'] as int,
      stockMax: json['stockMax'] as int,
      stockMin: json['stockMin'] as int,
    );

Map<String, dynamic> _$ProductToJson(Product instance) => <String, dynamic>{
      'date': instance.date,
      'id': instance.id,
      'name': instance.name,
      'stock': instance.stock,
      'stockMax': instance.stockMax,
      'stockMin': instance.stockMin,
    };

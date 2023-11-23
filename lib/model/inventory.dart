import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';

part 'inventory.g.dart';

@JsonSerializable()
class Inventory {
  String name;
  List<Product> products;
  List<String> providers;
  String? description;
  String asset;

  Inventory({
    required this.name,
    required this.products,
    required this.providers,
    required this.description,
    required this.asset,
  });

  factory Inventory.fromJson(Map<String, dynamic> json) =>
      _$InventoryFromJson(json);
  Map<String, dynamic> toJson() => _$InventoryToJson(this);
}

@JsonSerializable()
class Product {
  String date;
  int id;
  String name;
  int stock;
  int stockMax;
  int stockMin;

  Product({
    required this.date,
    required this.id,
    required this.name,
    required this.stock,
    required this.stockMax,
    required this.stockMin,
  });

  factory Product.fromJson(Map<String, dynamic> json) =>
      _$ProductFromJson(json);
  Map<String, dynamic> toJson() => _$ProductToJson(this);
}

List<Inventory> getInventoriesFromJson(String jsonString) {
  final jsonData = json.decode(jsonString);
  return List<Inventory>.from(jsonData.map((x) => Inventory.fromJson(x)));
}

String getInventoriesToJson(List<Inventory> inventories) {
  final List<dynamic> jsonData = inventories.map((x) => x.toJson()).toList();
  return json.encode(jsonData);
}

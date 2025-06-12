import 'package:books/models/category_model.dart';

class InventoryResponse {
  final int limit;
  final int page;
  final List<Inventory> results;
  final int total;

  InventoryResponse({
    required this.limit,
    required this.page,
    required this.results,
    required this.total,
  });

  factory InventoryResponse.fromJson(Map<String, dynamic> json) {
    return InventoryResponse(
      limit: json['limit'],
      page: json['page'],
      results: List<Inventory>.from(json['results'].map((x) => Inventory.fromJson(x))),
      total: json['total'],
    );
  }
}

class Inventory {
  final int id;
  final String name;
  final int quantity;
  final int categoryId;
  final Category category;

  Inventory({
    required this.id,
    required this.name,
    required this.quantity,
    required this.categoryId,
    required this.category,
  });

  factory Inventory.fromJson(Map<String, dynamic> json) {
    return Inventory(
      id: json['id'],
      name: json['name'],
      quantity: json['quantity'],
      categoryId: json['category_id'],
      category: Category.fromJson(json['Category']),
    );
  }
}



import 'category_model.dart';

class Inventory {
  final int id;
  final String name;
  final int quantity;
  final int categoryId;
  final Category? category;
  

  Inventory({
    required this.id,
    required this.name,
    required this.quantity,
    required this.categoryId,
    this.category,
  });

  factory Inventory.fromJson(Map<String, dynamic> json) {
    return Inventory(
      id: json['id'],
      name: json['name'],
      quantity: json['quantity'],
      categoryId: json['category_id'],
      category: json['Category'] != null
          ? Category.fromJson(json['Category'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'quantity': quantity,
      'category_id': categoryId,
    };
  }
}

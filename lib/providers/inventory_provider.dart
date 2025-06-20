import 'package:flutter/material.dart';
import '../models/inventory_model.dart';
import '../services/inventory_service.dart';

class InventoryProvider extends ChangeNotifier {
  List<Inventory> inventories = [];

  Future<void> fetchInventories() async {
    inventories = await InventoryService.getAll();
    notifyListeners();
  }

  Future<void> addInventory(Inventory inventory) async {
    await InventoryService.create(inventory);
    await fetchInventories();
  }

  Future<void> updateInventory(Inventory inventory) async {
    await InventoryService.update(inventory);
    await fetchInventories();
  }

  Future<void> deleteInventory(int id) async {
    await InventoryService.delete(id);
    await fetchInventories();
  }
}

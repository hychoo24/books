import 'package:flutter/material.dart';
import '../../models/inventory_model.dart';

class InventoryDetail extends StatelessWidget {
  final Inventory inventory;

  const InventoryDetail({super.key, required this.inventory});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Detail Inventory')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('ID: ${inventory.id}', style: const TextStyle(fontSize: 18)),
            const SizedBox(height: 8),
            Text('Name: ${inventory.name}', style: const TextStyle(fontSize: 18)),
            const SizedBox(height: 8),
            Text('Total: ${inventory.quantity}', style: const TextStyle(fontSize: 18)),
            const SizedBox(height: 8),
            Text('Category: ${inventory.category?.name ?? "-"}', style: const TextStyle(fontSize: 18)),
          ],
        ),
      ),
    );
  }
}

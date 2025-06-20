import 'package:flutter/material.dart';
import '../../models/category_model.dart';

class CategoryDetailPage extends StatelessWidget {
  final Category category;

  const CategoryDetailPage({super.key, required this.category});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Detail Category')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('ID: ${category.id}', style: const TextStyle(fontSize: 18)),
            const SizedBox(height: 8),
            Text('Name: ${category.name}', style: const TextStyle(fontSize: 18)),
            const SizedBox(height: 8),
            Text('Description: ${category.description}', style: const TextStyle(fontSize: 18)),
            const SizedBox(height: 8),
          ],
        ),
      ),
    );
  }
}

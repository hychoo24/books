import 'package:flutter/material.dart';
import '../models/category_model.dart';
import '../services/category_service.dart';

class CategoryProvider with ChangeNotifier {
  List<Category> _categories = [];
  List<Category> get categories => _categories;

  Future<void> fetchCategories() async {
    _categories = await CategoryService.getAll();
    notifyListeners();
  }

  Future<void> addCategory(Category category) async {
    await CategoryService.create(category);
    await fetchCategories();
  }

  Future<void> updateCategory(int id, Category category) async {
    await CategoryService.update(category);
    await fetchCategories();
  }

  Future<void> deleteCategory(int id) async {
    await CategoryService.delete(id);
    await fetchCategories();
  }
}


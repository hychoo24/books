import 'package:books/api/dio_client.dart';
import 'package:books/models/category_model.dart';
import 'package:books/varglobal.dart';
import 'package:flutter/material.dart';

class CategoryProvider with ChangeNotifier {
  List<Category> _categories = [];

  List<Category> get categories => _categories;

  Future<void> fetchCategories() async {
    try {
      final response = await DioClient.dio.get('${Global.srvBase}/category');
      _categories = (response.data['results'] as List)
          .map((json) => Category.fromJson(json))
          .toList();
      notifyListeners();
    } catch (e) {
      print('Error loading categories: $e');
    }
  }
}

import 'package:dio/dio.dart';
import '../models/category_model.dart';
import '../utils/varglobal.dart';

class CategoryService {
  static final Dio _dio = Dio();

  static Future<List<Category>> getAll() async {
    final response = await _dio.get('${Global.srvBase}/category');
    return (response.data['results'] as List)
        .map((json) => Category.fromJson(json))
        .toList();
  }

  static Future<void> create(Category category) async {
    await _dio.post('${Global.srvBase}/category', data: category.toJson());
  }

  static Future<void> update(Category category) async {
    await _dio.put('${Global.srvBase}/category/${category.id}', data: category.toJson());
  }

  static Future<void> delete(int id) async {
    await _dio.delete('${Global.srvBase}/category/$id');
  }
}
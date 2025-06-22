import 'package:books/api/dio_client.dart';
import '../models/category_model.dart';
import '../utils/varglobal.dart';

class CategoryService {

  static Future<List<Category>> getAll() async {
    final response = await DioClient.dio.get('${Global.srvBase}/category');
    return (response.data['results'] as List)
        .map((json) => Category.fromJson(json))
        .toList();
  }

  static Future<void> create(Category category) async {
    await DioClient.dio.post('${Global.srvBase}/category', data: category.toJson());
  }

  static Future<void> update(Category category) async {
    await DioClient.dio.put('${Global.srvBase}/category/${category.id}', data: category.toJson());
  }

  static Future<void> delete(int id) async {
    await DioClient.dio.delete('${Global.srvBase}/category/$id');
  }
}
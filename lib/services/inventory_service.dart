import 'package:books/utils/varglobal.dart';
import 'package:dio/dio.dart';
import '../models/inventory_model.dart';

class InventoryService {
  static final Dio _dio = Dio();

  static Future<List<Inventory>> getAll() async {
    try {
      final response = await _dio.get('${Global.srvBase}/inventory');
      return (response.data['results'] as List)
          .map((json) => Inventory.fromJson(json))
          .toList();
    } catch (e) {
      throw Exception('Gagal mengambil data inventory: $e');
    }
  }

  static Future<void> create(Inventory inventory) async {
    await _dio.post('${Global.srvBase}/inventory', data: inventory.toJson());
  }

  static Future<void> update(Inventory inventory) async {
    await _dio.put('${Global.srvBase}/inventory/${inventory.id}', data: inventory.toJson());
  }

  static Future<void> delete(int id) async {
    await _dio.delete('${Global.srvBase}/inventory/$id');
  }
}

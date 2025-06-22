import 'package:books/api/dio_client.dart';
import 'package:books/utils/varglobal.dart';
import '../models/inventory_model.dart';

class InventoryService {

  static Future<List<Inventory>> getAll() async {
    try {
      final response = await DioClient.dio.get('${Global.srvBase}/inventory');
      return (response.data['results'] as List)
          .map((json) => Inventory.fromJson(json))
          .toList();
    } catch (e) {
      throw Exception('Gagal mengambil data inventory: $e');
    }
  }

  static Future<void> create(Inventory inventory) async {
    await DioClient.dio.post('${Global.srvBase}/inventory', data: inventory.toJson());
  }

  static Future<void> update(Inventory inventory) async {
    await DioClient.dio.put('${Global.srvBase}/inventory/${inventory.id}', data: inventory.toJson());
  }

  static Future<void> delete(int id) async {
    await DioClient.dio.delete('${Global.srvBase}/inventory/$id');
  }
}

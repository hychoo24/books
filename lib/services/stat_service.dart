import 'package:books/api/dio_client.dart';
import 'package:books/models/stat_model.dart';
import 'package:books/utils/varglobal.dart';

class StatService {
  static Future<StatsAll> fetchStats() async {
    final res = await DioClient.dio.get('${Global.srvBase}/home/stats');
    // print('DEBUG JSON: ${res.data}');
    if (res.statusCode == 200) {
      return StatsAll.fromJson(res.data);

    } else {
      throw Exception('Failed to load stats');
    }
  }
}

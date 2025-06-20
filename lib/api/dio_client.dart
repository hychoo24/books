import 'package:books/utils/varglobal.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

class DioClient {
  static final Dio dio = Dio(
    BaseOptions(
      baseUrl: Global.srvBase,
      connectTimeout: Duration(seconds: 10),
      receiveTimeout: Duration(seconds: 10),
      sendTimeout: kIsWeb ? Duration.zero : Duration(seconds: 10),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      },
      validateStatus: (status) {
        // Accept all status codes
        return status != null && status < 500;
      },
    ),
  );
}

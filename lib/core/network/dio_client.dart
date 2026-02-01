import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import '../utils/constants.dart';

class DioClient {
  final Dio _dio;
  final FlutterSecureStorage _storage;

  DioClient(this._dio, this._storage) {
    _dio
      ..options.baseUrl = AppConstants.baseUrl
      ..options.connectTimeout = const Duration(seconds: 10)
      ..options.receiveTimeout = const Duration(seconds: 10)
      ..options.responseType = ResponseType.json;

    _dio.interceptors.add(InterceptorsWrapper(
      onRequest: (options, handler) async {
        final token = await _storage.read(key: AppConstants.tokenKey);
        if (token != null) {
          options.headers['Authorization'] = 'Bearer $token';
        }
        return handler.next(options);
      },
      onError: (DioException e, handler) {
        print("Error: ${e.response?.statusCode} -> ${e.message}");
        return handler.next(e);
      },
    ));
  }

  Dio get dio => _dio;
}
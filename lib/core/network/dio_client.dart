import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import '../utils/constants.dart';
import '../../features/auth/presentation/pages/login_page.dart';

class DioClient {
  final Dio _dio;
  final FlutterSecureStorage _storage;

  DioClient(this._dio, this._storage) {
    _dio
      ..options.baseUrl = AppConstants.baseUrl
      ..options.connectTimeout = const Duration(seconds: 360)
      ..options.receiveTimeout = const Duration(seconds: 360)
      ..options.responseType = ResponseType.json;

    _dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) async {
          final token = await _storage.read(key: AppConstants.tokenKey);
          if (token != null) {
            options.headers['Authorization'] = 'Bearer $token';
          }
          options.headers['ngrok-skip-browser-warning'] = 'true';
          return handler.next(options);
        },

        onError: (DioException e, handler) async {
          if (e.response?.statusCode == 401) {
            await _storage.delete(key: AppConstants.tokenKey);

            Get.offAll(() => LoginPage());

            Get.snackbar("Session Expired", "Please login again");
          }
          return handler.next(e);
        },
      ),
    );
  }

  Dio get dio => _dio;
}

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import '../../../../core/network/dio_client.dart';
import '../../../../core/utils/constants.dart';
import '../../data/models/login_response_model.dart';

class AuthController extends GetxController {
  final DioClient dioClient = DioClient(Dio(), const FlutterSecureStorage());
  final storage = const FlutterSecureStorage();

  var isLoading = false.obs;

  final idController = TextEditingController();
  final passwordController = TextEditingController();

  Future<void> login() async {
    if (idController.text.isEmpty || passwordController.text.isEmpty) {
      Get.snackbar("Error", "Please fill all fields");
      return;
    }
    // 172.168.1.1/api/auth/login
    try {
      isLoading.value = true;
      final response = await dioClient.dio.post(
        '/auth/login/',
        data: {
          "university_id": idController.text,
          "password": passwordController.text,
        },
      );

      final loginData = LoginResponseModel.fromJson(response.data);
      await storage.write(key: AppConstants.tokenKey, value: loginData.access);

      if (loginData.role == "STUDENT") {
        Get.offAllNamed('/main');
      } else {
        // Get.offAllNamed('/employee_dashboard');
      }
    } on DioException catch (e) {
      Get.snackbar("Login Failed", "Unknown error");
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> logout() async {
    await storage.delete(key: AppConstants.tokenKey);
    Get.offAllNamed('/login');
  }
}

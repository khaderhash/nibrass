import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../core/network/dio_client.dart';
import '../../../../core/utils/constants.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import '../../data/models/student_home_models.dart';

class StudentHomeController extends GetxController {
  final DioClient dioClient = DioClient(Dio(), const FlutterSecureStorage());

  var isLoading = true.obs;
  var studentData = Rxn<StudentFullData>();

  final maintenanceDescController = TextEditingController();
  var selectedMaintenanceType = "ELECTRICITY".obs;

  @override
  void onInit() {
    fetchStudentData();
    super.onInit();
  }

  // 1. Fetch Data
  Future<void> fetchStudentData() async {
    try {
      isLoading.value = true;
      final response = await dioClient.dio.get('/auth/me/');
      studentData.value = StudentFullData.fromJson(response.data);
    } catch (e) {
      Get.snackbar("Error", "Failed to load profile");
    } finally {
      isLoading.value = false;
    }
  }

  bool get hasRoom => studentData.value?.room != null;

  Future<void> submitMaintenance() async {
    if (!hasRoom) {
      Get.snackbar("Error", "You must have a room to request maintenance!");
      return;
    }

    try {
      Get.dialog(const Center(child: CircularProgressIndicator()), barrierDismissible: false);

      await dioClient.dio.post('/maintenance/', data: {
        "kind": selectedMaintenanceType.value,
        "description": maintenanceDescController.text
      });

      Get.back();
      Get.back();
      Get.snackbar("Success", "Maintenance request submitted!");
      maintenanceDescController.clear();

    } catch (e) {
      Get.back();
      Get.snackbar("Error", "Failed to submit request");
    }
  }
}
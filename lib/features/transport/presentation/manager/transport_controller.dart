import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import '../../../../core/network/dio_client.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import '../../data/models/trip_model.dart';

class TransportController extends GetxController {
  final DioClient dioClient = DioClient(Dio(), const FlutterSecureStorage());

  var isLoading = true.obs;
  var tripsList = <TripModel>[].obs;

  @override
  void onInit() {
    fetchTrips();
    super.onInit();
  }

  void fetchTrips() async {
    try {
      isLoading.value = true;
      final response = await dioClient.dio.get('/transport/trips/');
      tripsList.value = (response.data as List)
          .map((e) => TripModel.fromJson(e))
          .toList();
    } catch (e) {
      Get.snackbar("Error", "Failed to load trips");
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> bookOneTrip(int tripId) async {
    await _performBookingAction(
      url: '/transport/trips/$tripId/book/',
      successMessage:
          "Seat booked successfully! A charge has been added to your account.",
    );
  }

  Future<void> confirmSemesterTrip(int tripId) async {
    await _performBookingAction(
      url: '/transport/trips/$tripId/confirm/',
      successMessage: "Trip confirmed with your semester plan.",
    );
  }

  Future<void> cancelTrip(int tripId) async {
    try {
      Get.dialog(
        const Center(child: CircularProgressIndicator()),
        barrierDismissible: false,
      );

      await dioClient.dio.post('/transport/trips/$tripId/cancel/');

      Get.back();
      Get.snackbar(
        "Cancelled",
        "Booking cancelled successfully.",
        backgroundColor: Colors.green,
        colorText: Colors.white,
      );

      fetchTrips();
    } on DioException catch (e) {
      Get.back();
      Get.snackbar(
        "Error",
        e.response?.data['detail'] ?? "Failed to cancel booking",
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }

  Future<void> _performBookingAction({
    required String url,
    required String successMessage,
  }) async {
    try {
      Get.dialog(
        const Center(child: CircularProgressIndicator()),
        barrierDismissible: false,
      );

      await dioClient.dio.post(url);

      Get.back();
      Get.snackbar(
        "Success",
        successMessage,
        backgroundColor: Colors.green,
        colorText: Colors.white,
      );
      fetchTrips();
    } on DioException catch (e) {
      Get.back();
      if (e.response != null && e.response!.data != null) {
        // errorMsg = e.response!.data.toString();
      }
      Get.snackbar(
        "Booking Failed",
        "already booked",
        backgroundColor: Colors.red,
        colorText: Colors.white,
        duration: const Duration(seconds: 4),
      );
    }
  }
}

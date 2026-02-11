import 'package:dio/dio.dart';
import 'package:get/get.dart';
import '../../../../core/network/dio_client.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import '../../data/models/explore_models.dart';

class ExploreController extends GetxController {
  final DioClient dioClient = DioClient(Dio(), const FlutterSecureStorage());

  var isLoading = true.obs;
  var servicesList = <PublicServiceModel>[].obs;
  var roomsList = <AvailableRoomModel>[].obs;

  @override
  void onInit() {
    fetchAllData();
    super.onInit();
  }

  void fetchAllData() async {
    try {
      isLoading.value = true;

      final servicesRes = await dioClient.dio.get('/services/');
      servicesList.value = (servicesRes.data as List)
          .map((e) => PublicServiceModel.fromJson(e))
          .toList();

      final roomsRes = await dioClient.dio.get('/housing/available-rooms/');
      roomsList.value = (roomsRes.data as List)
          .map((e) => AvailableRoomModel.fromJson(e))
          .toList();
    } catch (e) {
      print("Explore Error: $e");
      Get.snackbar("Error", "Could not load data");
    } finally {
      isLoading.value = false;
    }
  }
}

import 'package:dio/dio.dart';
import 'package:get/get.dart';
import '../../../../core/network/dio_client.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import '../../data/models/finance_models.dart';

class FinanceController extends GetxController {
  final DioClient dioClient = DioClient(Dio(), const FlutterSecureStorage());

  var isLoading = true.obs;
  var balance = "0.00".obs;
  var transactions = <TransactionModel>[].obs;

  @override
  void onInit() {
    fetchFinanceData();
    super.onInit();
  }

  Future<void> fetchFinanceData() async {
    try {
      isLoading.value = true;

      final balanceRes = await dioClient.dio.get('/finance/balance/');
      balance.value = BalanceModel.fromJson(balanceRes.data).balance;

      final historyRes = await dioClient.dio.get('/finance/history/');
      transactions.value = (historyRes.data as List)
          .map((e) => TransactionModel.fromJson(e))
          .toList();
    } catch (e) {
      Get.snackbar("Error", "Could not load finance data");
    } finally {
      isLoading.value = false;
    }
  }
}

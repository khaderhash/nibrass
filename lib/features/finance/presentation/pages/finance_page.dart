import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../manager/finance_controller.dart';
import '../../data/models/finance_models.dart';

class FinancePage extends StatelessWidget {
  final FinanceController controller = Get.put(FinanceController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("My Wallet"), centerTitle: true),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        // --- منطق الألوان (Logic) ---
        double balanceValue = double.tryParse(controller.balance.value) ?? 0.0;
        bool isDebt = balanceValue > 0;
        bool isCredit = balanceValue < 0;

        Color cardColor1 = isDebt
            ? Colors.red.shade900
            : (isCredit ? Colors.green.shade800 : Colors.blue.shade900);
        Color cardColor2 = isDebt
            ? Colors.red.shade600
            : (isCredit ? Colors.green.shade600 : Colors.blue.shade600);

        String titleText = isDebt
            ? "Current Balance (To Pay)"
            : (isCredit ? "Available Credit" : "Current Balance");
        String subText = isDebt
            ? "Visit office to pay"
            : (isCredit ? "You have extra credit" : "No pending payments");
        // -----------------------------

        // --- التصحيح هنا: RefreshIndicator يحتوي الـ ListView كـ child ---
        return RefreshIndicator(
          onRefresh: () async {
            await controller.fetchFinanceData();
          },
          child: ListView(
            physics: const AlwaysScrollableScrollPhysics(), // يسمح بالسحب
            padding: const EdgeInsets.only(bottom: 20),
            children: [
              // 1. بطاقة الرصيد
              Container(
                width: double.infinity,
                margin: const EdgeInsets.all(16),
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  gradient: LinearGradient(colors: [cardColor1, cardColor2]),
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: cardColor2.withOpacity(0.3),
                      blurRadius: 10,
                      offset: const Offset(0, 5),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    Text(
                      titleText,
                      style: const TextStyle(
                        color: Colors.white70,
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      "\$${controller.balance.value}",
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 40,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      subText,
                      style: const TextStyle(
                        color: Colors.white54,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ),

              // 2. العنوان
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Transaction History",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ),
              ),

              // 3. قائمة العمليات
              if (controller.transactions.isEmpty)
                const Padding(
                  padding: EdgeInsets.only(top: 50),
                  child: Center(child: Text("No transactions yet.")),
                )
              else
                // استخدام Spread Operator (...) لتوزيع العناصر
                ...controller.transactions.map((tx) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: _buildTxTile(tx),
                  );
                }).toList(),
            ],
          ),
        );
      }),
    );
  }

  Widget _buildTxTile(TransactionModel tx) {
    final isPaid = tx.status == "PAID";
    final isVoid = tx.status == "VOID";

    Color statusColor = Colors.red;
    if (isPaid) statusColor = Colors.green;
    if (isVoid) statusColor = Colors.grey;

    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: statusColor.withOpacity(0.1),
          child: Icon(
            isPaid ? Icons.check : Icons.access_time,
            color: statusColor,
          ),
        ),
        title: Text(
          tx.title,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Text(tx.formattedDate),
        trailing: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              "\$${tx.amount}",
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            Text(
              tx.status,
              style: TextStyle(
                color: statusColor,
                fontSize: 12,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

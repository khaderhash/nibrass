import 'package:intl/intl.dart';

class TransactionModel {
  final int id;
  final String title;
  final String amount;
  final String status;
  final String createdAt;

  TransactionModel({
    required this.id,
    required this.title,
    required this.amount,
    required this.status,
    required this.createdAt,
  });

  factory TransactionModel.fromJson(Map<String, dynamic> json) {
    return TransactionModel(
      id: json['id'],
      title: json['title'],
      amount: json['amount'],
      status: json['status'],
      createdAt: json['created_at'],
    );
  }

  String get formattedDate {
    final date = DateTime.parse(createdAt);
    return DateFormat('MMM d, yyyy').format(date);
  }
}

class BalanceModel {
  final String balance;
  BalanceModel({required this.balance});
  factory BalanceModel.fromJson(Map<String, dynamic> json) {
    return BalanceModel(balance: json['balance']);
  }
}

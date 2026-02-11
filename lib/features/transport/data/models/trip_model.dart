import 'package:intl/intl.dart';

class TripModel {
  final int id;
  final String destination;
  final String busCode;
  final String departureTime;
  final String price;
  final String status;
  final int availableSeats;

  TripModel({
    required this.id,
    required this.destination,
    required this.busCode,
    required this.departureTime,
    required this.price,
    required this.status,
    required this.availableSeats,
  });
  factory TripModel.fromJson(Map<String, dynamic> json) {
    return TripModel(
      id: json['id'],
      destination: json['destination']['name'],
      busCode: json['bus']['code'],
      departureTime: json['departure_datetime'],
      price: json['price'],
      status: json['status'],
      availableSeats: json['available_seats'],
    );
  }

  String get formattedDate {
    final date = DateTime.parse(departureTime);
    return DateFormat('EEE, MMM d • h:mm a').format(date);
  }
}

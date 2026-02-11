class PublicServiceModel {
  final int id;
  final String name;
  final String price;
  final String openingTime;
  final String closingTime;
  final String days;

  PublicServiceModel({
    required this.id,
    required this.name,
    required this.price,
    required this.openingTime,
    required this.closingTime,
    required this.days,
  });

  factory PublicServiceModel.fromJson(Map<String, dynamic> json) {
    return PublicServiceModel(
      id: json['id'],
      name: json['name'],
      price: json['price'],
      openingTime: json['opening_time'],
      closingTime: json['closing_time'],
      days: json['days_of_week'],
    );
  }
}

class AvailableRoomModel {
  final int id;
  final String dormCode;
  final String roomCode;
  final int floor;
  final String monthlyFee;
  final String electricityFee;

  AvailableRoomModel({
    required this.id,
    required this.dormCode,
    required this.roomCode,
    required this.floor,
    required this.monthlyFee,
    required this.electricityFee,
  });

  factory AvailableRoomModel.fromJson(Map<String, dynamic> json) {
    return AvailableRoomModel(
      id: json['id'],
      dormCode: json['dorm']['dorm_code'],
      roomCode: json['room_code'],
      floor: json['floor'],
      monthlyFee: json['monthly_fee'],
      electricityFee: json['electricity_fee'],
    );
  }
}

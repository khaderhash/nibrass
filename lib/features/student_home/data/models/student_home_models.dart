class StudentFullData {
  final String firstName;
  final String major;
  final RoomModel? room; // Nullable
  final List<ServiceSubModel> services;

  StudentFullData({
    required this.firstName,
    required this.major,
    this.room,
    required this.services,
  });

  factory StudentFullData.fromJson(Map<String, dynamic> json) {
    return StudentFullData(
      firstName: json['user']['first_name'],
      major: json['student_profile']['major'],
      room: json['room'] != null ? RoomModel.fromJson(json['room']) : null,
      services: (json['services'] as List)
          .map((e) => ServiceSubModel.fromJson(e))
          .toList(),
    );
  }
}

class RoomModel {
  final String dormCode;
  final String roomCode;
  final int floor;

  RoomModel({
    required this.dormCode,
    required this.roomCode,
    required this.floor,
  });

  factory RoomModel.fromJson(Map<String, dynamic> json) {
    return RoomModel(
      dormCode: json['dorm_code'],
      roomCode: json['room_code'],
      floor: json['floor'],
    );
  }
}

class ServiceSubModel {
  final String name;
  final String status;

  ServiceSubModel({required this.name, required this.status});

  factory ServiceSubModel.fromJson(Map<String, dynamic> json) {
    return ServiceSubModel(
      name: json['service']['name'],
      status: json['subscription'] != null
          ? json['subscription']['status']
          : "NOT_SUBSCRIBED",
    );
  }
}

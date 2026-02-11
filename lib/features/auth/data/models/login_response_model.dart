import '../../domain/entities/user_entity.dart';

class LoginResponseModel extends UserEntity {
  final String access;
  final String refresh;

  LoginResponseModel({
    required String universityId,
    required String firstName,
    required String lastName,
    required String role,
    required this.access,
    required this.refresh,
  }) : super(
         universityId: universityId,
         firstName: firstName,
         lastName: lastName,
         role: role,
       );

  factory LoginResponseModel.fromJson(Map<String, dynamic> json) {
    return LoginResponseModel(
      access: json['access'],
      refresh: json['refresh'],
      universityId: json['user']['university_id'],
      firstName: json['user']['first_name'],
      lastName: json['user']['last_name'],
      role: json['user']['role'],
    );
  }
}

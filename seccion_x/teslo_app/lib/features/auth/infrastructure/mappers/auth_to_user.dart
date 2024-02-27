import 'package:teslo_shop/features/auth/auth.dart';

class AuthMapper {
  static User userJsonToEntity(Map<String, dynamic> json) {
    return User(
      id: json["id"],
      email: json["email"],
      fullName:json ["fullName"],
      token: json["token"] ?? '',
      roles: List<String>.from(json["roles"].map((role) => role)),
    );
  }
}

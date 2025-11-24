// lib/features/auth/data/models/user_model.dart
import 'package:safetrek_app/features/auth/domain/entities/user.dart';

// UserModel là một bản mở rộng của User Entity, chứa các phương thức
// để chuyển đổi từ/đến JSON (từ API).
class UserModel extends User {
  const UserModel({
    required super.id,
    required super.email,
    super.fullName,
    super.profilePictureUrl,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'] as String,
      email: json['email'] as String,
      fullName: json['fullName'] as String?,
      profilePictureUrl: json['profilePictureUrl'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'email': email,
      'fullName': fullName,
      'profilePictureUrl': profilePictureUrl,
    };
  }
}
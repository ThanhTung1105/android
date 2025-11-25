import 'package:equatable/equatable.dart';

// Đây là Entity (model) của người dùng, độc lập với tầng dữ liệu hoặc UI
class User extends Equatable {
  final String id;
  final String email;
  final String? fullName; // Có thể null
  final String? profilePictureUrl; // Có thể null

  const User({
    required this.id,
    required this.email,
    this.fullName,
    this.profilePictureUrl,
  });

  @override
  List<Object?> get props => [id, email, fullName, profilePictureUrl];
}
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
// lib/features/auth/domain/entities/user.dart
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
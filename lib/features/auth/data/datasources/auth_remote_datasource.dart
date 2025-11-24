// lib/features/auth/data/datasources/auth_remote_datasource.dart
import 'package:safetrek_app/features/auth/data/models/user_model.dart'; // Sẽ tạo sau

// Đây là abstraction (interface) cho Auth Remote Datasource.
// Nó định nghĩa các phương thức để tương tác với API.
// Class implement interface này sẽ chứa logic gọi API thực tế.
abstract class AuthRemoteDataSource {
  Future<UserModel> login(String email, String password);
  Future<UserModel> register(String email, String password);
  Future<void> forgotPassword(String email);
  Future<void> resetPassword(String email, String newPassword);
  Future<void> logout();
  Future<UserModel?> getCurrentUser();
}
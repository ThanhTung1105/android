// lib/services/auth_service.dart
import 'package:dio/dio.dart'; // Vẫn cần Dio để injection hoạt động sau này
import '../models/user.dart'; // Import User model từ vị trí mới

class AuthService {
  final Dio dio;

  AuthService({required this.dio});

  // Biến lưu tạm user đang đăng nhập trong bộ nhớ (cho mock data)
  User? _currentUser;
  User? get currentUser => _currentUser;

  // Hàm đăng nhập mock
  Future<User> login(String email, String password) async {
    await Future.delayed(const Duration(seconds: 2)); // Giả lập trễ mạng

    if (password == '123456') {
      final fakeUser = User(
        id: 'user_123',
        email: email,
        fullName: 'Người dùng Test',
        profilePictureUrl: null,
      );
      _currentUser = fakeUser;
      return fakeUser;
    } else {
      throw Exception('Mật khẩu sai! Hãy thử 123456 (Mock Service)');
    }
  }

  // Hàm đăng ký mock
  Future<User> register(String email, String password) async {
    await Future.delayed(const Duration(seconds: 2));

    final newUser = User(
      id: 'user_new_${DateTime.now().millisecondsSinceEpoch}',
      email: email,
      fullName: 'Người dùng Mới',
      profilePictureUrl: null,
    );
    _currentUser = newUser;
    return newUser;
  }

  // Các hàm khác (mock)
  Future<void> forgotPassword(String email) async {
    await Future.delayed(const Duration(seconds: 2));
    print('Service: Đã gửi email fake đến $email');
  }

  Future<void> resetPassword(String email, String newPassword) async {
    await Future.delayed(const Duration(seconds: 2));
    print('Service: Đã đổi mật khẩu fake cho $email');
  }

  Future<void> logout() async {
    await Future.delayed(const Duration(seconds: 1));
    _currentUser = null;
  }

  // Hàm kiểm tra trạng thái đăng nhập
  Future<bool> checkLoginStatus() async {
    await Future.delayed(const Duration(milliseconds: 500));
    return _currentUser != null;
  }
}
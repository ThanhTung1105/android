// lib/features/auth/data/datasources/auth_remote_datasource_impl.dart
import 'package:dio/dio.dart';
import 'package:safetrek_app/features/auth/data/datasources/auth_remote_datasource.dart';
import 'package:safetrek_app/features/auth/data/models/user_model.dart';

// PHIÊN BẢN MOCK (GIẢ LẬP) - DÙNG ĐỂ TEST FRONTEND KHI CHƯA CÓ BACKEND
class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final Dio dio;

  AuthRemoteDataSourceImpl({required this.dio});

  UserModel? _currentUser;

  @override
  Future<UserModel> login(String email, String password) async {
    await Future.delayed(const Duration(seconds: 2));

    if (password == '123456') { // Đây là mật khẩu để đăng nhập thành công
      final fakeUser = UserModel(
        id: 'user_123',
        email: email,
        fullName: 'Người dùng Test',
        profilePictureUrl: null,
      );
      _currentUser = fakeUser;
      return fakeUser;
    } else {
      throw Exception('Mật khẩu sai! Hãy thử 123456');
    }
  }

  @override
  Future<UserModel> register(String email, String password) async {
    await Future.delayed(const Duration(seconds: 2));

    final newUser = UserModel(
      id: 'user_new_${DateTime.now().millisecondsSinceEpoch}',
      email: email,
      fullName: 'Người dùng Mới',
      profilePictureUrl: null,
    );
    _currentUser = newUser;
    return newUser;
  }

  @override
  Future<void> forgotPassword(String email) async {
    await Future.delayed(const Duration(seconds: 2));
    print('Đã gửi email fake đến $email');
  }

  @override
  Future<void> resetPassword(String email, String newPassword) async {
    await Future.delayed(const Duration(seconds: 2));
    print('Đã đổi mật khẩu fake cho $email thành $newPassword');
  }

  @override
  Future<void> logout() async {
    await Future.delayed(const Duration(seconds: 1));
    _currentUser = null;
  }

  @override
  Future<UserModel?> getCurrentUser() async {
    await Future.delayed(const Duration(milliseconds: 500));
    return _currentUser;
  }
}
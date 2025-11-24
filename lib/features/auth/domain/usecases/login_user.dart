// lib/features/auth/domain/usecases/login_user.dart
import 'package:safetrek_app/features/auth/domain/entities/user.dart';
import 'package:safetrek_app/features/auth/domain/repositories/auth_repository.dart';
import 'package:dartz/dartz.dart'; // THÊM DÒNG NÀY
import 'package:safetrek_app/core/error/failures.dart'; // THÊM DÒNG NÀY
// Use Case để đăng nhập người dùng
class LoginUser {
  final AuthRepository repository;

  LoginUser(this.repository);

  Future<Either<Failure, User>> call(String email, String password) async {
    return await repository.login(email, password);
  }
}
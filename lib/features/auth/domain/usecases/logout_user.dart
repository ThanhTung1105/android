// lib/features/auth/domain/usecases/logout_user.dart
import 'package:safetrek_app/features/auth/domain/repositories/auth_repository.dart';
import 'package:dartz/dartz.dart'; // THÊM DÒNG NÀY
import 'package:safetrek_app/core/error/failures.dart'; // THÊM DÒNG NÀY
// Use Case để đăng xuất người dùng
class LogoutUser {
  final AuthRepository repository;

  LogoutUser(this.repository);

  Future<Either<Failure, void>> call() async {
    return await repository.logout();
  }
}
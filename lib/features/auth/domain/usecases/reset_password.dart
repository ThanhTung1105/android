// lib/features/auth/domain/usecases/reset_password.dart
import 'package:safetrek_app/features/auth/domain/repositories/auth_repository.dart';
import 'package:dartz/dartz.dart'; // THÊM DÒNG NÀY
import 'package:safetrek_app/core/error/failures.dart'; // THÊM DÒNG NÀY
// Use Case để đặt lại mật khẩu
class ResetPassword {
  final AuthRepository repository;

  ResetPassword(this.repository);

  Future<Either<Failure, void>> call(String email, String newPassword) async {
    return await repository.resetPassword(email, newPassword);
  }
}
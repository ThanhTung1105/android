// lib/features/auth/domain/usecases/forgot_password.dart
import 'package:safetrek_app/features/auth/domain/repositories/auth_repository.dart';
import 'package:dartz/dartz.dart'; // THÊM DÒNG NÀY
import 'package:safetrek_app/core/error/failures.dart'; // THÊM DÒNG NÀY
// Use Case để gửi yêu cầu quên mật khẩu
class ForgotPassword {
  final AuthRepository repository;

  ForgotPassword(this.repository);

  Future<Either<Failure, void>> call(String email) async {
    return await repository.forgotPassword(email);
  }
}
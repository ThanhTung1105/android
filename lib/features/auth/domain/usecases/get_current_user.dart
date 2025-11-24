// lib/features/auth/domain/usecases/get_current_user.dart
import 'package:safetrek_app/features/auth/domain/entities/user.dart';
import 'package:safetrek_app/features/auth/domain/repositories/auth_repository.dart';
import 'package:dartz/dartz.dart'; // THÊM DÒNG NÀY
import 'package:safetrek_app/core/error/failures.dart'; // THÊM DÒNG NÀY
// Use Case để lấy thông tin người dùng hiện tại
class GetCurrentUser {
  final AuthRepository repository;

  GetCurrentUser(this.repository);

  Future<Either<Failure, User?>> call() async {
    return await repository.getCurrentUser();
  }
}
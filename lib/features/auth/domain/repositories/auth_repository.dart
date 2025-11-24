// lib/features/auth/domain/repositories/auth_repository.dart
import 'package:dartz/dartz.dart'; // THÊM DÒNG NÀY
import 'package:safetrek_app/core/error/failures.dart'; // THÊM DÒNG NÀY
import 'package:safetrek_app/features/auth/domain/entities/user.dart';

// Đây là abstraction (interface) cho Auth Repository.
// Nó định nghĩa những hành động liên quan đến Auth mà ứng dụng cần.
// Tầng data sẽ implement interface này.
abstract class AuthRepository {
  Future<Either<Failure, User>> login(String email, String password);
  Future<Either<Failure, User>> register(String email, String password);
  Future<Either<Failure, void>> forgotPassword(String email); // Trả về void nếu thành công
  Future<Either<Failure, void>> resetPassword(String email, String newPassword); // Trả về void nếu thành công
  Future<Either<Failure, void>> logout(); // Trả về void nếu thành công
  Future<Either<Failure, User?>> getCurrentUser(); // Trả về User hoặc null nếu chưa đăng nhập
}
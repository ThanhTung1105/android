// lib/features/auth/data/repositories/auth_repository_impl.dart
import 'package:dartz/dartz.dart'; // THÊM DÒNG NÀY
import 'package:safetrek_app/core/error/exceptions.dart'; // THÊM DÒNG NÀY
import 'package:safetrek_app/core/error/failures.dart'; // THÊM DÒNG NÀY
import 'package:safetrek_app/features/auth/data/datasources/auth_remote_datasource.dart';
import 'package:safetrek_app/features/auth/domain/entities/user.dart';
import 'package:safetrek_app/features/auth/domain/repositories/auth_repository.dart';

// Triển khai của AuthRepository, lấy dữ liệu từ datasource
class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource remoteDataSource;

  AuthRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<Failure, User>> login(String email, String password) async {
    try {
      final userModel = await remoteDataSource.login(email, password);
      return Right(userModel); // Thành công, trả về Right với UserModel
    } on UnauthorizedException catch (e) {
      return Left(AuthFailure(message: e.message)); // Bắt lỗi xác thực
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message)); // Bắt lỗi server chung
    } on NoInternetException {
      return const Left(NetworkFailure()); // Bắt lỗi mất mạng
    } on FormatException catch (e) {
      return Left(InputValidationFailure(message: e.message)); // Lỗi định dạng dữ liệu
    } catch (e) {
      return Left(UnknownFailure(message: e.toString())); // Lỗi không xác định
    }
  }

  @override
  Future<Either<Failure, User>> register(String email, String password) async {
    try {
      final userModel = await remoteDataSource.register(email, password);
      return Right(userModel);
    } on UnauthorizedException catch (e) {
      return Left(AuthFailure(message: e.message));
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message));
    } on NoInternetException {
      return const Left(NetworkFailure());
    } on FormatException catch (e) {
      return Left(InputValidationFailure(message: e.message));
    } catch (e) {
      return Left(UnknownFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> forgotPassword(String email) async {
    try {
      await remoteDataSource.forgotPassword(email);
      return const Right(null); // Thành công, trả về null cho kiểu void
    } on UnauthorizedException catch (e) {
      return Left(AuthFailure(message: e.message));
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message));
    } on NoInternetException {
      return const Left(NetworkFailure());
    } catch (e) {
      return Left(UnknownFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> resetPassword(String email, String newPassword) async {
    try {
      await remoteDataSource.resetPassword(email, newPassword);
      return const Right(null);
    } on UnauthorizedException catch (e) {
      return Left(AuthFailure(message: e.message));
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message));
    } on NoInternetException {
      return const Left(NetworkFailure());
    } catch (e) {
      return Left(UnknownFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> logout() async {
    try {
      await remoteDataSource.logout();
      return const Right(null);
    } on UnauthorizedException catch (e) {
      return Left(AuthFailure(message: e.message));
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message));
    } on NoInternetException {
      return const Left(NetworkFailure());
    } catch (e) {
      return Left(UnknownFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, User?>> getCurrentUser() async {
    try {
      final userModel = await remoteDataSource.getCurrentUser();
      return Right(userModel);
    } on UnauthorizedException catch (e) {
      return Left(AuthFailure(message: e.message));
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message));
    } on NoInternetException {
      return const Left(NetworkFailure());
    } catch (e) {
      return Left(UnknownFailure(message: e.toString()));
    }
  }
}
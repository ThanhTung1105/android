// lib/core/error/failures.dart
import 'package:equatable/equatable.dart';

// Base Failure cho tất cả các lỗi nghiệp vụ trong ứng dụng
abstract class Failure extends Equatable {
  final String message;
  final List properties;

  const Failure({required this.message, this.properties = const []});

  @override
  List<Object> get props => [message, properties];
}

// Lỗi khi server gặp sự cố hoặc phản hồi không hợp lệ
class ServerFailure extends Failure {
  const ServerFailure({required super.message});
}

// Lỗi khi không có kết nối internet
class NetworkFailure extends Failure {
  const NetworkFailure({super.message = 'Vui lòng kiểm tra kết nối internet của bạn.'});
}

// Lỗi khi dữ liệu cục bộ gặp sự cố
class CacheFailure extends Failure {
  const CacheFailure({required super.message});
}

// Lỗi khi xác thực không thành công (email/mật khẩu sai, token hết hạn)
class AuthFailure extends Failure {
  const AuthFailure({required super.message});
}

// Lỗi khi dữ liệu đầu vào không hợp lệ
class InputValidationFailure extends Failure {
  const InputValidationFailure({required super.message});
}

// Lỗi khi tài nguyên không tìm thấy
class NotFoundFailure extends Failure {
  const NotFoundFailure({super.message = 'Không tìm thấy tài nguyên yêu cầu.'});
}

// Lỗi chung không xác định
class UnknownFailure extends Failure {
  const UnknownFailure({super.message = 'Đã xảy ra lỗi không xác định.'});
}
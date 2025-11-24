// lib/core/error/exceptions.dart

// Base Exception cho tất cả các lỗi trong ứng dụng
abstract class AppRuntimeException implements Exception {
  final String message;
  const AppRuntimeException({required this.message});

  @override
  String toString() => 'AppRuntimeException: $message';
}

// Exception cho các lỗi phía server (HTTP status codes 4xx, 5xx)
class ServerException extends AppRuntimeException {
  final int? statusCode;
  const ServerException({required super.message, this.statusCode});

  @override
  String toString() => 'ServerException: $message (Status: $statusCode)';
}

// Exception cho các lỗi phía client (ví dụ: request không hợp lệ)
class ClientException extends AppRuntimeException {
  const ClientException({required super.message});

  @override
  String toString() => 'ClientException: $message';
}

// Exception khi không có kết nối internet
class NoInternetException extends AppRuntimeException {
  const NoInternetException({super.message = 'Không có kết nối internet.'});

  @override
  String toString() => 'NoInternetException: $message';
}

// Exception khi dữ liệu cục bộ không tìm thấy hoặc bị lỗi
class CacheException extends AppRuntimeException {
  const CacheException({required super.message});

  @override
  String toString() => 'CacheException: $message';
}

// Exception cho các lỗi xác thực (ví dụ: token hết hạn, thông tin đăng nhập sai)
class UnauthorizedException extends ServerException {
  const UnauthorizedException({super.message = 'Không được phép. Vui lòng đăng nhập lại.', super.statusCode = 401});

  @override
  String toString() => 'UnauthorizedException: $message (Status: $statusCode)';
}

// Exception khi không tìm thấy tài nguyên (HTTP 404)
class NotFoundException extends ServerException {
  const NotFoundException({super.message = 'Không tìm thấy tài nguyên.', super.statusCode = 404});

  @override
  String toString() => 'NotFoundException: $message (Status: $statusCode)';
}

// Exception khi có lỗi định dạng dữ liệu (ví dụ: JSON không hợp lệ)
class FormatException extends AppRuntimeException {
  const FormatException({super.message = 'Lỗi định dạng dữ liệu.'});

  @override
  String toString() => 'FormatException: $message';
}

// Exception chung cho các lỗi không xác định
class UnknownException extends AppRuntimeException {
  const UnknownException({super.message = 'Đã xảy ra lỗi không xác định.'});

  @override
  String toString() => 'UnknownException: $message';
}
// lib/core/api_constants.dart

class ApiConstants {
  static const String baseUrl = 'http://192.168.0.102:3000/api/v1'; // ĐỊA CHỈ IP CỦA BẠN HOẶC IP SERVER

  // Auth Endpoints
  static const String loginEndpoint = '/auth/login';
  static const String registerEndpoint = '/auth/register';
  static const String forgotPasswordEndpoint = '/auth/forgot-password';
  static const String resetPasswordEndpoint = '/auth/reset-password';
  static const String meEndpoint = '/auth/me'; // Để lấy thông tin người dùng hiện tại
}
// lib/features/auth/presentation/auth_state.dart
import 'package:equatable/equatable.dart';
import '../models/user.dart';

// Base state cho Auth
abstract class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object?> get props => [];
}

// Trạng thái khởi tạo/rảnh rỗi
class AuthInitial extends AuthState {}

// Đang xử lý (ví dụ: đang đăng nhập/đăng ký)
class AuthLoading extends AuthState {}

// Đăng nhập/Đăng ký thành công
class AuthSuccess extends AuthState {
  final User user;
  const AuthSuccess(this.user);

  @override
  List<Object?> get props => [user];
}

// Đăng xuất thành công
class AuthLoggedOut extends AuthState {}

// Có lỗi xảy ra
class AuthError extends AuthState {
  final String message;
  const AuthError(this.message);

  @override
  List<Object?> get props => [message];
}
// Trạng thái khi gửi email quên mật khẩu thành công
class AuthPasswordResetEmailSent extends AuthState {}

// Trạng thái khi đặt lại mật khẩu thành công
class AuthPasswordResetSuccess extends AuthState {}
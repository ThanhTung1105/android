// lib/features/auth/presentation/auth_view_model.dart
import 'package:flutter/material.dart';
import 'package:safetrek_app/features/auth/domain/usecases/forgot_password.dart';
import 'package:safetrek_app/features/auth/domain/usecases/get_current_user.dart';
import 'package:safetrek_app/features/auth/domain/usecases/login_user.dart';
import 'package:safetrek_app/features/auth/domain/usecases/logout_user.dart';
import 'package:safetrek_app/features/auth/domain/usecases/register_user.dart';
import 'package:safetrek_app/features/auth/domain/usecases/reset_password.dart';
import 'package:safetrek_app/features/auth/presentation/auth_state.dart';
import 'package:safetrek_app/core/error/failures.dart'; // THÊM DÒNG NÀY
// ... các import cũ ...
import 'package:safetrek_app/features/auth/domain/entities/user.dart'; // THÊM DÒNG NÀY

// AuthViewModel sẽ quản lý trạng thái xác thực và tương tác với các Use Cases
class AuthViewModel extends ChangeNotifier {
  final LoginUser loginUser;
  final RegisterUser registerUser;
  final ForgotPassword forgotPasswordUseCase;
  final ResetPassword resetPasswordUseCase;
  final LogoutUser logoutUser;
  final GetCurrentUser getCurrentUserUseCase;
  User? _currentUser;
  User? get currentUser => _currentUser;

  AuthState _state = AuthInitial();
  AuthState get state => _state;

  AuthViewModel({
    required this.loginUser,
    required this.registerUser,
    required this.forgotPasswordUseCase,
    required this.resetPasswordUseCase,
    required this.logoutUser,
    required this.getCurrentUserUseCase,
  });

  void _setState(AuthState newState) {
    _state = newState;
    if (newState is AuthSuccess) {
      _currentUser = newState.user;
    } else if (newState is AuthLoggedOut) {
      _currentUser = null; // Xóa user khi đăng xuất
    }
    notifyListeners(); // Thông báo cho các widget lắng nghe về sự thay đổi trạng thái
  }

  Future<void> performLogin(String email, String password) async {
    _setState(AuthLoading());
    final result = await loginUser(email, password);
    result.fold(
          (failure) => _setState(AuthError(_mapFailureToMessage(failure))),
          (user) => _setState(AuthSuccess(user)),
    );
  }

  Future<void> performRegister(String email, String password) async {
    _setState(AuthLoading());
    final result = await registerUser(email, password);
    result.fold(
          (failure) => _setState(AuthError(_mapFailureToMessage(failure))),
          (user) => _setState(AuthSuccess(user)),
    );
  }

  Future<void> performForgotPassword(String email) async {
    _setState(AuthLoading());
    final result = await forgotPasswordUseCase(email);
    result.fold(
          (failure) => _setState(AuthError(_mapFailureToMessage(failure))),
      // SỬA DÒNG DƯỚI: Thay AuthInitial() bằng AuthPasswordResetEmailSent()
          (_) => _setState(AuthPasswordResetEmailSent()),
    );
  }

  Future<void> performResetPassword(String email, String newPassword) async {
    _setState(AuthLoading());
    final result = await resetPasswordUseCase(email, newPassword);
    result.fold(
          (failure) => _setState(AuthError(_mapFailureToMessage(failure))),
          (_) => _setState(AuthPasswordResetSuccess()),
    );
  }

  Future<void> performLogout() async {
    _setState(AuthLoading());
    final result = await logoutUser();
    result.fold(
          (failure) => _setState(AuthError(_mapFailureToMessage(failure))),
          (_) => _setState(AuthLoggedOut()), // Thành công, chuyển về trạng thái đăng xuất
    );
  }

  Future<void> checkIfLoggedIn() async {
    _setState(AuthLoading());
    final result = await getCurrentUserUseCase();
    result.fold(
          (failure) => _setState(AuthError(_mapFailureToMessage(failure))),
          (user) {
        if (user != null) {
          _setState(AuthSuccess(user));
        } else {
          _setState(AuthLoggedOut());
        }
      },
    );
  }
  String _mapFailureToMessage(Failure failure) {
    if (failure is ServerFailure) {
      return 'Lỗi Server: ${failure.message}';
    } else if (failure is NetworkFailure) {
      return 'Lỗi Mạng: Vui lòng kiểm tra kết nối internet.';
    } else if (failure is AuthFailure) {
      return 'Lỗi Xác thực: ${failure.message}';
    } else if (failure is InputValidationFailure) {
      return 'Dữ liệu không hợp lệ: ${failure.message}';
    } else if (failure is NotFoundFailure) {
      return 'Không tìm thấy: ${failure.message}';
    } else {
      return 'Lỗi không xác định: ${failure.message}';
    }
  }

  // Đặt lại trạng thái về ban đầu (ví dụ: sau khi hiển thị lỗi)
  void resetState() {
    _state = AuthInitial();
    notifyListeners();
  }
}
// lib/features/auth/presentation/screens/splash_screen.dart
import 'package:flutter/material.dart';
import 'package:safetrek_app/core/app_routes.dart';
import 'package:provider/provider.dart'; // THÊM DÒNG NÀY
import 'package:safetrek_app/features/auth/presentation/auth_view_model.dart'; // THÊM DÒNG NÀY
import 'package:safetrek_app/features/auth/presentation/auth_state.dart'; // THÊM DÒNG NÀY
// import 'package:safetrek_app/features/auth/presentation/screens/onboarding_screen.dart'; // Sẽ tạo tiếp theo

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    // Thời gian hiển thị Splash Screen là 3 giây
    Future.delayed(const Duration(seconds: 5), () {
      // Sau 3 giây, chuyển đến Onboarding Screen
      Navigator.pushReplacementNamed(context, AppRoutes.onboarding);
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<AuthViewModel>( // Bọc bằng Consumer để lắng nghe trạng thái
        builder: (context, viewModel, child) {
          // Lắng nghe các trạng thái AuthSuccess, AuthLoggedOut, AuthError
          if (viewModel.state is AuthSuccess) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              Navigator.pushReplacementNamed(context, AppRoutes.dashboard);
              viewModel.resetState(); // Reset trạng thái sau khi điều hướng
            });
          } else if (viewModel.state is AuthLoggedOut) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              Navigator.pushReplacementNamed(context, AppRoutes.onboarding);
              viewModel.resetState(); // Reset trạng thái sau khi điều hướng
            });
          } else if (viewModel.state is AuthError) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              // Có lỗi xảy ra khi kiểm tra đăng nhập (ví dụ: token lỗi)
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Lỗi kiểm tra đăng nhập: ${(viewModel.state as AuthError).message}')),
              );
              Navigator.pushReplacementNamed(context, AppRoutes.onboarding); // Vẫn chuyển về Onboarding
              viewModel.resetState();
            });
          }

          // Hiển thị giao diện Splash trong khi đang kiểm tra
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  'assets/images/app_logo.png', // Đảm bảo bạn có logo.png
                  height: 150,
                ),
                const SizedBox(height: 24),
                Text(
                  'SafeTrek',
                  style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).primaryColor,
                  ),
                ),
                const SizedBox(height: 32),
                const CircularProgressIndicator(), // Hiển thị loading indicator
              ],
            ),
          );
        },
      ),
    );
  }
}
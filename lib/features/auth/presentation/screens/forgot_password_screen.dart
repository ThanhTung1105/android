// lib/features/auth/presentation/screens/forgot_password_screen.dart
import 'package:flutter/material.dart';
import 'package:safetrek_app/core/app_routes.dart';
import 'package:provider/provider.dart'; // THÊM DÒNG NÀY
import 'package:safetrek_app/features/auth/presentation/auth_state.dart'; // THÊM DÒNG NÀY
import 'package:safetrek_app/features/auth/presentation/auth_view_model.dart'; // THÊM DÒNG NÀY

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final TextEditingController _emailController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  void _sendResetEmail(AuthViewModel viewModel) async {
    if (_formKey.currentState!.validate()) {
      FocusScope.of(context).unfocus(); // Đóng bàn phím
      await viewModel.performForgotPassword(
        _emailController.text,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: IconThemeData(color: Theme.of(context).primaryColor),
      ),
      body: Consumer<AuthViewModel>(
        builder: (context, viewModel, child) {
          if (viewModel.state is AuthLoading) {
            // Có thể hiển thị một loading indicator toàn màn hình
          } else if (viewModel.state is AuthPasswordResetEmailSent) {
            // Trạng thái thành công sau khi gửi email (vì nó reset về AuthInitial)
            WidgetsBinding.instance.addPostFrameCallback((_) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Yêu cầu đặt lại mật khẩu đã được gửi!')),
              );
              Navigator.pushNamed( // Vẫn điều hướng đến màn hình đặt lại để người dùng tiếp tục
                context,
                AppRoutes.resetPassword,
                arguments: _emailController.text,
              );
              viewModel.resetState();
            });
          } else if (viewModel.state is AuthError) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text((viewModel.state as AuthError).message)),
              );
              viewModel.resetState();
            });
          }

          return Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(24.0),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Quên mật khẩu?',
                      style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).primaryColor,
                      ),
                    ),
                    const SizedBox(height: 16),
                    const Text(
                      'Vui lòng nhập email của bạn để nhận liên kết đặt lại mật khẩu.',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 16, color: Colors.grey),
                    ),
                    const SizedBox(height: 32),

                    // Input Email
                    TextFormField(
                      controller: _emailController,
                      keyboardType: TextInputType.emailAddress,
                      decoration: const InputDecoration(
                        labelText: 'Email',
                        hintText: 'Nhập email của bạn',
                        prefixIcon: Icon(Icons.email),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Vui lòng nhập email';
                        }
                        if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
                          return 'Email không hợp lệ';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 32),

                    // Nút Đặt lại Mật khẩu
                    ElevatedButton(
                      onPressed: (viewModel.state is AuthLoading) ? null : () => _sendResetEmail(viewModel),
                      style: ElevatedButton.styleFrom(
                        minimumSize: const Size(double.infinity, 50),
                        backgroundColor: Theme.of(context).primaryColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      child: (viewModel.state is AuthLoading)
                          ? const CircularProgressIndicator(color: Colors.white)
                          : const Text(
                        'ĐẶT LẠI MẬT KHẨU',
                        style: TextStyle(fontSize: 18, color: Colors.white),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
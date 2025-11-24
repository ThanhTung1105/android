// lib/features/auth/presentation/screens/register_screen.dart
import 'package:flutter/material.dart';
import 'package:safetrek_app/core/app_routes.dart';
import 'package:provider/provider.dart'; // THÊM DÒNG NÀY
import 'package:safetrek_app/features/auth/presentation/auth_state.dart'; // THÊM DÒNG NÀY
import 'package:safetrek_app/features/auth/presentation/auth_view_model.dart'; // THÊM DÒNG NÀY
class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final TextEditingController _fullNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _fullNameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  void _register(AuthViewModel viewModel) async {
    if (_formKey.currentState!.validate()) {
      FocusScope.of(context).unfocus(); // Đóng bàn phím
      if (_passwordController.text != _confirmPasswordController.text) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Mật khẩu và xác nhận mật khẩu không khớp.')),
        );
        return;
      }
      await viewModel.performRegister(
        _emailController.text,
        _passwordController.text,
      );
      // Logic điều hướng và hiển thị thông báo sẽ được xử lý trong `_buildBody` bằng Consumer
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: IconThemeData(color: Theme.of(context).primaryColor), // Màu icon back
      ),
      body: Consumer<AuthViewModel>( // Bọc phần body bằng Consumer
        builder: (context, viewModel, child) {
          // Lắng nghe trạng thái và điều hướng/hiển thị thông báo
          if (viewModel.state is AuthLoading) {
            // Có thể hiển thị một loading indicator toàn màn hình
          } else if (viewModel.state is AuthSuccess) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Đăng ký thành công! Vui lòng đăng nhập.')),
              );
              Navigator.pushNamedAndRemoveUntil(context, AppRoutes.login, (route) => false); // Về màn hình Login
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
                      'Tạo tài khoản mới',
                      style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).primaryColor,
                      ),
                    ),
                    const SizedBox(height: 24),

                    // Input Tên đầy đủ
                    TextFormField(
                      controller: _fullNameController,
                      keyboardType: TextInputType.text,
                      decoration: const InputDecoration(
                        labelText: 'Tên đầy đủ',
                        hintText: 'Nhập tên của bạn',
                        prefixIcon: Icon(Icons.person),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Vui lòng nhập tên đầy đủ';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 16),

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
                    const SizedBox(height: 16),

                    // Input Mật khẩu
                    TextFormField(
                      controller: _passwordController,
                      obscureText: true,
                      decoration: const InputDecoration(
                        labelText: 'Mật khẩu',
                        hintText: 'Nhập mật khẩu của bạn',
                        prefixIcon: Icon(Icons.lock),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Vui lòng nhập mật khẩu';
                        }
                        if (value.length < 6) {
                          return 'Mật khẩu phải có ít nhất 6 ký tự';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 16),

                    // Input Xác nhận Mật khẩu
                    TextFormField(
                      controller: _confirmPasswordController,
                      obscureText: true,
                      decoration: const InputDecoration(
                        labelText: 'Xác nhận Mật khẩu',
                        hintText: 'Nhập lại mật khẩu của bạn',
                        prefixIcon: Icon(Icons.lock),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Vui lòng xác nhận mật khẩu';
                        }
                        // Không cần kiểm tra khớp ở đây, sẽ kiểm tra trong _register
                        return null;
                      },
                    ),
                    const SizedBox(height: 24),

                    // Nút Đăng ký
                    ElevatedButton(
                      onPressed: (viewModel.state is AuthLoading) ? null : () => _register(viewModel), // Vô hiệu hóa khi đang loading
                      style: ElevatedButton.styleFrom(
                        minimumSize: const Size(double.infinity, 50),
                        backgroundColor: Theme.of(context).primaryColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      child: (viewModel.state is AuthLoading)
                          ? const CircularProgressIndicator(color: Colors.white) // Hiển thị loading
                          : const Text(
                        'ĐĂNG KÝ',
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
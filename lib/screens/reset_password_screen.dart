// lib/features/auth/presentation/screens/reset_password_screen.dart
import 'package:flutter/material.dart';
import 'package:safetrek_app/utils/app_routes.dart';
import 'package:provider/provider.dart';
import 'package:safetrek_app/screens/auth_state.dart';
import 'package:safetrek_app/screens/auth_view_model.dart';
class ResetPasswordScreen extends StatefulWidget {
  const ResetPasswordScreen({super.key});

  @override
  State<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  String? _emailFromArgs; // Biến để lưu email nhận được

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // Lấy email từ arguments khi widget được tạo/thay đổi dependencies
    if (_emailFromArgs == null) { // Chỉ lấy một lần
      _emailFromArgs = ModalRoute.of(context)!.settings.arguments as String?;
    }
  }

  @override
  void dispose() {
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  void _resetPassword(AuthViewModel viewModel) async {
    if (_formKey.currentState!.validate()) {
      FocusScope.of(context).unfocus(); // Đóng bàn phím
      if (_passwordController.text != _confirmPasswordController.text) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Mật khẩu và xác nhận mật khẩu không khớp.')),
        );
        return;
      }
      if (_emailFromArgs == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Không tìm thấy email để đặt lại mật khẩu.')),
        );
        return;
      }
      await viewModel.performResetPassword(
        _emailFromArgs!,
        _passwordController.text,
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
          } else if (viewModel.state is AuthPasswordResetSuccess) {
            // Trạng thái thành công sau khi đặt lại mật khẩu (vì nó reset về AuthInitial)
            WidgetsBinding.instance.addPostFrameCallback((_) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Mật khẩu của bạn đã được đặt lại thành công!')),
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
                      'Tạo mật khẩu mới',
                      style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).primaryColor,
                      ),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'Đặt mật khẩu mới cho ${ _emailFromArgs ?? ""}', // Hiển thị email nếu có
                      textAlign: TextAlign.center,
                      style: const TextStyle(fontSize: 16, color: Colors.grey),
                    ),
                    const SizedBox(height: 32),

                    // Input Mật khẩu mới
                    TextFormField(
                      controller: _passwordController,
                      obscureText: true,
                      decoration: const InputDecoration(
                        labelText: 'Mật khẩu mới',
                        hintText: 'Nhập mật khẩu mới',
                        prefixIcon: Icon(Icons.lock),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Vui lòng nhập mật khẩu mới';
                        }
                        if (value.length < 6) {
                          return 'Mật khẩu phải có ít nhất 6 ký tự';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 16),

                    // Input Xác nhận Mật khẩu mới
                    TextFormField(
                      controller: _confirmPasswordController,
                      obscureText: true,
                      decoration: const InputDecoration(
                        labelText: 'Xác nhận Mật khẩu mới',
                        hintText: 'Nhập lại mật khẩu mới',
                        prefixIcon: Icon(Icons.lock),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Vui lòng xác nhận mật khẩu mới';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 32),

                    // Nút Cập nhật Mật khẩu
                    ElevatedButton(
                      onPressed: (viewModel.state is AuthLoading) ? null : () => _resetPassword(viewModel),
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
                        'CẬP NHẬT MẬT KHẨU',
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
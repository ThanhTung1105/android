// lib/features/home/presentation/screens/profile_tab_screen.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart'; // THÊM DÒNG NÀY
import 'package:safetrek_app/features/auth/presentation/auth_view_model.dart'; // THÊM DÒNG NÀY
import 'package:safetrek_app/features/auth/domain/entities/user.dart'; // THÊM DÒNG NÀY
import 'package:safetrek_app/features/auth/domain/entities/user.dart'; // THÊM DÒNG NÀY
class ProfileTabScreen extends StatefulWidget {
  const ProfileTabScreen({super.key});

  @override
  State<ProfileTabScreen> createState() => _ProfileTabScreenState();
}
class _ProfileTabScreenState extends State<ProfileTabScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<AuthViewModel>(
        builder: (context, authViewModel, child) {
          final User? currentUser = authViewModel.currentUser; // Lấy user hiện tại

          return SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 16),

                Text(
                  'Hồ sơ của bạn',
                  style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).primaryColor,
                  ),
                ),
                const SizedBox(height: 24),

                // Phần thông tin cá nhân cơ bản
                Center(
                  child: Column(
                    children: [
                      CircleAvatar(
                        radius: 60,
                        backgroundImage: currentUser?.profilePictureUrl != null && currentUser!.profilePictureUrl!.isNotEmpty
                            ? NetworkImage(currentUser!.profilePictureUrl!)
                            : const AssetImage('assets/images/default_avatar.png') as ImageProvider, // Đảm bảo bạn có default_avatar.png
                        backgroundColor: Theme.of(context).primaryColor.withOpacity(0.2),
                        child: currentUser?.profilePictureUrl == null || currentUser!.profilePictureUrl!.isEmpty
                            ? Icon(Icons.person, size: 60, color: Theme.of(context).primaryColor)
                            : null,
                      ),
                      const SizedBox(height: 16),
                      Text(
                        currentUser?.fullName ?? 'Người dùng',
                        style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        currentUser?.email ?? 'Chưa đăng nhập',
                        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          color: Colors.grey[600],
                        ),
                      ),
                      const SizedBox(height: 16),
                      ElevatedButton.icon(
                        onPressed: () {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('Chỉnh sửa hồ sơ...')),
                          );
                          // TODO: Điều hướng đến màn hình chỉnh sửa hồ sơ
                        },
                        icon: const Icon(Icons.edit),
                        label: const Text('Chỉnh sửa hồ sơ'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Theme.of(context).primaryColor,
                          foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 32),

                // Phần cài đặt tài khoản và ứng dụng
                Text(
                  'Cài đặt tài khoản',
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).primaryColor,
                  ),
                ),
                const SizedBox(height: 16),
                Card(
                  elevation: 2,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                  child: Column(
                    children: [
                      ListTile(
                        leading: const Icon(Icons.lock_outline),
                        title: const Text('Đổi mật khẩu'),
                        trailing: const Icon(Icons.arrow_forward_ios),
                        onTap: () {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('Mở màn hình đổi mật khẩu...')),
                          );
                          // TODO: Điều hướng đến màn hình đổi mật khẩu
                        },
                      ),
                      const Divider(height: 1),
                      ListTile(
                        leading: const Icon(Icons.notifications_none),
                        title: const Text('Cài đặt thông báo'),
                        trailing: const Icon(Icons.arrow_forward_ios),
                        onTap: () {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('Mở cài đặt thông báo...')),
                          );
                          // TODO: Điều hướng đến màn hình cài đặt thông báo
                        },
                      ),
                      const Divider(height: 1),
                      ListTile(
                        leading: const Icon(Icons.privacy_tip_outlined),
                        title: const Text('Chính sách bảo mật'),
                        trailing: const Icon(Icons.arrow_forward_ios),
                        onTap: () {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('Mở chính sách bảo mật...')),
                          );
                          // TODO: Mở chính sách bảo mật
                        },
                      ),
                      const Divider(height: 1),
                      ListTile(
                        leading: const Icon(Icons.help_outline),
                        title: const Text('Trung tâm trợ giúp'),
                        trailing: const Icon(Icons.arrow_forward_ios),
                        onTap: () {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('Mở trung tâm trợ giúp...')),
                          );
                          // TODO: Mở trung tâm trợ giúp
                        },
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),

                // Nút đăng xuất (đã có trên AppBar, nhưng có thể có ở đây nữa)
                Center(
                  child: OutlinedButton.icon(
                    onPressed: () {
                      // TODO: Có thể thêm dialog xác nhận trước khi đăng xuất
                      authViewModel.performLogout();
                    },
                    icon: const Icon(Icons.logout, color: Colors.red),
                    label: const Text(
                      'Đăng xuất',
                      style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
                    ),
                    style: OutlinedButton.styleFrom(
                      side: const BorderSide(color: Colors.red),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
              ],
            ),
          );
        },
      ),
    );
  }
}
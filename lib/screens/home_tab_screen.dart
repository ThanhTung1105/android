// lib/features/home/presentation/screens/home_tab_screen.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:safetrek_app/screens/auth_view_model.dart';
import 'package:safetrek_app/models/user.dart';
import 'package:safetrek_app/screens/trip_setup_screen.dart';

class HomeTabScreen extends StatefulWidget {
  const HomeTabScreen({super.key});

  @override
  State<HomeTabScreen> createState() => _HomeTabScreenState();
}

class _HomeTabScreenState extends State<HomeTabScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Sử dụng SafeArea để tránh tai thỏ/nốt ruồi
      body: SafeArea(
        child: Consumer<AuthViewModel>(
          builder: (context, authViewModel, child) {
            final User? currentUser = authViewModel.currentUser;

            return Column(
              children: [
              // PHẦN 1: Header & Trạng thái (Phần trên)
              Expanded(
              flex: 3, // Chiếm khoảng 3 phần không gian
              child: Container(
                padding: const EdgeInsets.all(24.0),
                decoration: BoxDecoration(
                  color: Theme.of(context).scaffoldBackgroundColor,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Chào mừng
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Xin chào,',
                              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                                color: Colors.grey,
                              ),
                            ),
                            Text(
                              currentUser?.fullName ?? 'Người dùng',
                              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        // Avatar nhỏ góc phải
                        CircleAvatar(
                          backgroundImage: currentUser?.profilePictureUrl != null
                              ? NetworkImage(currentUser!.profilePictureUrl!)
                              : const AssetImage('assets/images/profile_avatar.jpg') as ImageProvider,
                        ),
                      ],
                    ),
                    const Spacer(),
                    // Trạng thái an toàn lớn
                    Center(
                      child: Column(
                        children: [
                          Icon(Icons.shield_moon, size: 80, color: Theme.of(context).primaryColor),
                          const SizedBox(height: 16),
                          Text(
                            'Bạn đang an toàn',
                            style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                              fontWeight: FontWeight.bold,
                              color: Theme.of(context).primaryColor,
                            ),
                          ),
                          const SizedBox(height: 8),
                          const Text(
                            'Hệ thống luôn sẵn sàng bảo vệ bạn.',
                            style: TextStyle(color: Colors.grey),
                          ),
                        ],
                      ),
                    ),
                    const Spacer(),
                  ],
                ),
              ),
            ),

            // PHẦN 2: Nút Bắt đầu chuyến đi (Phần giữa)
            Expanded(
            flex: 2,
            child: Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
            decoration: BoxDecoration(
            color: Colors.grey.shade50,
            borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(30),
            topRight: Radius.circular(30),
            ),
            boxShadow: [
            BoxShadow(
            color: Colors.grey.shade200,
            blurRadius: 10,
            offset: const Offset(0, -5),
            ),
            ],
            ),
            child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
            // Nút hành động chính
            SizedBox(
            width: double.infinity,
            height: 60,
            child: ElevatedButton.icon(
            onPressed: () {
            // Điều hướng đến màn hình thiết lập chuyến đi
            Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const TripSetupScreen()),
            );
            },
            style: ElevatedButton.styleFrom(
            backgroundColor: Theme.of(context).primaryColor,
            foregroundColor: Colors.white,
            shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
            ),
            elevation: 4,
            ),
            icon: const Icon(Icons.directions_walk, size: 28),
            label: const Text(
            'BẮT ĐẦU CHUYẾN ĐI MỚI',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            ),
            ),
            const SizedBox(height: 24),
            // Các hành động phụ
            Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
            _buildSecondaryActionButton(context, Icons.share_location, 'Chia sẻ vị trí'),
            _buildSecondaryActionButton(context, Icons.call, 'Gọi người thân'),
            ],
            ),
            ],
            ),
            ),
            ),

            // PHẦN 3: Nút SOS (Phần dưới cùng - Nổi bật nhất)
            Container(
            padding: const EdgeInsets.all(24.0),
            decoration: BoxDecoration(
            color: Colors.red.shade50, // Nền đỏ nhạt cảnh báo
            ),
            child: SizedBox(
            width: double.infinity,
            height: 70,
            child: ElevatedButton(
            onPressed:  () {
            // Xử lý nhấn giữ SOS
            ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('ĐANG GỬI TÍN HIỆU SOS KHẨN CẤP!'))
            );
            },
            style: ElevatedButton.styleFrom(
            backgroundColor: Colors.red.shade700, // Màu đỏ đậm
            foregroundColor: Colors.white,
            shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(35), // Bo tròn hoàn toàn
            ),
            elevation: 8,
            shadowColor: Colors.red.withOpacity(0.5),
            ),
            child: const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
            Icon(Icons.sos, size: 36),
            SizedBox(width: 12),
            Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
            Text(
            'SOS KHẨN CẤP',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            Text(
            'Nhấn giữ để kích hoạt ngay',
            style: TextStyle(fontSize: 12),
            ),
            ],
            ),
            ],
            ),
            ),
            ),
            ),
            ],
            );
          },
        ),
      ),
    );
  }

  Widget _buildSecondaryActionButton(BuildContext context, IconData icon, String label) {
    return InkWell(
      onTap: () {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Chức năng $label đang phát triển')));
      },
      child: Column(
        children: [
          CircleAvatar(
            radius: 24,
            backgroundColor: Theme.of(context).primaryColor.withOpacity(0.1),
            child: Icon(icon, color: Theme.of(context).primaryColor),
          ),
          const SizedBox(height: 8),
          Text(label, style: const TextStyle(fontWeight: FontWeight.w500)),
        ],
      ),
    );
  }
}
// lib/features/home/presentation/screens/dashboard_screen.dart
import 'package:flutter/material.dart';
import 'package:safetrek_app/utils/app_routes.dart';
import 'package:safetrek_app/screens/profile_tab_screen.dart';
import 'package:safetrek_app/screens/home_tab_screen.dart';
import 'package:safetrek_app/screens/safety_monitoring_tab_screen.dart';
import 'package:safetrek_app/screens/alerts_tab_screen.dart';
import 'package:provider/provider.dart';
import 'package:safetrek_app/screens/auth_view_model.dart';
import 'package:safetrek_app/screens/auth_state.dart';
// Đây sẽ là màn hình chứa BottomNavigationBar và quản lý các tab
class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  int _selectedIndex = 0;
  final List<String> _appBarTitles = const [
    'Trang chủ',
    'Giám sát An toàn',
    'Thông báo',
    'Cá nhân',
  ];

  // Danh sách các widget cho các tab
  final List<Widget> _widgetOptions = <Widget>[
    const HomeTabScreen(),
    const SafetyMonitoringTabScreen(),
    const AlertsTabScreen(),
    const ProfileTabScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  void _logout(AuthViewModel viewModel) async {
    await viewModel.performLogout();
  }

  @override
  Widget build(BuildContext context) {
    // Bắt đầu bọc bằng Consumer.
    // builder: (context, viewModel, child)
    //   - context: BuildContext hiện tại.
    //   - viewModel: Instance của AuthViewModel mà chúng ta đang lắng nghe.
    //   - child: (tùy chọn) Một widget con không cần xây dựng lại khi viewModel thay đổi.
    return Consumer<AuthViewModel>(
      builder: (context, viewModel, child) {
        // --- LOGIC XỬ LÝ TRẠNG THÁI TẠI ĐÂY ---
        // Các Widget hiển thị thông báo (SnackBar) hoặc điều hướng (Navigator)
        // KHÔNG NÊN được gọi trực tiếp trong hàm build()
        // mà NÊN được gọi sau khi frame hiện tại đã được build xong.
        // `WidgetsBinding.instance.addPostFrameCallback` là cách để làm điều đó.

        // Nếu trạng thái là AuthLoggedOut, có nghĩa là đăng xuất thành công.
        if (viewModel.state is AuthLoggedOut) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            // Điều hướng về màn hình đăng nhập và xóa tất cả các route cũ.
            Navigator.pushNamedAndRemoveUntil(context, AppRoutes.login, (route) => false);
            // Đặt lại trạng thái của ViewModel về ban đầu để tránh điều hướng lặp lại
            viewModel.resetState();
          });
        }
        // Nếu có lỗi trong quá trình đăng xuất.
        else if (viewModel.state is AuthError) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            // Hiển thị SnackBar thông báo lỗi.
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text((viewModel.state as AuthError).message)),
            );
            // Đặt lại trạng thái để có thể thử lại.
            viewModel.resetState();
          });
        }

        // --- PHẦN UI CỦA SCAFFOLD ---
        // Phần này tương tự như code cũ của bạn, nhưng bây giờ đã được bọc trong Consumer
        return Scaffold(
          appBar: AppBar(
            title: Text(_appBarTitles[_selectedIndex]),
            actions: [
              IconButton(
                icon: const Icon(Icons.logout),
                // Vô hiệu hóa nút Đăng xuất khi ViewModel đang ở trạng thái AuthLoading
                // để ngăn người dùng nhấn liên tục.
                onPressed: (viewModel.state is AuthLoading) ? null : () => _logout(viewModel),
              ),
            ],
          ),
          body: Center(
            child: _widgetOptions.elementAt(_selectedIndex),
          ),
          bottomNavigationBar: BottomNavigationBar(
            items: const <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: Icon(Icons.home),
                label: 'Trang chủ',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.security),
                label: 'Giám sát',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.notifications),
                label: 'Thông báo',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.person),
                label: 'Cá nhân',
              ),
            ],
            currentIndex: _selectedIndex,
            selectedItemColor: Theme.of(context).primaryColor,
            unselectedItemColor: Colors.grey,
            onTap: _onItemTapped,
            type: BottomNavigationBarType.fixed, // Đảm bảo các icon luôn hiển thị
          ),
        );
      },
    );
  }
}
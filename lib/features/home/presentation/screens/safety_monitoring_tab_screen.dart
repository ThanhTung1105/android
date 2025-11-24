import 'package:flutter/material.dart';

class SafetyMonitoringTabScreen extends StatefulWidget {
  const SafetyMonitoringTabScreen({super.key});

  @override
  State<SafetyMonitoringTabScreen> createState() => _SafetyMonitoringTabScreenState();
}

class _SafetyMonitoringTabScreenState extends State<SafetyMonitoringTabScreen> {
  // Các biến trạng thái của màn hình này
  bool _isMonitoringActive = false; // Ví dụ: trạng thái giám sát đang hoạt động hay không

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView( // Đảm bảo nội dung có thể cuộn
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 16),

          Text(
            'Giám sát An toàn',
            style: Theme.of(context).textTheme.headlineMedium?.copyWith(
              fontWeight: FontWeight.bold,
              color: Theme.of(context).primaryColor,
            ),
          ),
          const SizedBox(height: 24),

          // Card hiển thị trạng thái giám sát
          Card(
            elevation: 4,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Trạng thái giám sát:',
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                      Switch(
                        value: _isMonitoringActive,
                        onChanged: (newValue) {
                          setState(() {
                            _isMonitoringActive = newValue;
                          });
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                _isMonitoringActive
                                    ? 'Giám sát đã BẬT'
                                    : 'Giám sát đã TẮT',
                              ),
                            ),
                          );
                          // TODO: Gửi yêu cầu đến backend/service để bật/tắt giám sát
                        },
                        activeColor: Colors.green,
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Text(
                    _isMonitoringActive
                        ? 'Hệ thống đang chủ động giám sát an toàn của bạn.'
                        : 'Giám sát an toàn đang tạm dừng. Kích hoạt để đảm bảo an toàn.',
                    style: TextStyle(
                      fontSize: 16,
                      color: _isMonitoringActive ? Colors.green[700] : Colors.red[700],
                    ),
                  ),
                  const SizedBox(height: 10),
                  if (_isMonitoringActive)
                    Text(
                      'Vị trí hiện tại: Đang cập nhật...',
                      style: TextStyle(fontSize: 14, color: Colors.grey[600]),
                    ),
                  const SizedBox(height: 16),
                  ElevatedButton.icon(
                    onPressed: _isMonitoringActive
                        ? () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Xem chi tiết báo cáo...')),
                      );
                      // TODO: Chuyển đến màn hình báo cáo chi tiết
                    }
                        : null, // Vô hiệu hóa nút nếu giám sát không hoạt động
                    icon: const Icon(Icons.description),
                    label: const Text('Xem báo cáo chi tiết'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Theme.of(context).primaryColor,
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 32),

          // Phần bản đồ (Placeholder)
          Text(
            'Vị trí của bạn',
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.bold,
              color: Theme.of(context).primaryColor,
            ),
          ),
          const SizedBox(height: 16),
          Container(
            height: 250,
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.grey[200],
              borderRadius: BorderRadius.circular(15),
              border: Border.all(color: Colors.grey.shade300),
            ),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.map, size: 60, color: Colors.grey[500]),
                  const SizedBox(height: 10),
                  Text(
                    'Bản đồ vị trí',
                    style: TextStyle(fontSize: 18, color: Colors.grey[700]),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    '(Sẽ tích hợp Google Maps/OpenStreetMap)',
                    style: TextStyle(fontSize: 14, color: Colors.grey[500]),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 32),

          // Các cài đặt giám sát bổ sung (Ví dụ)
          Text(
            'Cài đặt giám sát',
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
                  leading: const Icon(Icons.people),
                  title: const Text('Liên hệ khẩn cấp'),
                  subtitle: const Text('Quản lý danh sách người liên hệ khẩn cấp'),
                  trailing: const Icon(Icons.arrow_forward_ios),
                  onTap: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Mở cài đặt liên hệ khẩn cấp...')),
                    );
                    // TODO: Chuyển đến màn hình cài đặt liên hệ khẩn cấp
                  },
                ),
                const Divider(height: 1),
                ListTile(
                  leading: const Icon(Icons.timer),
                  title: const Text('Tần suất cập nhật vị trí'),
                  subtitle: const Text('Cài đặt thời gian cập nhật vị trí'),
                  trailing: const Icon(Icons.arrow_forward_ios),
                  onTap: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Mở cài đặt tần suất cập nhật...')),
                    );
                    // TODO: Chuyển đến màn hình cài đặt tần suất
                  },
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}
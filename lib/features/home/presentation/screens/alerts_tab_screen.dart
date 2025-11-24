import 'package:flutter/material.dart';

// Định nghĩa một lớp NotificationItem đơn giản để mô hình hóa thông báo
class NotificationItem {
  final String id;
  final String title;
  final String message;
  final DateTime timestamp;
  final bool isRead;
  final NotificationType type;

  NotificationItem({
    required this.id,
    required this.title,
    required this.message,
    required this.timestamp,
    this.isRead = false,
    this.type = NotificationType.info,
  });

  // Tạo bản sao với các thuộc tính thay đổi
  NotificationItem copyWith({
    bool? isRead,
  }) {
    return NotificationItem(
      id: id,
      title: title,
      message: message,
      timestamp: timestamp,
      isRead: isRead ?? this.isRead,
      type: type,
    );
  }
}

enum NotificationType {
  danger,
  warning,
  info,
  success,
}

class AlertsTabScreen extends StatefulWidget {
  const AlertsTabScreen({super.key});

  @override
  State<AlertsTabScreen> createState() => _AlertsTabScreenState();
}

class _AlertsTabScreenState extends State<AlertsTabScreen> {
  List<NotificationItem> _allNotifications = [];
  String _selectedFilter = 'Tất cả'; // Filter hiện tại (Tất cả, Chưa đọc, Đã đọc)

  @override
  void initState() {
    super.initState();
    _generateDummyNotifications();
  }

  // Tạo các thông báo giả lập
  void _generateDummyNotifications() {
    _allNotifications = [
      NotificationItem(
        id: '1',
        title: 'Cảnh báo nguy hiểm',
        message: 'Bạn đã đi vào khu vực có nguy cơ cao. Hãy cẩn thận!',
        timestamp: DateTime.now().subtract(const Duration(minutes: 5)),
        type: NotificationType.danger,
      ),
      NotificationItem(
        id: '2',
        title: 'Kiểm tra pin thiết bị',
        message: 'Pin của thiết bị giám sát đang thấp. Vui lòng sạc.',
        timestamp: DateTime.now().subtract(const Duration(hours: 1)),
        type: NotificationType.warning,
        isRead: true,
      ),
      NotificationItem(
        id: '3',
        title: 'Cập nhật phiên bản mới',
        message: 'Ứng dụng SafeTrek đã có phiên bản mới với nhiều tính năng cải tiến.',
        timestamp: DateTime.now().subtract(const Duration(days: 1)),
        type: NotificationType.info,
      ),
      NotificationItem(
        id: '4',
        title: 'Giám sát an toàn đã BẬT',
        message: 'Hệ thống giám sát an toàn của bạn đã được kích hoạt thành công.',
        timestamp: DateTime.now().subtract(const Duration(days: 2)),
        type: NotificationType.success,
      ),
      NotificationItem(
        id: '5',
        title: 'Không có tín hiệu GPS',
        message: 'Không thể xác định vị trí chính xác. Vui lòng kiểm tra cài đặt GPS.',
        timestamp: DateTime.now().subtract(const Duration(days: 3)),
        type: NotificationType.danger,
      ),
      NotificationItem(
        id: '6',
        title: 'Thông báo chung',
        message: 'Đây là một thông báo thông tin bình thường.',
        timestamp: DateTime.now().subtract(const Duration(days: 4)),
        type: NotificationType.info,
        isRead: true,
      ),
    ];
    // Sắp xếp theo thời gian mới nhất
    _allNotifications.sort((a, b) => b.timestamp.compareTo(a.timestamp));
  }

  // Lọc thông báo dựa trên _selectedFilter
  List<NotificationItem> get _filteredNotifications {
    if (_selectedFilter == 'Chưa đọc') {
      return _allNotifications.where((n) => !n.isRead).toList();
    } else if (_selectedFilter == 'Đã đọc') {
      return _allNotifications.where((n) => n.isRead).toList();
    }
    return _allNotifications;
  }

  // Đánh dấu thông báo đã đọc
  void _markAsRead(String id) {
    setState(() {
      final index = _allNotifications.indexWhere((n) => n.id == id);
      if (index != -1) {
        _allNotifications[index] = _allNotifications[index].copyWith(isRead: true);
      }
    });
  }

  // Xóa thông báo (ví dụ)
  void _deleteNotification(String id) {
    setState(() {
      _allNotifications.removeWhere((n) => n.id == id);
    });
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Đã xóa thông báo.')),
    );
  }


  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Phần bộ lọc
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildFilterButton('Tất cả'),
              _buildFilterButton('Chưa đọc'),
              _buildFilterButton('Đã đọc'),
            ],
          ),
        ),
        Expanded(
          child: _filteredNotifications.isEmpty
              ? Center(
            child: Text(
              _selectedFilter == 'Tất cả'
                  ? 'Không có thông báo nào.'
                  : 'Không có thông báo ${_selectedFilter.toLowerCase()} nào.',
              style: TextStyle(fontSize: 18, color: Colors.grey[600]),
            ),
          )
              : ListView.builder(
            itemCount: _filteredNotifications.length,
            itemBuilder: (context, index) {
              final notification = _filteredNotifications[index];
              return _buildNotificationCard(notification);
            },
          ),
        ),
      ],
    );
  }

  // Widget cho nút bộ lọc
  Widget _buildFilterButton(String filterText) {
    return ChoiceChip(
      label: Text(filterText),
      selected: _selectedFilter == filterText,
      selectedColor: Theme.of(context).primaryColor,
      labelStyle: TextStyle(
        color: _selectedFilter == filterText ? Colors.white : Colors.black,
        fontWeight: FontWeight.bold,
      ),
      onSelected: (selected) {
        if (selected) {
          setState(() {
            _selectedFilter = filterText;
          });
        }
      },
    );
  }

  // Widget cho mỗi Card thông báo
  Widget _buildNotificationCard(NotificationItem notification) {
    Color iconColor;
    IconData iconData;
    switch (notification.type) {
      case NotificationType.danger:
        iconColor = Colors.red.shade700;
        iconData = Icons.warning;
        break;
      case NotificationType.warning:
        iconColor = Colors.orange.shade700;
        iconData = Icons.info;
        break;
      case NotificationType.info:
        iconColor = Colors.blue.shade700;
        iconData = Icons.notifications_none;
        break;
      case NotificationType.success:
        iconColor = Colors.green.shade700;
        iconData = Icons.check_circle_outline;
        break;
    }

    return Card(
      elevation: notification.isRead ? 1 : 3, // Thông báo chưa đọc nổi hơn
      margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      color: notification.isRead ? Colors.white : Colors.lightBlue.shade50, // Nền khác cho chưa đọc
      child: InkWell(
        onTap: () {
          // TODO: Xử lý khi nhấn vào thông báo (ví dụ: hiển thị chi tiết)
          _markAsRead(notification.id); // Tự động đánh dấu đã đọc khi xem
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Mở thông báo: ${notification.title}')),
          );
        },
        onLongPress: () {
          // Hiển thị dialog xác nhận xóa
          showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: const Text('Xóa thông báo?'),
              content: Text('Bạn có muốn xóa thông báo "${notification.title}" không?'),
              actions: [
                TextButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: const Text('Hủy'),
                ),
                ElevatedButton(
                  onPressed: () {
                    _deleteNotification(notification.id);
                    Navigator.of(context).pop();
                  },
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                  child: const Text('Xóa', style: TextStyle(color: Colors.white)),
                ),
              ],
            ),
          );
        },
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(iconData, color: iconColor, size: 30),
              const SizedBox(width: 15),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      notification.title,
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: notification.isRead ? Colors.grey[700] : Colors.black,
                      ),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      notification.message,
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: notification.isRead ? Colors.grey : Colors.black87,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 5),
                    Text(
                      '${_formatTimestamp(notification.timestamp)} ${notification.isRead ? '' : '• Mới'}',
                      style: const TextStyle(fontSize: 12, color: Colors.grey),
                    ),
                  ],
                ),
              ),
              if (!notification.isRead) // Hiển thị chấm đỏ nhỏ nếu chưa đọc
                Container(
                  margin: const EdgeInsets.only(left: 8, top: 5),
                  width: 8,
                  height: 8,
                  decoration: BoxDecoration(
                    color: Colors.red,
                    shape: BoxShape.circle,
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }

  // Hàm format thời gian hiển thị
  String _formatTimestamp(DateTime timestamp) {
    final now = DateTime.now();
    final difference = now.difference(timestamp);

    if (difference.inMinutes < 1) {
      return 'Vừa xong';
    } else if (difference.inHours < 1) {
      return '${difference.inMinutes} phút trước';
    } else if (difference.inDays < 1) {
      return '${difference.inHours} giờ trước';
    } else if (difference.inDays < 7) {
      return '${difference.inDays} ngày trước';
    } else {
      return '${timestamp.day}/${timestamp.month}/${timestamp.year}';
    }
  }
}
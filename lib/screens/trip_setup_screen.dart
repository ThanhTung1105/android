// lib/features/home/presentation/screens/trip_setup_screen.dart
import 'package:flutter/material.dart';

class TripSetupScreen extends StatefulWidget {
  const TripSetupScreen({super.key});

  @override
  State<TripSetupScreen> createState() => _TripSetupScreenState();
}

class _TripSetupScreenState extends State<TripSetupScreen> {
  final _destinationController = TextEditingController();
  int _selectedDurationMinutes = 30; // Mặc định 30 phút

  final List<int> _durationOptions = [15, 30, 45, 60, 90, 120];

  @override
  void dispose() {
    _destinationController.dispose();
    super.dispose();
  }

  void _startTrip() {
    if (_destinationController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Vui lòng nhập điểm đến')),
      );
      return;
    }

    // TODO: Gọi ViewModel để bắt đầu chuyến đi thực sự
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Bắt đầu đi đến ${_destinationController.text} trong $_selectedDurationMinutes phút')),
    );

    // Sau khi bắt đầu, quay lại màn hình chính (màn hình chính sẽ cập nhật trạng thái)
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Thiết lập chuyến đi'),
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: IconThemeData(color: Theme.of(context).primaryColor),
        titleTextStyle: Theme.of(context).textTheme.titleLarge?.copyWith(
          color: Theme.of(context).primaryColor,
          fontWeight: FontWeight.bold,
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Bạn muốn đi đâu?',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            // Input Điểm đến
            TextField(
              controller: _destinationController,
              decoration: InputDecoration(
                hintText: 'Nhập địa chỉ hoặc tên địa điểm...',
                prefixIcon: const Icon(Icons.location_on_outlined),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                filled: true,
                fillColor: Colors.grey.shade50,
              ),
            ),
            const SizedBox(height: 32),

            Text(
              'Thời gian dự kiến?',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(
              'Chúng tôi sẽ cảnh báo nếu bạn không đến nơi sau khoảng thời gian này.',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: Colors.grey),
            ),
            const SizedBox(height: 16),

            // Chọn thời gian (Dạng nút bấm chọn nhanh)
            Wrap(
              spacing: 10,
              runSpacing: 10,
              children: _durationOptions.map((minutes) {
                final isSelected = _selectedDurationMinutes == minutes;
                return ChoiceChip(
                  label: Text('$minutes phút'),
                  selected: isSelected,
                  selectedColor: Theme.of(context).primaryColor,
                  labelStyle: TextStyle(
                    color: isSelected ? Colors.white : Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                  onSelected: (selected) {
                    if (selected) {
                      setState(() {
                        _selectedDurationMinutes = minutes;
                      });
                    }
                  },
                );
              }).toList(),
            ),

            const SizedBox(height: 24),
            // Hiển thị thời gian kết thúc dự kiến
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Theme.of(context).primaryColor.withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                children: [
                  Icon(Icons.timer, color: Theme.of(context).primaryColor),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      'Dự kiến đến lúc: ${TimeOfDay.fromDateTime(DateTime.now().add(Duration(minutes: _selectedDurationMinutes))).format(context)}',
                      style: TextStyle(
                        color: Theme.of(context).primaryColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(24.0),
        child: ElevatedButton(
          onPressed: _startTrip,
          style: ElevatedButton.styleFrom(
            backgroundColor: Theme.of(context).primaryColor,
            foregroundColor: Colors.white,
            padding: const EdgeInsets.symmetric(vertical: 16),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            elevation: 5,
          ),
          child: const Text(
            'BẮT ĐẦU BẢO VỆ',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }
}
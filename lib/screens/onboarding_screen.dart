// lib/features/auth/presentation/screens/onboarding_screen.dart
import 'package:flutter/material.dart';
import 'package:safetrek_app/models/onboarding_page_content.dart';
import 'package:safetrek_app/utils/app_routes.dart';


class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  final List<OnboardingPageContent> pages = [
    OnboardingPageContent(
      image: 'assets/images/onboarding_1.jpg',
      title: 'Người bạn đồng hành ảo, luôn bên bạn.',
      description:
      'SafeTrek giám sát hành trình của bạn và tự động cảnh báo khi bạn không thể.',
    ),
    OnboardingPageContent(
      image: 'assets/images/onboarding_2.jpg',
      title: 'Giám sát tự động, cảnh báo tức thì.',
      description:
      'Đặt hẹn giờ an toàn cho chuyến đi. Nếu không check-in, cảnh báo sẽ được gửi.',
    ),
    OnboardingPageContent(
      image: 'assets/images/onboarding_3.jpg',
      title: 'Bảo vệ bạn mọi lúc, mọi nơi.',
      description:
      'Nút Hoảng loạn và PIN bị ép buộc giúp bạn an toàn trong mọi tình huống.',
    ),
  ];

  _onPageChanged(int index) {
    setState(() {
      _currentPage = index;
    });
  }

  _navigateToLogin() {
    // Hiện tại chúng ta sẽ chuyển về màn hình demo mặc định của Flutter
    // Sau này khi có màn hình Login, chúng ta sẽ đổi dòng này.
    Navigator.pushReplacementNamed(context, AppRoutes.login);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: PageView.builder(
              controller: _pageController,
              itemCount: pages.length,
              onPageChanged: _onPageChanged,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        pages[index].image,
                        height: 250,
                      ),
                      const SizedBox(height: 40),
                      Text(
                        pages[index].title,
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.headlineMedium,
                      ),
                      const SizedBox(height: 16),
                      Text(
                        pages[index].description,
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 32.0),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(
                    pages.length,
                        (index) => AnimatedContainer(
                      duration: const Duration(milliseconds: 300),
                      height: 8,
                      width: _currentPage == index ? 24 : 8,
                      margin: const EdgeInsets.symmetric(horizontal: 4),
                      decoration: BoxDecoration(
                        color: _currentPage == index
                            ? Theme.of(context).primaryColor
                            : Colors.grey.shade300,
                        borderRadius: BorderRadius.circular(4),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 32),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      if (_currentPage == pages.length - 1) {
                        _navigateToLogin(); // Chuyển đến màn hình Đăng nhập (tạm thời là màn hình demo)
                      } else {
                        _pageController.nextPage(
                          duration: const Duration(milliseconds: 300),
                          curve: Curves.easeIn,
                        );
                      }
                    },
                    child: Text(_currentPage == pages.length - 1 ? 'BẮT ĐẦU' : 'TIẾP THEO'),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}





// lib/pages/onboarding/onboarding_page.dart
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../core/constants/app_text.dart';
import '../core/constants/app_colors.dart';
import '../routes/app_routes.dart';
import '../widgets/common_button.dart';

class OnboardingPage extends StatefulWidget {
  const OnboardingPage({super.key});

  @override
  State<OnboardingPage> createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  final List<OnboardingData> _pages = [
    OnboardingData(
      icon: Icons.explore,
      title: '加密电话',
      description: '保护隐私，防标记、防窃听',
      color: Colors.blue,
    ),
    OnboardingData(
      icon: Icons.people,
      title: '连接好友',
      description: '与朋友分享生活点滴，建立更紧密的联系',
      color: Colors.green,
    ),
    OnboardingData(
      icon: Icons.star,
      title: '精彩体验',
      description: '享受优质服务，获得非凡的用户体验',
      color: Colors.orange,
    ),
  ];

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _nextPage() {
    if (_currentPage < _pages.length - 1) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    } else {
      _completeOnboarding();
    }
  }

  void _skipOnboarding() {
    _completeOnboarding();
  }

  void _completeOnboarding() {
    // if (authService.isAuthenticated()) {
    Get.offAllNamed(AppRoutes.home);
    // } else {
    //   Get.toNamed(AppRoutes.login);
    // }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          PageView.builder(
            controller: _pageController,
            onPageChanged: (index) {
              setState(() {
                _currentPage = index;
              });
            },
            itemCount: _pages.length,
            itemBuilder: (context, index) {
              return _buildPage(_pages[index]);
            },
          ),
          Positioned(
            top: 40,
            right: 20,
            child: TextButton(
              onPressed: _skipOnboarding,
              child: Text(
                '跳过',
                style: TextStyle(color: Colors.grey[600], fontSize: 16),
              ),
            ),
          ),
          Positioned(
            bottom: 80,
            left: 0,
            right: 0,
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(
                    _pages.length,
                    (index) => _buildDot(index),
                  ),
                ),
                const SizedBox(height: 40),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: GradientButton(
                    text: "继续",
                    startColor: AppColors.f377BFF,
                    endColor: AppColors.f3AEFFF,
                    width: 160.w,
                    onTap: () {
                      // 点击事件
                      _nextPage();
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPage(OnboardingData data) {
    return Container(
      padding: EdgeInsets.only(
        top: MediaQuery.of(context).padding.top + 100.w,
        left: 30.w,
      ),
      color: Colors.white,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AppText(data.title, fontSize: 32.sp, textAlign: TextAlign.start),
          const SizedBox(height: 20),
          AppText(
            data.description,
            textAlign: TextAlign.start,
            fontSize: 17.sp,
            color: AppColors.textSecondary,
          ),
          const SizedBox(height: 60),
          Icon(data.icon, size: 150, color: data.color),
        ],
      ),
    );
  }

  Widget _buildDot(int index) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 5),
      width: _currentPage == index ? 25 : 10,
      height: 10,
      decoration: BoxDecoration(
        color: _currentPage == index
            ? _pages[_currentPage].color
            : Colors.grey[300],
        borderRadius: BorderRadius.circular(5),
      ),
    );
  }
}

class OnboardingData {
  final IconData icon;
  final String title;
  final String description;
  final Color color;

  OnboardingData({
    required this.icon,
    required this.title,
    required this.description,
    required this.color,
  });
}

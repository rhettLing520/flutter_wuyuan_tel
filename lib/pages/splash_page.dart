import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../routes/app_routes.dart';

import '../../core/constants/common_export.dart';


class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();

    Future.delayed(const Duration(seconds: 1), () {
      if (mounted) {
        Get.offNamed(AppRoutes.home);
        // Get.offNamed(AppRoutes.onboarding);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: AppImage(
          imagePath: AppImages.getAssetsPath("logo"),
          width: 80.w,
          height: 80.w,
        ),
      ),
    );
  }
}

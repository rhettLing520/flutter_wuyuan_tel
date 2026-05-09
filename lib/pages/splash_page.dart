import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:secretchat/core/constants/app_image.dart';
import 'package:secretchat/core/constants/app_images.dart';
import '../routes/app_routes.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();

    Future.delayed(const Duration(seconds: 2), () {
      if (mounted) {
        Get.offNamed(AppRoutes.onboarding);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: AppImage(
          imagePath: AppImages.getImage("logo"),
          width: 80.w,
          height: 80.w,
        ),
      ),
    );
  }
}

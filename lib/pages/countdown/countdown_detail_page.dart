import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../core/constants/common_export.dart';
import '../../core/utils/toast_util.dart';
import '../../data/models/countdown_event.dart';
import '../../services/countdown_service.dart';
import '../../widgets/app_app_bar.dart';

class CountdownDetailPage extends StatelessWidget {
  const CountdownDetailPage({super.key, required this.event});

  final CountdownEvent event;

  @override
  Widget build(BuildContext context) {
    final days = event.daysRemaining.abs();
    final isFuture = event.isFuture;
    final isToday = event.isToday;

    // 未来红色，已过蓝色
    final headerColor = isFuture || isToday
        ? AppColors.countDownRed
        : AppColors.countDownBlue;

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: const AppAppBar(titleText: 'Event Detail'),
      body: SingleChildScrollView(
        padding: EdgeInsets.fromLTRB(24.w, 24.h, 24.w, 24.h),
        child: Column(
          children: [
            // 卡片
            Container(
              decoration: BoxDecoration(
                color: AppColors.surface,
                borderRadius: BorderRadius.circular(12.r),
                border: Border.all(color: AppColors.divider),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // 蓝色标题栏
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.symmetric(
                      horizontal: 16.w,
                      vertical: 12.h,
                    ),
                    decoration: BoxDecoration(
                      color: headerColor,
                      borderRadius: BorderRadius.vertical(
                        top: Radius.circular(11.r),
                      ),
                    ),
                    child: AppText(
                      isToday
                          ? '${event.title} is today'
                          : isFuture
                          ? '${event.title} in'
                          : '${event.title} ago',
                      textAlign: TextAlign.center,
                      fontSize: 16.sp,
                      fontWeight: AppFontWeights.medium,
                      color: AppColors.textWhite,
                    ),
                  ),
                  // 数字区域
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 32.h),
                    child: Column(
                      children: [
                        AppText(
                          isToday ? '0' : '$days',
                          fontSize: 48.sp,
                          fontWeight: AppFontWeights.bold,
                          color: AppColors.textPrimary,
                        ),
                        SizedBox(height: 8.h),
                        AppText(
                          'Date: ${_formatDate(event.targetDate)}',
                          fontSize: 14.sp,
                          color: AppColors.textSecondary,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            SizedBox(height: 20.h),

            // 移除按钮
            GestureDetector(
              onTap: () => _removeEvent(context),
              child: Container(
                height: 48.h,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(24.r),
                  border: Border.all(color: AppColors.error),
                ),
                alignment: Alignment.center,
                child: AppText(
                  'Remove from schedule',
                  fontSize: 16.sp,
                  color: AppColors.error,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _removeEvent(BuildContext context) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const AppText('Remove Event', textAlign: TextAlign.center),
          content: const AppText('Are you sure you want to remove this event?'),
          actions: [
            TextButton(
              onPressed: () => Get.back(result: false),
              child: const AppText('Cancel'),
            ),
            TextButton(
              onPressed: () => Get.back(result: true),
              child: const AppText('Remove', color: AppColors.error),
            ),
          ],
        );
      },
    );

    if (confirmed != true) return;
    final service = Get.find<CountdownService>();
    await service.deleteEvent(event.id);
    if (context.mounted) {
      Get.back();
      ToastUtil.show('Removed');
    }
  }

  String _formatDate(DateTime date) {
    return '${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}';
  }
}

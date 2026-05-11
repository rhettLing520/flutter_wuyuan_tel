import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive_ce/hive_ce.dart' show BoxEvent;

import '../../core/constants/common_export.dart';
import '../../data/models/countdown_event.dart';
import '../../services/countdown_service.dart';
import '../../widgets/app_app_bar.dart';
import 'countdown_detail_page.dart';
import 'countdown_editor_page.dart';

class CountdownListPage extends StatefulWidget {
  const CountdownListPage({super.key});

  @override
  State<CountdownListPage> createState() => _CountdownListPageState();
}

class _CountdownListPageState extends State<CountdownListPage> {
  final CountdownService _countdownService = Get.find<CountdownService>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppAppBar(
        titleText: '倒数日',
        automaticallyImplyLeading: false,
      ),
      body: StreamBuilder<BoxEvent>(
        stream: _countdownService.watch(),
        builder: (context, _) {
          final events = _countdownService.getEvents();
          if (events.isEmpty) {
            return _buildEmpty();
          }
          return ListView.separated(
            padding: EdgeInsets.fromLTRB(16.w, 12.h, 16.w, 24.h),
            itemCount: events.length,
            separatorBuilder: (_, _) => SizedBox(height: 12.h),
            itemBuilder: (context, index) {
              return _buildEventCard(events[index]);
            },
          );
        },
      ),
      floatingActionButton: GestureDetector(
        onTap: () => Get.to(() => const CountdownEditorPage()),
        child: AppImage(
          imagePath: AppImages.getAssetsPath('add_bot', extension: 'png'),
          width: 56.w,
          height: 56.w,
        ),
      ),
    );
  }

  Widget _buildEmpty() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.event_available_outlined,
            size: 64.sp,
            color: AppColors.textHint,
          ),
          SizedBox(height: 16.h),
          AppText('暂无倒数日', fontSize: 16.sp, color: AppColors.textHint),
          SizedBox(height: 8.h),
          AppText('点击右上角 + 添加', fontSize: 14.sp, color: AppColors.textHint),
        ],
      ),
    );
  }

  Widget _buildEventCard(CountdownEvent event) {
    final days = event.daysRemaining.abs();
    final isFuture = event.isFuture;
    final isToday = event.isToday;

    // 未来事件红色，已过事件蓝色
    final dayColor = isFuture || isToday
        ? AppColors.countDownRed
        : AppColors.countDownBlue;

    return GestureDetector(
      onTap: () => Get.to(() => CountdownDetailPage(event: event)),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(8.r),
          border: Border.all(
            color: AppColors.divider,
            style: BorderStyle.solid,
          ),
        ),
        child: Row(
          children: [
            // 标题：事件名 + 还有/已经
            Expanded(
              child: AppText(
                isToday
                    ? '${event.title}就是今天'
                    : isFuture
                    ? '${event.title}还有'
                    : '${event.title}已经',
                fontSize: 16.sp,
                color: AppColors.textPrimary,
              ),
            ),
            // 天数
            if (!isToday) ...[
              AppText(
                '$days',
                fontSize: 18.sp,
                fontWeight: AppFontWeights.bold,
                color: dayColor,
              ),
              SizedBox(width: 2.w),
              AppText(
                '天',
                fontSize: 16.sp,
                fontWeight: AppFontWeights.bold,
                color: dayColor,
              ),
            ],
          ],
        ),
      ),
    );
  }
}

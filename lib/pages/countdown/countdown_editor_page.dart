import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../core/constants/common_export.dart';
import '../../core/utils/toast_util.dart';
import '../../services/countdown_service.dart';
import '../../widgets/app_app_bar.dart';
import '../../widgets/common_button.dart';

class CountdownEditorPage extends StatefulWidget {
  const CountdownEditorPage({super.key});

  @override
  State<CountdownEditorPage> createState() => _CountdownEditorPageState();
}

class _CountdownEditorPageState extends State<CountdownEditorPage> {
  final TextEditingController _titleController = TextEditingController();
  DateTime _selectedDate = DateTime.now().add(const Duration(days: 1));
  final CountdownService _countdownService = Get.find<CountdownService>();

  @override
  void dispose() {
    _titleController.dispose();
    super.dispose();
  }

  Future<void> _selectDate() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
      locale: const Locale('zh', 'CN'),
    );
    if (picked != null) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }

  Future<void> _save() async {
    final title = _titleController.text.trim();
    if (title.isEmpty) {
      ToastUtil.show('请输入事件名称');
      return;
    }

    await _countdownService.addEvent(title: title, targetDate: _selectedDate);

    if (mounted) {
      Get.back();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: const AppAppBar(titleText: '添加事件'),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // 事件名称
                  AppText(
                    '事件名称',
                    fontSize: 14.sp,
                    fontWeight: AppFontWeights.medium,
                    color: AppColors.textSecondary,
                  ),
                  SizedBox(height: 8.h),
                  Container(
                    decoration: BoxDecoration(
                      color: AppColors.surface,
                      borderRadius: BorderRadius.circular(8.r),
                      border: Border.all(color: AppColors.divider),
                    ),
                    child: TextField(
                      controller: _titleController,
                      style: TextStyle(
                        fontSize: 16.sp,
                        color: AppColors.textPrimary,
                      ),
                      decoration: InputDecoration(
                        hintText: '例如：春节',
                        hintStyle: TextStyle(
                          fontSize: 16.sp,
                          color: AppColors.textHint,
                        ),
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.symmetric(
                          horizontal: 12.w,
                          vertical: 14.h,
                        ),
                      ),
                    ),
                  ),

                  SizedBox(height: 20.h),

                  // 目标日期
                  AppText(
                    '目标日期',
                    fontSize: 14.sp,
                    fontWeight: AppFontWeights.medium,
                    color: AppColors.textSecondary,
                  ),
                  SizedBox(height: 8.h),
                  GestureDetector(
                    onTap: _selectDate,
                    child: Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 12.w,
                        vertical: 14.h,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.surface,
                        borderRadius: BorderRadius.circular(8.r),
                        border: Border.all(color: AppColors.divider),
                      ),
                      child: Row(
                        children: [
                          Icon(
                            Icons.calendar_today,
                            size: 20.w,
                            color: AppColors.textSecondary,
                          ),
                          SizedBox(width: 8.w),
                          AppText(
                            _formatDate(_selectedDate),
                            fontSize: 16.sp,
                            color: AppColors.textPrimary,
                          ),
                          const Spacer(),
                          Icon(
                            Icons.chevron_right,
                            size: 20.w,
                            color: AppColors.textHint,
                          ),
                        ],
                      ),
                    ),
                  ),

                  SizedBox(height: 20.h),

                  // 预览
                  // AppText(
                  //   '预览',
                  //   fontSize: 14.sp,
                  //   fontWeight: AppFontWeights.medium,
                  //   color: AppColors.textSecondary,
                  // ),
                  // SizedBox(height: 8.h),
                  // _buildPreviewCard(),
                ],
              ),
            ),
          ),

          // 底部确定按钮
          BottomConfirmButton(text: '确定', onTap: _save),
        ],
      ),
    );
  }

  Widget _buildPreviewCard() {
    final title = _titleController.text.isEmpty
        ? '事件名称'
        : _titleController.text;
    final now = DateTime.now();
    final target = DateTime(
      _selectedDate.year,
      _selectedDate.month,
      _selectedDate.day,
    );
    final today = DateTime(now.year, now.month, now.day);
    final days = target.difference(today).inDays;
    final isFuture = days > 0;

    final headerColor = isFuture
        ? AppColors.countDownRed
        : AppColors.countDownBlue;

    return Container(
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Column(
        children: [
          Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
            decoration: BoxDecoration(
              color: headerColor,
              borderRadius: BorderRadius.vertical(top: Radius.circular(11.r)),
            ),
            child: AppText(
              isFuture ? '$title还有' : '$title已经',
              fontSize: 16.sp,
              fontWeight: AppFontWeights.medium,
              color: AppColors.textWhite,
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 24.h),
            child: Column(
              children: [
                AppText(
                  '${days.abs()}',
                  fontSize: 48.sp,
                  fontWeight: AppFontWeights.bold,
                  color: AppColors.textPrimary,
                ),
                SizedBox(height: 4.h),
                AppText(
                  '日期: ${_formatDate(_selectedDate)}',
                  fontSize: 14.sp,
                  color: AppColors.textSecondary,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  String _formatDate(DateTime date) {
    return '${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}';
  }
}

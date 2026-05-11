// lib/pages/home/message_tab.dart
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../core/constants/common_export.dart';
import '../../data/models/diary_entry.dart';
import '../../services/diary_service.dart';
import '../../widgets/app_app_bar.dart';
import '../message/diary_editor_page.dart';

class MessageTab extends StatefulWidget {
  const MessageTab({super.key});

  @override
  State<MessageTab> createState() => _MessageTabState();
}

class _MessageTabState extends State<MessageTab> {
  final DiaryService _diaryService = Get.find<DiaryService>();

  void _openEditor([DiaryEntry? entry]) {
    Get.to(() => DiaryEditorPage(entry: entry));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: const AppAppBar(
        titleText: '日记本',
        automaticallyImplyLeading: false,
      ),
      body: StreamBuilder(
        stream: _diaryService.watch(),
        builder: (context, snapshot) {
          final entries = _diaryService.getEntries();

          if (entries.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.menu_book_outlined,
                    size: 64.sp,
                    color: AppColors.textHint,
                  ),
                  SizedBox(height: 16.h),
                  AppText(
                    '还没有日记',
                    fontSize: 16.sp,
                    fontWeight: AppFontWeights.medium,
                    color: AppColors.textSecondary,
                  ),
                  SizedBox(height: 8.h),
                  AppText(
                    '点击右下角 + 写下第一篇日记',
                    fontSize: 14.sp,
                    color: AppColors.textHint,
                  ),
                ],
              ),
            );
          }

          return ListView.separated(
            padding: EdgeInsets.fromLTRB(16.w, 12.h, 16.w, 24.h),
            itemCount: entries.length,
            separatorBuilder: (context, index) =>
                SizedBox(height: 10.h),
            itemBuilder: (context, index) {
              final entry = entries[index];
              return _DiaryEntryTile(
                entry: entry,
                onTap: () => _openEditor(entry),
              );
            },
          );
        },
      ),
      floatingActionButton: GestureDetector(
        onTap: () => _openEditor(),
        child: AppImage(
          imagePath: AppImages.getAssetsPath('add_bot', extension: 'png'),
          width: 56.w,
          height: 56.w,
        ),
      ),
    );
  }
}

class _DiaryEntryTile extends StatelessWidget {
  const _DiaryEntryTile({required this.entry, required this.onTap});

  final DiaryEntry entry;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 14.h),
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(8.r),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 日期
            AppText(
              _formatDate(entry.createdAt),
              fontSize: 12.sp,
              color: AppColors.textHint,
            ),
            SizedBox(height: 6.h),
            // 标题
            AppText(
              entry.title,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              fontSize: 16.sp,
              fontWeight: AppFontWeights.semiBold,
              color: AppColors.textPrimary,
            ),
            SizedBox(height: 6.h),
            // 内容
            AppText(
              entry.content,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              fontSize: 14.sp,
              color: AppColors.textSecondary,
              height: 1.35,
            ),
            // 图片展示
            if (entry.images.isNotEmpty) ...[
              SizedBox(height: 10.h),
              _buildImageRow(),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildImageRow() {
    final displayImages = entry.images.take(3).toList();
    return Row(
      children: displayImages.map((path) {
        return Padding(
          padding: EdgeInsets.only(right: 8.w),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(6.r),
            child: Image.file(
              File(path),
              width: 80.w,
              height: 80.w,
              fit: BoxFit.cover,
              errorBuilder: (_, __, ___) {
                return Container(
                  width: 80.w,
                  height: 80.w,
                  decoration: BoxDecoration(
                    color: AppColors.divider,
                    borderRadius: BorderRadius.circular(6.r),
                  ),
                  child: Icon(
                    Icons.image_not_supported,
                    size: 24.w,
                    color: AppColors.textHint,
                  ),
                );
              },
            ),
          ),
        );
      }).toList(),
    );
  }

  static String _formatDate(DateTime date) {
    final year = date.year;
    final month = date.month.toString().padLeft(2, '0');
    final day = date.day.toString().padLeft(2, '0');
    final hour = date.hour.toString().padLeft(2, '0');
    final minute = date.minute.toString().padLeft(2, '0');
    return '$year.$month.$day $hour:$minute';
  }
}

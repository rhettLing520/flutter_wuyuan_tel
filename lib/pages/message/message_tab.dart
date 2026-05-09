// lib/pages/home/message_tab.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../core/constants/common_export.dart';
import '../../data/models/diary_entry.dart';
import '../../services/diary_service.dart';
import '../message/diary_editor_page.dart';

class MessageTab extends StatefulWidget {
  const MessageTab({super.key});

  @override
  State<MessageTab> createState() => _MessageTabState();
}

class _MessageTabState extends State<MessageTab> {
  final DiaryService _diaryService = Get.find<DiaryService>();

  void _openEditor([DiaryEntry? entry]) {
    Navigator.of(
      context,
    ).push(MaterialPageRoute(builder: (_) => DiaryEditorPage(entry: entry)));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('日记本'),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () => _openEditor(),
            icon: const Icon(Icons.edit_note),
            tooltip: '写日记',
          ),
        ],
      ),
      body: StreamBuilder(
        stream: _diaryService.watch(),
        builder: (context, snapshot) {
          final entries = _diaryService.getEntries();

          if (entries.isEmpty) {
            return Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 32),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.menu_book_outlined,
                      size: 64,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                    const SizedBox(height: 16),
                    AppText(
                      '还没有日记',
                      fontSize: 16.sp,
                      fontWeight: AppFontWeights.medium,
                      color: AppColors.textPrimary,
                    ),
                    const SizedBox(height: 8),
                    AppText(
                      '点击右上角写下第一篇日记',
                      textAlign: TextAlign.center,
                      fontSize: 14.sp,
                      color: AppColors.textSecondary,
                    ),
                  ],
                ),
              ),
            );
          }

          return ListView.separated(
            padding: const EdgeInsets.fromLTRB(16, 12, 16, 24),
            itemCount: entries.length,
            separatorBuilder: (context, index) => const SizedBox(height: 10),
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
    );
  }
}

class _DiaryEntryTile extends StatelessWidget {
  const _DiaryEntryTile({required this.entry, required this.onTap});

  final DiaryEntry entry;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Material(
      color: colorScheme.surfaceContainerHighest.withValues(alpha: 0.6),
      borderRadius: BorderRadius.circular(8),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(8),
        child: Padding(
          padding: const EdgeInsets.all(14),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: AppText(
                      entry.title,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      fontSize: 16.sp,
                      fontWeight: AppFontWeights.semiBold,
                      color: AppColors.textPrimary,
                    ),
                  ),
                  const SizedBox(width: 12),
                  AppText(
                    _formatDate(entry.createdAt),
                    fontSize: 12.sp,
                    color: AppColors.textSecondary,
                  ),
                ],
              ),
              const SizedBox(height: 8),
              AppText(
                entry.content,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                fontSize: 14.sp,
                color: AppColors.textSecondary,
                height: 1.35,
              ),
            ],
          ),
        ),
      ),
    );
  }

  static String _formatDate(DateTime date) {
    final month = date.month.toString().padLeft(2, '0');
    final day = date.day.toString().padLeft(2, '0');
    final hour = date.hour.toString().padLeft(2, '0');
    final minute = date.minute.toString().padLeft(2, '0');
    return '${date.year}-$month-$day $hour:$minute';
  }
}

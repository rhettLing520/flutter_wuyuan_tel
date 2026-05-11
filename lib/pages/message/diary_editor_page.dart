import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:secretchat/core/utils/toast_util.dart';

import '../../core/constants/common_export.dart';
import '../../data/models/diary_entry.dart';
import '../../services/diary_service.dart';
import '../../services/image_picker_service.dart';
import '../../widgets/app_app_bar.dart';
import '../../widgets/common_button.dart';

class DiaryEditorPage extends StatefulWidget {
  const DiaryEditorPage({super.key, this.entry});

  final DiaryEntry? entry;

  @override
  State<DiaryEditorPage> createState() => _DiaryEditorPageState();
}

class _DiaryEditorPageState extends State<DiaryEditorPage> {
  late final TextEditingController _titleController;
  late final TextEditingController _contentController;
  final DiaryService _diaryService = Get.find<DiaryService>();
  final ImagePickerService _imagePickerService = Get.find<ImagePickerService>();

  final List<String> _images = [];

  bool get _isEditing => widget.entry != null;

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController(text: widget.entry?.title ?? '');
    _contentController = TextEditingController(
      text: widget.entry?.content ?? '',
    );
    if (widget.entry?.images != null) {
      _images.addAll(widget.entry!.images);
    }
  }

  @override
  void dispose() {
    _titleController.dispose();
    _contentController.dispose();
    super.dispose();
  }

  Future<void> _save() async {
    final title = _titleController.text.trim();
    final content = _contentController.text.trim();

    if (title.isEmpty) {
      ToastUtil.show("请输入日记标题");
      return;
    }

    if (content.isEmpty && _images.isEmpty) {
      ToastUtil.show("请输入内容");
      return;
    }

    if (_isEditing) {
      await _diaryService.updateEntry(
        id: widget.entry!.id,
        title: title,
        content: content,
        images: _images,
      );
    } else {
      await _diaryService.addEntry(
        title: title,
        content: content,
        images: _images,
      );
    }

    if (mounted) {
      Get.back();
    }
  }

  Future<void> _delete() async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const AppText('删除日记'),
          content: const AppText('确定要删除这篇日记吗？'),
          actions: [
            TextButton(
              onPressed: () => Get.back(result: false),
              child: const AppText('取消'),
            ),
            TextButton(
              onPressed: () => Get.back(result: true),
              child: const AppText('删除', color: AppColors.error),
            ),
          ],
        );
      },
    );

    if (confirmed != true) return;
    await _diaryService.deleteEntry(widget.entry!.id);

    if (mounted) {
      Get.back();
    }
  }

  Future<void> _pickImages() async {
    if (_images.length >= 9) {
      ToastUtil.show('最多只能添加9张图片');
      return;
    }

    final images = await _imagePickerService.showImagePicker(
      allowMultiple: true,
      maxImages: 9 - _images.length,
    );

    if (images.isNotEmpty) {
      setState(() {
        _images.addAll(images);
      });
    }
  }

  void _removeImage(int index) {
    setState(() {
      _images.removeAt(index);
    });
  }

  void _previewImage(int index) {
    Get.to(() => _ImagePreviewPage(images: _images, initialIndex: index));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppAppBar(
        titleText: _isEditing ? '编辑记录' : '添加记录',
        actions: [
          if (_isEditing)
            IconButton(
              onPressed: _delete,
              icon: const Icon(Icons.delete_outline, color: AppColors.error),
              tooltip: '删除',
            ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // 标题输入
                  AppText(
                    '标题',
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
                      textInputAction: TextInputAction.next,
                      style: TextStyle(
                        fontSize: 16.sp,
                        color: AppColors.textPrimary,
                      ),
                      decoration: InputDecoration(
                        hintText: '我是标题',
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

                  SizedBox(height: 16.h),

                  // 内容输入
                  AppText(
                    '记录内容',
                    fontSize: 14.sp,
                    fontWeight: AppFontWeights.medium,
                    color: AppColors.textSecondary,
                  ),
                  SizedBox(height: 8.h),
                  Container(
                    constraints: BoxConstraints(minHeight: 200.h),
                    decoration: BoxDecoration(
                      color: AppColors.surface,
                      borderRadius: BorderRadius.circular(8.r),
                    ),
                    child: TextField(
                      controller: _contentController,
                      maxLines: null,
                      keyboardType: TextInputType.multiline,
                      style: TextStyle(
                        fontSize: 16.sp,
                        color: AppColors.textPrimary,
                        height: 1.5,
                      ),
                      decoration: InputDecoration(
                        hintText: '记录这一刻的想法...',
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

                  SizedBox(height: 16.h),

                  // 添加图片
                  AppText(
                    '添加图片',
                    fontSize: 14.sp,
                    fontWeight: AppFontWeights.medium,
                    color: AppColors.textSecondary,
                  ),
                  SizedBox(height: 8.h),
                  SizedBox(
                    height: 90.w,
                    child: ListView.separated(
                      scrollDirection: Axis.horizontal,
                      itemCount: _images.length + (_images.length < 9 ? 1 : 0),
                      separatorBuilder: (_, _) => SizedBox(width: 8.w),
                      itemBuilder: (context, index) {
                        // 最后一个是上传按钮
                        if (index == _images.length) {
                          return _buildUploadButton();
                        }
                        return _buildImageItem(index);
                      },
                    ),
                  ),
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

  /// 上传按钮
  Widget _buildUploadButton() {
    return GestureDetector(
      onTap: _pickImages,
      child: Container(
        width: 80.w,
        height: 80.w,
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(8.r),
          border: Border.all(color: AppColors.divider),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.camera_alt_outlined,
              size: 28.sp,
              color: AppColors.textHint,
            ),
            SizedBox(height: 4.h),
            AppText('上传', fontSize: 12.sp, color: AppColors.textHint),
          ],
        ),
      ),
    );
  }

  /// 图片项
  Widget _buildImageItem(int index) {
    return GestureDetector(
      onTap: () => _previewImage(index),
      child: Container(
        width: 80.w,
        height: 80.w,
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(8.r),
          border: Border.all(color: AppColors.divider),
        ),
        child: Stack(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(7.r),
              child: Image.file(
                File(_images[index]),
                fit: BoxFit.cover,
                width: double.infinity,
                height: double.infinity,
              ),
            ),
            // 删除按钮
            Positioned(
              top: 2.h,
              left: 2.w,
              child: GestureDetector(
                onTap: () => _removeImage(index),
                child: Container(
                  padding: EdgeInsets.all(2.w),
                  decoration: const BoxDecoration(
                    color: AppColors.textHint,
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Icons.close,
                    size: 12.sp,
                    color: AppColors.textWhite,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// 图片预览页面
class _ImagePreviewPage extends StatefulWidget {
  const _ImagePreviewPage({required this.images, required this.initialIndex});

  final List<String> images;
  final int initialIndex;

  @override
  State<_ImagePreviewPage> createState() => _ImagePreviewPageState();
}

class _ImagePreviewPageState extends State<_ImagePreviewPage> {
  late PageController _pageController;
  late int _currentIndex;

  @override
  void initState() {
    super.initState();
    _currentIndex = widget.initialIndex;
    _pageController = PageController(initialPage: widget.initialIndex);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        iconTheme: const IconThemeData(color: AppColors.textWhite),
        title: AppText(
          '${_currentIndex + 1}/${widget.images.length}',
          fontSize: 16.sp,
          color: AppColors.textWhite,
        ),
      ),
      body: Stack(
        children: [
          PageView.builder(
            controller: _pageController,
            itemCount: widget.images.length,
            onPageChanged: (index) {
              setState(() {
                _currentIndex = index;
              });
            },
            itemBuilder: (context, index) {
              return InteractiveViewer(
                child: Center(
                  child: Image.file(
                    File(widget.images[index]),
                    fit: BoxFit.contain,
                  ),
                ),
              );
            },
          ),
          if (widget.images.length > 1)
            Positioned(
              left: 16.w,
              right: 16.w,
              bottom: 32.h,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  if (_currentIndex > 0)
                    IconButton(
                      onPressed: () {
                        _pageController.previousPage(
                          duration: const Duration(milliseconds: 300),
                          curve: Curves.easeInOut,
                        );
                      },
                      icon: const Icon(
                        Icons.arrow_back_ios,
                        color: AppColors.textWhite,
                      ),
                    ),
                  if (_currentIndex < widget.images.length - 1)
                    IconButton(
                      onPressed: () {
                        _pageController.nextPage(
                          duration: const Duration(milliseconds: 300),
                          curve: Curves.easeInOut,
                        );
                      },
                      icon: const Icon(
                        Icons.arrow_forward_ios,
                        color: AppColors.textWhite,
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

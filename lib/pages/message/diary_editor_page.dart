import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:secretchat/core/utils/toast_util.dart';

import '../../data/models/diary_entry.dart';
import '../../services/diary_service.dart';
import '../../services/image_picker_service.dart';

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
      // Toast.snackbar('提示', '请输入日记标题');
      ToastUtil.show("请输入日记标题");
      return;
    }

    if (content.isEmpty && _images.isEmpty) {
      ToastUtil.show("请输入内容");
      // Get.snackbar('提示', '请输入日记内容或添加图片');
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
      await _diaryService.addEntry(title: title, content: content, images: _images);
    }

    if (mounted) {
      Navigator.of(context).pop();
    }
  }

  Future<void> _delete() async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('删除日记'),
          content: const Text('确定要删除这篇日记吗？'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(false),
              child: const Text('取消'),
            ),
            TextButton(
              onPressed: () => Navigator.of(context).pop(true),
              child: const Text('删除'),
            ),
          ],
        );
      },
    );

    if (confirmed != true) return;
    await _diaryService.deleteEntry(widget.entry!.id);

    if (mounted) {
      Navigator.of(context).pop();
    }
  }

  /// 选择图片
  Future<void> _pickImages() async {
    if (_images.length >= 9) {
      Get.snackbar('提示', '最多只能添加9张图片');
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

  /// 删除图片
  void _removeImage(int index) {
    setState(() {
      _images.removeAt(index);
    });
  }

  /// 预览图片
  void _previewImage(int index) {
    Get.to(
      () => _ImagePreviewPage(
        images: _images,
        initialIndex: index,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_isEditing ? '编辑日记' : '写日记'),
        centerTitle: true,
        actions: [
          if (_isEditing)
            IconButton(
              onPressed: _delete,
              icon: const Icon(Icons.delete_outline),
              tooltip: '删除',
            ),
          TextButton(onPressed: _save, child: const Text('保存')),
        ],
      ),
      body: SafeArea(
        child: ListView(
          padding: EdgeInsets.fromLTRB(16.w, 12.h, 16.w, 24.h),
          children: [
            TextField(
              controller: _titleController,
              textInputAction: TextInputAction.next,
              decoration: const InputDecoration(
                labelText: '标题',
                hintText: '今天发生了什么？',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 14.h),
            TextField(
              controller: _contentController,
              minLines: 12,
              maxLines: null,
              keyboardType: TextInputType.multiline,
              decoration: const InputDecoration(
                labelText: '内容',
                hintText: '记录这一刻的想法...',
                alignLabelWithHint: true,
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 16.h),
            // 图片选择按钮
            if (_images.length < 9)
              InkWell(
                onTap: _pickImages,
                child: Container(
                  height: 100.h,
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.grey[300]!,
                      style: BorderStyle.solid,
                    ),
                    borderRadius: BorderRadius.circular(8.r),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.add_photo_alternate,
                        size: 40.sp,
                        color: Colors.grey[400],
                      ),
                      SizedBox(height: 8.h),
                      Text(
                        '添加图片',
                        style: TextStyle(
                          color: Colors.grey[400],
                          fontSize: 14.sp,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            SizedBox(height: 16.h),
            // 图片网格
            if (_images.isNotEmpty)
              GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  crossAxisSpacing: 8.w,
                  mainAxisSpacing: 8.h,
                ),
                itemCount: _images.length,
                itemBuilder: (context, index) {
                  return Stack(
                    children: [
                      GestureDetector(
                        onTap: () => _previewImage(index),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(8.r),
                          child: Image.file(
                            File(_images[index]),
                            fit: BoxFit.cover,
                            width: double.infinity,
                            height: double.infinity,
                          ),
                        ),
                      ),
                      Positioned(
                        top: 4.h,
                        right: 4.w,
                        child: GestureDetector(
                          onTap: () => _removeImage(index),
                          child: Container(
                            padding: EdgeInsets.all(4.w),
                            decoration: BoxDecoration(
                              color: Colors.black54,
                              shape: BoxShape.circle,
                            ),
                            child: Icon(
                              Icons.close,
                              color: Colors.white,
                              size: 16.sp,
                            ),
                          ),
                        ),
                      ),
                    ],
                  );
                },
              ),
          ],
        ),
      ),
    );
  }
}

/// 图片预览页面
class _ImagePreviewPage extends StatefulWidget {
  const _ImagePreviewPage({
    required this.images,
    required this.initialIndex,
  });

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
        iconTheme: const IconThemeData(color: Colors.white),
        title: Text(
          '${_currentIndex + 1}/${widget.images.length}',
          style: const TextStyle(color: Colors.white),
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
          // 左右指示器
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
                        color: Colors.white,
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
                        color: Colors.white,
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

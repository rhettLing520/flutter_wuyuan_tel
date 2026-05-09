import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../data/models/diary_entry.dart';
import '../../services/diary_service.dart';

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

  bool get _isEditing => widget.entry != null;

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController(text: widget.entry?.title ?? '');
    _contentController = TextEditingController(
      text: widget.entry?.content ?? '',
    );
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
      Get.snackbar('提示', '请输入日记标题');
      return;
    }

    if (content.isEmpty) {
      Get.snackbar('提示', '请输入日记内容');
      return;
    }

    if (_isEditing) {
      await _diaryService.updateEntry(
        id: widget.entry!.id,
        title: title,
        content: content,
      );
    } else {
      await _diaryService.addEntry(title: title, content: content);
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
          padding: const EdgeInsets.fromLTRB(16, 12, 16, 24),
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
            const SizedBox(height: 14),
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
          ],
        ),
      ),
    );
  }
}

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:hive_ce/hive_ce.dart';

import 'package:secretchat/pages/home/home_page.dart';
import 'package:secretchat/services/diary_service.dart';

void main() {
  late Directory tempDir;

  setUpAll(() async {
    tempDir = await Directory.systemTemp.createTemp('secretchat_test_');
    Hive.init(tempDir.path);
  });

  setUp(() async {
    Get.reset();
    final box = await Hive.openBox<Map>(DiaryService.boxName);
    await box.clear();
    Get.put<DiaryService>(DiaryService(box));
  });

  tearDown(() async {
    await Hive.close();
    Get.reset();
  });

  tearDownAll(() async {
    if (await tempDir.exists()) {
      await tempDir.delete(recursive: true);
    }
  });

  testWidgets('Home page renders bottom navigation', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(const MaterialApp(home: HomePage()));

    expect(find.text('日记'), findsWidgets);
    expect(find.text('我的'), findsOneWidget);
  });
}

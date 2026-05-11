import 'package:get/get.dart';
import 'package:hive_ce/hive_ce.dart';

import '../data/models/diary_entry.dart';

class DiaryService extends GetxService {
  DiaryService(this._box);

  static const String boxName = 'diary_entries';

  final Box<Map> _box;

  static Future<DiaryService> init() async {
    final box = await Hive.openBox<Map>(boxName);
    return DiaryService(box);
  }

  Stream<BoxEvent> watch() => _box.watch();

  List<DiaryEntry> getEntries() {
    final entries =
        _box.values.map((value) => DiaryEntry.fromMap(value)).toList()
          ..sort((a, b) => b.createdAt.compareTo(a.createdAt));
    return entries;
  }

  DiaryEntry? getEntry(String id) {
    final data = _box.get(id);
    if (data == null) return null;
    return DiaryEntry.fromMap(data);
  }

  Future<void> addEntry({
    required String title,
    required String content,
    List<String> images = const [],
  }) async {
    final now = DateTime.now();
    final entry = DiaryEntry(
      id: now.microsecondsSinceEpoch.toString(),
      title: title.trim(),
      content: content.trim(),
      images: images,
      createdAt: now,
      updatedAt: now,
    );
    await _box.put(entry.id, entry.toMap());
  }

  Future<void> updateEntry({
    required String id,
    required String title,
    required String content,
    List<String>? images,
  }) async {
    final oldEntry = getEntry(id);
    if (oldEntry == null) return;

    final entry = oldEntry.copyWith(
      title: title.trim(),
      content: content.trim(),
      images: images,
      updatedAt: DateTime.now(),
    );
    await _box.put(id, entry.toMap());
  }

  Future<void> deleteEntry(String id) async {
    await _box.delete(id);
  }
}

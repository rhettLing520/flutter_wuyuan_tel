import 'package:get/get.dart';
import 'package:hive_ce/hive_ce.dart';

import '../data/models/countdown_event.dart';

class CountdownService extends GetxService {
  CountdownService(this._box);

  static const String boxName = 'countdown_events';

  final Box<Map> _box;

  static Future<CountdownService> init() async {
    final box = await Hive.openBox<Map>(boxName);
    return CountdownService(box);
  }

  Stream<BoxEvent> watch() => _box.watch();

  List<CountdownEvent> getEvents() {
    final events =
        _box.values.map((value) => CountdownEvent.fromMap(value)).toList()
          ..sort((a, b) => a.targetDate.compareTo(b.targetDate));
    return events;
  }

  CountdownEvent? getEvent(String id) {
    final data = _box.get(id);
    if (data == null) return null;
    return CountdownEvent.fromMap(data);
  }

  Future<void> addEvent({
    required String title,
    required DateTime targetDate,
  }) async {
    final now = DateTime.now();
    final event = CountdownEvent(
      id: now.microsecondsSinceEpoch.toString(),
      title: title.trim(),
      targetDate: targetDate,
    );
    await _box.put(event.id, event.toMap());
  }

  Future<void> deleteEvent(String id) async {
    await _box.delete(id);
  }
}

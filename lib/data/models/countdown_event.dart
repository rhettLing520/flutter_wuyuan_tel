class CountdownEvent {
  const CountdownEvent({
    required this.id,
    required this.title,
    required this.targetDate,
  });

  final String id;
  final String title;
  final DateTime targetDate;

  /// 计算距离目标日期的天数（正数=未来，负数=已过去）
  int get daysRemaining {
    final now = DateTime.now();
    final target = DateTime(targetDate.year, targetDate.month, targetDate.day);
    final today = DateTime(now.year, now.month, now.day);
    return target.difference(today).inDays;
  }

  /// 是否是未来事件
  bool get isFuture => daysRemaining > 0;

  /// 是否是今天
  bool get isToday => daysRemaining == 0;

  factory CountdownEvent.fromMap(Map<dynamic, dynamic> map) {
    return CountdownEvent(
      id: map['id'] as String,
      title: map['title'] as String? ?? '',
      targetDate: DateTime.fromMillisecondsSinceEpoch(
        map['targetDate'] as int? ?? 0,
      ),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'targetDate': targetDate.millisecondsSinceEpoch,
    };
  }

  CountdownEvent copyWith({
    String? title,
    DateTime? targetDate,
  }) {
    return CountdownEvent(
      id: id,
      title: title ?? this.title,
      targetDate: targetDate ?? this.targetDate,
    );
  }
}

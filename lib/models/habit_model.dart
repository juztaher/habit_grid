class Habit {
  final String hId;
  final String hName;
  final String hEmoji;
  final int hDurationCount;
  final List<DateTime> hDuration;
  final Map<DateTime, bool> hRecords;

  Habit({
    required this.hId,
    required this.hName,
    required this.hEmoji,
    required this.hDurationCount,
    required this.hDuration,
    required this.hRecords,
  });

  @override
  String toString() {
    return 'ID: $hId\nName: $hName\nEmoji: $hEmoji\nDuration: ${hDuration.map((dt) => dt.toIso8601String()).join(", ")}\nRecords: ${hRecords.entries.map((entry) => '${entry.key.toIso8601String()}: ${entry.value}').join(", ")}';
  }

  Map<String, dynamic> toMap() {
    return {
      'hId': hId,
      'hName': hName,
      'hEmoji': hEmoji,
      'hDurationCount': hDurationCount,
      'hDuration':
          hDuration.map((dateTime) => dateTime.toIso8601String()).toList(),
      'hRecords':
          hRecords.map((key, value) => MapEntry(key.toIso8601String(), value)),
    };
  }

  factory Habit.fromMap(Map<String, dynamic> map) {
    return Habit(
      hId: map['hId'],
      hName: map['hName'],
      hEmoji: map['hEmoji'],
      hDurationCount: map['hDurationCount'],
      hDuration: List<DateTime>.from(map['hDuration']
          .map((dateTimeString) => DateTime.parse(dateTimeString))),
      hRecords: Map<DateTime, bool>.from(map['hRecords']
          .map((key, value) => MapEntry(DateTime.parse(key), value))),
    );
  }
}

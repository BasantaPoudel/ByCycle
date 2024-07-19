class CustomDateTimeRange {
  /// Creates a date range for the given start and end [DateTime].
  CustomDateTimeRange({
    required this.start,
    required this.end,
    this.phase = '', // Default phase is an empty string
  }) : assert(!start.isAfter(end));

  /// The start of the range of dates.
  final DateTime start;

  /// The end of the range of dates.
  final DateTime end;

  /// The phase of the date range, one of "menstrual", "follicular", "ovulatory", "luteal", or "" by default.
  final String phase;

  /// Returns a [Duration] of the time between [start] and [end].
  ///
  /// See [DateTime.difference] for more details.
  Duration get duration => end.difference(start);

  @override
  bool operator ==(Object other) {
    if (other.runtimeType != runtimeType) {
      return false;
    }
    return other is CustomDateTimeRange &&
        other.start == start &&
        other.end == end &&
        other.phase == phase;
  }

  @override
  int get hashCode => Object.hash(start, end, phase);

  @override
  String toString() => '$start - $end ($phase)';

  Map<String, dynamic> toMap() {
    return {
      'start': start.toIso8601String(), // Convert DateTime to ISO 8601 string
      'end': end.toIso8601String(), // Convert DateTime to ISO 8601 string
      'phase': phase, // Phase as a string
    };
  }

  factory CustomDateTimeRange.fromMap(Map<String, dynamic> map) {
    return CustomDateTimeRange(
      start: DateTime.parse(
          map['start'] as String), // Parse ISO 8601 string to DateTime
      end: DateTime.parse(
          map['end'] as String), // Parse ISO 8601 string to DateTime
      phase: map['phase'] as String, // Extract phase as a string
    );
  }
}

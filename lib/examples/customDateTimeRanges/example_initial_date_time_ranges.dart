import 'package:by_cycle/models/custom_date_time_range.dart';

final List<CustomDateTimeRange> exampleInitialDateTimeRanges = [
  CustomDateTimeRange(
    start: DateTime(2024, 07, 16),
    end: DateTime(2024, 07, 18),
    phase: 'luteal',
  ),
  CustomDateTimeRange(
    start: DateTime(2024, 07, 19),
    end: DateTime(2024, 07, 22),
    phase: 'menstruation',
  ),
  CustomDateTimeRange(
    start: DateTime(2024, 07, 23),
    end: DateTime(2024, 08, 01),
    phase: 'follicular',
  ),
  CustomDateTimeRange(
    start: DateTime(2024, 08, 02),
    end: DateTime(2024, 08, 05),
    phase: 'ovulatory',
  ),
  CustomDateTimeRange(
    start: DateTime(2024, 08, 06),
    end: DateTime(2024, 08, 15),
    phase: 'luteal',
  ),
];

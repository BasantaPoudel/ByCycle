import 'package:by_cycle/models/user.dart';

List<DateTime> initialSpottingOccurrences = [
  DateTime(2024, 6, 10), // Example: Specific date
];

User new_pcos_pa = User(
  name: 'PCOS PA',
  email: 'pcos_pa@example.com',
  lastPeriod: DateTime(2024, 6, 29),
  menstruationPhaseLength: 12,
  completeCycleLength: 30,
  timeToFallAsleep: 20,
  cycleRegular: true,
  cycleHeavy: false,
  would_like_reminders_about_data_log_in: false,
  would_like_reminders_about_self_care_checklist: false,
  dailyDataInput: [],
  algorithmData: {
    "averageSleepTime": {
      "menstruation": {
        "inMinutes": 0,
        "count": 0,
      },
      "follicular": {
        "inMinutes": 467,
        "count": 1,
      },
      "ovulation": {
        "inMinutes": 0,
        "count": 0,
      },
      "luteal": {
        "inMinutes": 0,
        "count": 0,
      },
    }
  },
);

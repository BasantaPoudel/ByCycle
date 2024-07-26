import 'package:by_cycle/models/user.dart';
import 'package:flutter/material.dart';

List<DateTime> initialSpottingOccurrences = [
  DateTime(2024, 6, 10), // Example: Specific date
];

User new_ovulating_user = User(
  name: 'Ovulating user',
  email: 'ovulating.user@example.com',
  lastPeriod: DateTime(2024, 5, 16),
  menstruationPhaseLength: 4,
  completeCycleLength: 28,
  timeToFallAsleep: 20,
  cycleRegular: true,
  cycleHeavy: false,
  bedTime: TimeOfDay(hour: 22, minute: 55),
  would_like_reminders_about_data_log_in: false,
  would_like_reminders_about_self_care_checklist: false,
  dailyDataInput: [],
  algorithmData: {
    "averageSleepTime": {
      "menstruation": {
        "inMinutes": 466,
        "count": 5,
      },
      "follicular": {
        "inMinutes": 577,
        "count": 1,
      },
      "ovulation": {
        "inMinutes": 501,
        "count": 2,
      },
      "luteal": {
        "inMinutes": 0,
        "count": 0,
      },
    }
  },
);

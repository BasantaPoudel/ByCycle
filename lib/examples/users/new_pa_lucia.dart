import 'package:by_cycle/models/user_model.dart';
import 'package:flutter/material.dart';

List<DateTime> initialSpottingOccurrences = [
  DateTime(2024, 6, 10), // Example: Specific date
];

UserModel new_pa_lucia = UserModel(
  name: 'Lucia - PA',
  email: 'lucia_pa@example.com',
  lastPeriod: DateTime(2024, 5, 24),
  menstruationPhaseLength: 4,
  completeCycleLength: 28,
  timeToFallAsleep: 20,
  cycleRegular: true,
  cycleHeavy: false,
  bedTime: const TimeOfDay(hour: 23, minute: 20),
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

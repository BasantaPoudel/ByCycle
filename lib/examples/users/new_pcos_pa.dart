import 'package:by_cycle/models/user_model.dart';
import 'package:flutter/material.dart';

List<DateTime> initialSpottingOccurrences = [
  DateTime(2024, 6, 10), // Example: Specific date
];

UserModel new_pcos_pa = UserModel(
  name: 'PCOS PA',
  email: 'pcos_pa@example.com',
  lastPeriod: DateTime(2024, 6, 29),
  menstruationPhaseLength: 12,
  completeCycleLength: 30,
  timeToFallAsleep: 20,
  cycleRegular: true,
  cycleHeavy: false,
  bedTime: const TimeOfDay(hour: 22, minute: 20),
  would_like_reminders_about_data_log_in: false,
  would_like_reminders_about_self_care_checklist: false,
  dailyDataInput: [],
  algorithmData: {
    "averageSleepTime": {
      "menstruation": {
        "inMinutes": 499,
        "count": 20,
      },
      "follicular": {
        "inMinutes": 467,
        "count": 1,
      },
      "ovulation": {
        "inMinutes": 444,
        "count": 2,
      },
      "luteal": {
        "inMinutes": 478,
        "count": 1,
      },
    }
  },
);

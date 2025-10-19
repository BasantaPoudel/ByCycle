import 'package:by_cycle/models/user_model.dart';
import 'package:flutter/material.dart';

List<DateTime> initialSpottingOccurrences = [
  DateTime(2024, 6, 10), // Example: Specific date
];

UserModel new_pb_longer_cycle = UserModel(
  name: 'PB Longer Cycle',
  email: 'pblongercycle@example.com',
  lastPeriod: DateTime(2024, 7, 24),
  menstruationPhaseLength: 7,
  completeCycleLength: 33,
  timeToFallAsleep: 20,
  cycleRegular: false,
  cycleHeavy: false,
  bedTime: const TimeOfDay(hour: 23, minute: 25),
  would_like_reminders_about_data_log_in: true,
  would_like_reminders_about_self_care_checklist: true,
  dailyDataInput: [],
  algorithmData: {
    "averageSleepTime": {
      "menstruation": {
        "inMinutes": 0,
        "count": 0,
      },
      "follicular": {
        "inMinutes": 479,
        "count": 3,
      },
      "ovulation": {
        "inMinutes": 476,
        "count": 1,
      },
      "luteal": {
        "inMinutes": 0,
        "count": 0,
      },
    }
  },
);

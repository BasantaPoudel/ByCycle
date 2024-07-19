import 'package:by_cycle/models/user.dart';

List<DateTime> initialSpottingOccurrences = [
  DateTime(2024, 6, 10), // Example: Specific date
];

User new_user = User(
  name: 'PA Lucia',
  email: 'pa_lucia@example.com',
  lastPeriod: DateTime(2024, 5, 24),
  menstruationPhaseLength: 4,
  completeCycleLength: 28,
  timeToFallAsleep: 20,
  cycleRegular: true,
  cycleHeavy: false,
  would_like_reminders_about_data_log_in: false,
  would_like_reminders_about_self_care_checklist: false,
  dailyDataInput: [],
);

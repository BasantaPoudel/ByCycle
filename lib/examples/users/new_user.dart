import 'package:by_cycle/models/user.dart';

List<DateTime> initialSpottingOccurrences = [
  DateTime(2024, 6, 10), // Example: Specific date
];

AlgorithmData testAlgorithmData = AlgorithmData(
  blood: [], // Initialize with empty list or provide actual data
  backpain: [], // Initialize with empty list or provide actual data
  menstruation: [], // Initialize with empty list or provide actual data
  luteal: [], // Initialize with empty list or provide actual data
  temperature: [], // Initialize with empty list or provide actual data
  spottingOccurences: initialSpottingOccurrences,
);

User new_user = User(
  name: 'PA Lucia',
  email: 'pa_lucia@example.com',
  last_period: DateTime(2024, 5, 24),
  menstuation_phase_length: 4,
  complete_cycle_length: 28,
  time_to_fall_asleep: 20,
  cycle_regular: true,
  cycle_heavy: false,
  would_like_reminders_about_data_log_in: false,
  would_like_reminders_about_self_care_checklist: false,
  daily_data_input: [],
  algorithm_data: AlgorithmData(), // Using default values for algorithmData
);

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

List<DailyDataInput> dailyDataInputstest_user = [
  DailyDataInput(
    blood: 'no',
    date: DateTime(2024, 7, 4),
    discharge: 'Creamy',
    energy_level: 'medium',
    hours_of_sleep: 7,
    symptoms: ['mood swings'],
    temperature: 36.5,
    phase: "luteal",
  ),
  DailyDataInput(
    blood: 'no',
    date: DateTime(2024, 7, 5),
    discharge: 'Creamy',
    energy_level: 'low',
    hours_of_sleep: 6,
    symptoms: ['cramps'],
    temperature: 36.0,
    phase: "luteal",
  ),
  DailyDataInput(
    blood: 'no',
    date: DateTime(2024, 7, 6),
    discharge: 'Creamy',
    energy_level: 'low',
    hours_of_sleep: 8,
    symptoms: ['diarrhoea'],
    temperature: 36.3,
    phase: "luteal",
  ),
  DailyDataInput(
    blood: 'no',
    date: DateTime(2024, 7, 7),
    discharge: 'spotting',
    energy_level: 'medium',
    hours_of_sleep: 6,
    symptoms: ['no'],
    temperature: 36.6,
    phase: "menstrual",
  ),
  DailyDataInput(
    blood: 'no',
    date: DateTime(2024, 7, 8),
    discharge: 'spotting',
    energy_level: 'medium',
    hours_of_sleep: 6,
    symptoms: ['no'],
    temperature: 36.6,
    phase: "menstrual",
  ),
  DailyDataInput(
    blood: 'no',
    date: DateTime(2024, 7, 9),
    discharge: 'spotting',
    energy_level: 'medium',
    hours_of_sleep: 6,
    symptoms: ['no'],
    temperature: 36.6,
    phase: "menstrual",
  ),
];

User user_in_menstrual_phase = User(
  name: 'PA Lucia',
  email: 'pa_lucia@example.com',
  last_period: DateTime(2024, 7, 7),
  menstuation_phase_length: 6,
  complete_cycle_length: 28,
  time_to_fall_asleep: 20,
  cycle_regular: true,
  cycle_heavy: false,
  would_like_reminders_about_data_log_in: false,
  would_like_reminders_about_self_care_checklist: false,
  daily_data_input: dailyDataInputstest_user,
  algorithm_data: AlgorithmData(), // Using default values for algorithmData
);

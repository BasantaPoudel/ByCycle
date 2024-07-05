import 'package:by_cycle/models/user.dart';

List<DailyDataInput> dailyDataInputsPCOS_PA = [
  DailyDataInput(
    blood: 'no',
    date: DateTime(2024, 3, 29),
    discharge: 'Creamy',
    energy_level: 'medium',
    hours_of_sleep: 8,
    symptoms: ['mood swings'],
    temperature: 36.9,
  ),
  DailyDataInput(
    blood: 'no',
    date: DateTime(2024, 3, 30),
    discharge: 'Creamy',
    energy_level: 'high',
    hours_of_sleep: 6,
    symptoms: ['anxiety'],
    temperature: 36.7,
  ),
  DailyDataInput(
    blood: 'no',
    date: DateTime(2024, 3, 31),
    discharge: 'Creamy',
    energy_level: 'low',
    hours_of_sleep: 3,
    symptoms: ['anxiety'],
    temperature: 36.8,
  ),
  DailyDataInput(
    blood: 'no',
    date: DateTime(2024, 4, 1),
    discharge: 'Creamy',
    energy_level: 'medium',
    hours_of_sleep: 7,
    symptoms: ['bloating'],
    temperature: 36.5,
  ),
  DailyDataInput(
    blood: 'no',
    date: DateTime(2024, 4, 2),
    discharge: 'Creamy',
    energy_level: 'low',
    hours_of_sleep: 6,
    symptoms: ['nausea'],
    temperature: 36.3,
  ),
];

User pcos_pa = User(
  name: 'PCOS PA', // Add the missing 'name' property
  email: 'pcos_pa@example.com',
  last_period: DateTime(2024, 3, 6),
  menstuation_phase_length: 12, // Assuming this is 'period_length' renamed
  complete_cycle_length: 30, // This is 'cycle_length'
  time_to_fall_asleep: 0,
  cycle_regular: false,
  cycle_heavy: false,
  would_like_reminders_about_data_log_in: false,
  would_like_reminders_about_self_care_checklist: false,
  daily_data_input: dailyDataInputsPCOS_PA,
  algorithm_data: AlgorithmData(), // Using default values for algorithmData
);

import 'package:by_cycle/models/user.dart';

List<DailyDataInput> dailyDataInputs = [
  DailyDataInput(
    blood: 'no',
    date: DateTime(2024, 3, 6),
    discharge: 'Creamy',
    energy_level: 'medium',
    hours_of_sleep: 7,
    symptoms: [],
    temperature: 36.3,
  ),
  DailyDataInput(
    blood: 'no',
    date: DateTime(2024, 3, 7),
    discharge: 'watery',
    energy_level: 'high',
    hours_of_sleep: 8,
    symptoms: [],
    temperature: 36.4,
  ),
  DailyDataInput(
    blood: 'no',
    date: DateTime(2024, 3, 8),
    discharge: 'watery',
    energy_level: 'medium',
    hours_of_sleep: 9,
    symptoms: [],
    temperature: 36.6,
  ),
  DailyDataInput(
    blood: 'no',
    date: DateTime(2024, 3, 9),
    discharge: 'creamy',
    energy_level: 'high',
    hours_of_sleep: 7,
    symptoms: [],
    temperature: 36.5,
  ),
  DailyDataInput(
    blood: 'no',
    date: DateTime(2024, 3, 10),
    discharge: 'Creamy',
    energy_level: 'medium',
    hours_of_sleep: 8,
    symptoms: [],
    temperature: 36.8,
  ),
];

User irregular_cycle_pb = User(
  name: 'Irregular Cycle PB', // Add the missing 'name' property
  email: 'irregular_pb@example.com', // Adjusted email for uniqueness
  last_period: DateTime(2024, 3, 6),
  menstuation_phase_length: 12, // Assuming this is 'period_length' renamed
  complete_cycle_length: 30, // This is 'cycle_length'
  time_to_fall_asleep: 0,
  cycle_regular: false,
  cycle_heavy: false,
  would_like_reminders_about_data_log_in: false,
  would_like_reminders_about_self_care_checklist: false,
  daily_data_input: dailyDataInputs,
);

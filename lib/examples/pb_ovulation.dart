import 'package:by_cycle/models/user.dart';

// Define the DailyDataInput list with example data for ovulation period
List<DailyDataInput> dailyDataInputsPB_Ovulation = [
  DailyDataInput(
    blood: 'no',
    date: DateTime(2024, 6, 18),
    discharge: 'egg white',
    energy_level: 'medium',
    hours_of_sleep: 7,
    symptoms: ['anxiety'],
    temperature: 36.2,
  ),
  DailyDataInput(
    blood: 'no',
    date: DateTime(2024, 6, 19),
    discharge: 'watery',
    energy_level: 'high',
    hours_of_sleep: 6,
    symptoms: ['abdominal pain'],
    temperature: 36.3,
  ),
  DailyDataInput(
    blood: 'no',
    date: DateTime(2024, 6, 20),
    discharge: 'watery',
    energy_level: 'medium',
    hours_of_sleep: 8,
    symptoms: [],
    temperature: 36.4,
  ),
  DailyDataInput(
    blood: 'no',
    date: DateTime(2024, 6, 21),
    discharge: 'sticky',
    energy_level: 'medium',
    hours_of_sleep: 6,
    symptoms: [],
    temperature: 36.2,
  ),
  DailyDataInput(
    blood: 'no',
    date: DateTime(2024, 6, 22),
    discharge: 'Creamy',
    energy_level: 'high',
    hours_of_sleep: 6,
    symptoms: [],
    temperature: 36.6,
  ),
  // Adding two more DailyDataInput instances
  DailyDataInput(
    blood: 'no',
    date: DateTime(2024, 6, 23),
    discharge: 'watery',
    energy_level: 'low',
    hours_of_sleep: 7,
    symptoms: ['fatigue'],
    temperature: 36.4,
  ),
  DailyDataInput(
    blood: 'no',
    date: DateTime(2024, 6, 24),
    discharge: 'egg white',
    energy_level: 'medium',
    hours_of_sleep: 8,
    symptoms: ['headache'],
    temperature: 36.5,
  ),
];

// Instantiate the User class with the example data for ovulation period
User pb_ovulation = User(
  name: 'PB Ovulation',
  email: 'pb_ovulation@example.com',
  last_period: DateTime(2024, 6, 4),
  menstuation_phase_length: 5,
  complete_cycle_length: 29,
  time_to_fall_asleep: 20,
  cycle_regular: true,
  cycle_heavy: false,
  would_like_reminders_about_data_log_in: false,
  would_like_reminders_about_self_care_checklist: false,
  daily_data_input: dailyDataInputsPB_Ovulation,
);

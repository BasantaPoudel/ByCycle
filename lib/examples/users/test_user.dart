import 'package:by_cycle/models/user.dart';

List<DailyDataInput> dailyDataInputstest_user = [
  DailyDataInput(
    blood: 'no',
    date: DateTime(2024, 6, 18),
    discharge: 'Creamy',
    energy_level: 'medium',
    hours_of_sleep: 7,
    symptoms: ['mood swings'],
    temperature: 36.5,
    phase: "luteal",
  ),
  DailyDataInput(
    blood: 'no',
    date: DateTime(2024, 6, 19),
    discharge: 'Creamy',
    energy_level: 'low',
    hours_of_sleep: 6,
    symptoms: ['cramps'],
    temperature: 36.0,
    phase: "luteal",
  ),
  DailyDataInput(
    blood: 'no',
    date: DateTime(2024, 6, 20),
    discharge: 'Creamy',
    energy_level: 'low',
    hours_of_sleep: 8,
    symptoms: ['diarrhoea'],
    temperature: 36.3,
    phase: "menstruation",
  ),
  DailyDataInput(
    blood: 'no',
    date: DateTime(2024, 6, 21),
    discharge: 'Creamy',
    energy_level: 'medium',
    hours_of_sleep: 6,
    symptoms: ['no'],
    temperature: 36.6,
    phase: "menstruation",
  ),
  /*DailyDataInput(
    blood: 'no',
    date: DateTime(2024, 6, 22),
    discharge: 'Creamy',
    energy_level: 'low',
    hours_of_sleep: 6,
    symptoms: ['no'],
    temperature: 36.2,
  ),*/
];

User test_user = User(
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
  daily_data_input: dailyDataInputstest_user,
);

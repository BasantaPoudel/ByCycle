class User {
  bool cycle_heavy;
  int cycle_length;
  bool cycle_regular;
  String email;
  DateTime last_period;
  String password;
  int period_length;
  String reminder_preference;
  int time_to_fall_asleep;
  bool would_like_reminders_about_data_log_in;
  List<DailyDataInput> daily_data_input;

  User({
    this.cycle_heavy = false,
    this.cycle_length = 0,
    this.cycle_regular = false,
    required this.email,
    required this.last_period,
    this.password = '',
    this.period_length = 0,
    this.reminder_preference = '',
    this.time_to_fall_asleep = 20,
    this.would_like_reminders_about_data_log_in = false,
    this.daily_data_input = const [],
  });

  Map<String, dynamic> toMap() {
    return {
      'cycle_heavy': cycle_heavy,
      'cycle_length': cycle_length,
      'cycle_regular': cycle_regular,
      'email': email,
      'last_period': last_period,
      'password': password,
      'period_length': period_length,
      'reminder_preference': reminder_preference,
      'time_to_fall_asleep': time_to_fall_asleep,
      'would_like_reminders_about_data_log_in':
          would_like_reminders_about_data_log_in,
      'daily_data_input':
          daily_data_input.map((input) => input.toMap()).toList(),
    };
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      cycle_heavy: map['cycle_heavy'],
      cycle_length: map['cycle_length'],
      cycle_regular: map['cycle_regular'],
      email: map['email'],
      last_period: map['last_period'].toDate(),
      password: map['password'],
      period_length: map['period_length'],
      reminder_preference: map['reminder_preference'],
      time_to_fall_asleep: map['time_to_fall_asleep'],
      would_like_reminders_about_data_log_in:
          map['would_like_reminders_about_data_log_in'],
      daily_data_input: List<DailyDataInput>.from(
        map['daily_data_input']
                ?.map((input) => DailyDataInput.fromMap(input)) ??
            const [],
      ),
    );
  }
}

class DailyDataInput {
  String blood;
  DateTime date;
  String discharge;
  String energy_level;
  int hours_of_sleep;
  List<String> symptoms;
  double temperature;

  DailyDataInput({
    this.blood = '',
    required this.date,
    this.discharge = '',
    this.energy_level = '',
    this.hours_of_sleep = 0,
    this.symptoms = const [],
    this.temperature = 0,
  });

  Map<String, dynamic> toMap() {
    return {
      'blood': blood,
      'date': date,
      'discharge': discharge,
      'energy_level': energy_level,
      'hours_of_sleep': hours_of_sleep,
      'symptoms': symptoms,
      'temperature': temperature,
    };
  }

  factory DailyDataInput.fromMap(Map<String, dynamic> map) {
    return DailyDataInput(
      blood: map['blood'] ?? '',
      date: map['date']
          .toDate(), // Assuming 'date' is stored as Firestore Timestamp
      discharge: map['discharge'] ?? '',
      energy_level: map['energy_level'] ?? '',
      hours_of_sleep: map['hours_of_sleep'] ??
          0, // Ensure this matches the stored data type
      symptoms: List<String>.from(map['symptoms'] ?? []),
      temperature: map['temperature'].toDouble() ?? 0,
    );
  }
}

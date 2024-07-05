class User {
  String name;
  String email;
  DateTime last_period;
  int menstuation_phase_length;
  int complete_cycle_length;
  int time_to_fall_asleep;
  bool cycle_regular;
  bool cycle_heavy;
  bool would_like_reminders_about_data_log_in;
  bool would_like_reminders_about_self_care_checklist;
  List<DailyDataInput> daily_data_input;
  AlgorithmData algorithm_data; // Instance of AlgorithmData added here

  User({
    required this.name,
    required this.email,
    required this.last_period,
    this.menstuation_phase_length = 0,
    this.complete_cycle_length = 0,
    this.time_to_fall_asleep = 20,
    this.cycle_regular = false,
    this.cycle_heavy = false,
    this.would_like_reminders_about_data_log_in = false,
    this.would_like_reminders_about_self_care_checklist = false,
    this.daily_data_input = const [],
    required this.algorithm_data, // Initialize algorithm_data here
  });

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'email': email,
      'last_period': last_period,
      'menstuation_phase_length': menstuation_phase_length,
      'complete_cycle_length': complete_cycle_length,
      'time_to_fall_asleep': time_to_fall_asleep,
      'cycle_regular': cycle_regular,
      'cycle_heavy': cycle_heavy,
      'would_like_reminders_about_data_log_in':
          would_like_reminders_about_data_log_in,
      'would_like_reminders_about_self_care_checklist':
          would_like_reminders_about_self_care_checklist,
      'daily_data_input':
          daily_data_input.map((input) => input.toMap()).toList(),
      'algorithm_data': algorithm_data.toMap(), // Convert algorithm_data to map
    };
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      name: map['name'],
      email: map['email'],
      last_period: map['last_period'].toDate(),
      menstuation_phase_length: map['menstuation_phase_length'],
      complete_cycle_length: map['complete_cycle_length'],
      time_to_fall_asleep: map['time_to_fall_asleep'],
      cycle_regular: map['cycle_regular'],
      cycle_heavy: map['cycle_heavy'],
      would_like_reminders_about_data_log_in:
          map['would_like_reminders_about_data_log_in'],
      would_like_reminders_about_self_care_checklist:
          map['would_like_reminders_about_self_care_checklist'],
      daily_data_input: List<DailyDataInput>.from(
        map['daily_data_input']
                ?.map((input) => DailyDataInput.fromMap(input)) ??
            const [],
      ),
      algorithm_data: AlgorithmData.fromMap(
          map['algorithm_data']), // Initialize algorithm_data from map
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
  String
      phase; // Should be equal to "menstrual", "follicular", "ovulatory" or "luteal"

  DailyDataInput({
    this.blood = '',
    required this.date,
    this.discharge = '',
    this.energy_level = '',
    this.hours_of_sleep = 0,
    this.symptoms = const [],
    this.temperature = 0,
    this.phase = "",
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
      'phase': phase,
    };
  }

  factory DailyDataInput.fromMap(Map<String, dynamic> map) {
    return DailyDataInput(
      blood: map['blood'] ?? '',
      date: map['date'].toDate(),
      discharge: map['discharge'] ?? '',
      energy_level: map['energy_level'] ?? '',
      hours_of_sleep: map['hours_of_sleep'] ?? 0,
      symptoms: List<String>.from(map['symptoms'] ?? []),
      temperature: map['temperature']?.toDouble() ?? 0,
      phase: map['phase'] ?? '', // Assuming 'phase' is stored in the map
    );
  }
}

class AlgorithmData {
  List<Map<String, dynamic>> blood;
  List<Map<String, dynamic>> backpain;
  List<Map<String, dynamic>> menstruation;
  List<Map<String, dynamic>> luteal;
  List<Map<String, dynamic>> temperature;

  List<DateTime> spottingOccurences; // Changed to List<DateTime>

  AlgorithmData({
    this.blood = const [],
    this.backpain = const [],
    this.menstruation = const [],
    this.luteal = const [],
    this.temperature = const [],
    this.spottingOccurences = const [],
  });
  // Convert InsightsCache instance to a Map
  Map<String, dynamic> toMap() {
    return {
      'blood': blood,
      'backpain': backpain,
      'menstruation': menstruation,
      'luteal': luteal,
      'temperature': temperature,
      'spottingOccurences': spottingOccurences
          .map((date) => date.toIso8601String())
          .toList(), // Convert List of DateTime to List of Strings
    };
  }

  // Create an InsightsCache instance from a Map
  // Create an AlgorithmData instance from a Map
  factory AlgorithmData.fromMap(Map<String, dynamic> map) {
    return AlgorithmData(
      blood: (map['blood'] as List<dynamic>?)
              ?.map((item) => item as Map<String, dynamic>)
              .toList() ??
          [],
      backpain: (map['backpain'] as List<dynamic>?)
              ?.map((item) => item as Map<String, dynamic>)
              .toList() ??
          [],
      menstruation: (map['menstruation'] as List<dynamic>?)
              ?.map((item) => item as Map<String, dynamic>)
              .toList() ??
          [],
      luteal: (map['luteal'] as List<dynamic>?)
              ?.map((item) => item as Map<String, dynamic>)
              .toList() ??
          [],
      temperature: (map['temperature'] as List<dynamic>?)
              ?.map((item) => item as Map<String, dynamic>)
              .toList() ??
          [],
      spottingOccurences: (map['spottingOccurences'] as List<dynamic>?)
              ?.map((date) => DateTime.parse(date))
              .toList() ??
          [],
    );
  }

  @override
  String toString() {
    return toMap().toString();
  }
}

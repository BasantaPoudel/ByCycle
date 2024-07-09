import 'package:by_cycle/models/tag.dart';

Map<String, List<InsightInfo>> defaultTags = {
  "blood": [
    InsightInfo(
        insightId: "insight1",
        viewCounter: 0,
        tags: ["backpain", "menstruation"]),
    InsightInfo(
        insightId: "insight2",
        viewCounter: 0,
        tags: ["headache", "skin issues"]),
  ],
  "temperature": [
    InsightInfo(insightId: "insight3", viewCounter: 0, tags: ["luteal phase"])
  ],
  "backpain": [
    InsightInfo(
        insightId: "insight1", viewCounter: 0, tags: ["blood", "menstruation"])
  ],
};

class User {
  String name;
  String email;
  DateTime last_period;
  int menstuation_phase_length;
  int follicular_phase_length;
  int ovulatory_phase_length;
  int luteal_phase_length;
  int complete_cycle_length;
  int time_to_fall_asleep;
  bool cycle_regular;
  bool cycle_heavy;
  bool would_like_reminders_about_data_log_in;
  bool would_like_reminders_about_self_care_checklist;
  List<DailyDataInput> daily_data_input;
  AlgorithmData algorithm_data;
  Map<String, List<InsightInfo>> tags;

  User({
    required this.name,
    required this.email,
    required this.last_period,
    this.menstuation_phase_length = 0,
    this.follicular_phase_length = 0,
    this.ovulatory_phase_length = 0,
    this.luteal_phase_length = 0,
    this.complete_cycle_length = 0,
    this.time_to_fall_asleep = 20,
    this.cycle_regular = false,
    this.cycle_heavy = false,
    this.would_like_reminders_about_data_log_in = false,
    this.would_like_reminders_about_self_care_checklist = false,
    this.daily_data_input = const [],
    required this.algorithm_data,
    this.tags = const {},
  }) {
    tags = defaultTags;
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'email': email,
      'last_period': last_period.toIso8601String(),
      'menstuation_phase_length': menstuation_phase_length,
      'follicular_phase_length': follicular_phase_length,
      'ovulatory_phase_length': ovulatory_phase_length,
      'luteal_phase_length': luteal_phase_length,
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
      'algorithm_data': algorithm_data.toMap(),
      'tags': tags.map((key, value) =>
          MapEntry(key, value.map((tag) => tag.toMap()).toList())),
    };
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      name: map['name'],
      email: map['email'],
      last_period: DateTime.parse(map['last_period']),
      menstuation_phase_length: map['menstuation_phase_length'] ?? 0,
      follicular_phase_length: map['follicular_phase_length'] ?? 0,
      ovulatory_phase_length: map['ovulatory_phase_length'] ?? 0,
      luteal_phase_length: map['luteal_phase_length'] ?? 0,
      complete_cycle_length: map['complete_cycle_length'] ?? 0,
      time_to_fall_asleep: map['time_to_fall_asleep'] ?? 20,
      cycle_regular: map['cycle_regular'] ?? false,
      cycle_heavy: map['cycle_heavy'] ?? false,
      would_like_reminders_about_data_log_in:
          map['would_like_reminders_about_data_log_in'] ?? false,
      would_like_reminders_about_self_care_checklist:
          map['would_like_reminders_about_self_care_checklist'] ?? false,
      daily_data_input: List<DailyDataInput>.from(
        map['daily_data_input']
                ?.map((input) => DailyDataInput.fromMap(input)) ??
            const [],
      ),
      algorithm_data: AlgorithmData.fromMap(map['algorithm_data']),
      tags: (map['tags'] as Map<String, dynamic>?)?.map(
            (key, value) => MapEntry(
                key,
                List<InsightInfo>.from(
                    value.map((item) => InsightInfo.fromMap(item)))),
          ) ??
          defaultTags,
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
  String phase;

  DailyDataInput({
    this.blood = '',
    required this.date,
    this.discharge = '',
    this.energy_level = '',
    this.hours_of_sleep = 0,
    this.symptoms = const [],
    this.temperature = 0,
    this.phase =
        "", // Should be equal to "menstrual", "follicular", "ovulatory" or "luteal"
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
      date: DateTime.parse(map['date']),
      discharge: map['discharge'] ?? '',
      energy_level: map['energy_level'] ?? '',
      hours_of_sleep: map['hours_of_sleep'] ?? 0,
      symptoms: List<String>.from(map['symptoms'] ?? []),
      temperature: map['temperature']?.toDouble() ?? 0,
      phase: map['phase'] ?? '',
    );
  }

  @override
  String toString() {
    return 'DailyDataInput(blood: $blood, date: $date, discharge: $discharge, energy_level: $energy_level, hours_of_sleep: $hours_of_sleep, symptoms: $symptoms, temperature: $temperature, phase: $phase)';
  }
}

class AlgorithmData {
  List<DateTime> spottingOccurences;

  AlgorithmData({
    this.spottingOccurences = const [],
  });

  Map<String, dynamic> toMap() {
    return {
      'spottingOccurences':
          spottingOccurences.map((date) => date.toIso8601String()).toList(),
    };
  }

  factory AlgorithmData.fromMap(Map<String, dynamic> map) {
    return AlgorithmData(
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

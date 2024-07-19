import 'package:by_cycle/models/custom_date_time_range.dart';

class User {
  String name;
  String email;
  DateTime lastPeriod;
  int menstruationPhaseLength;
  int follicularPhaseLength;
  int ovulationPhaseLength;
  int lutealPhaseLength;
  int completeCycleLength;
  int timeToFallAsleep;
  bool cycleRegular;
  bool cycleHeavy;
  bool would_like_reminders_about_data_log_in;
  bool would_like_reminders_about_self_care_checklist;
  List<DailyDataInput> dailyDataInput;
  List<CustomDateTimeRange> phaseRanges;
  Map<String, dynamic> algorithmData;
  Map<String, List<InsightInfo>> tags;

  User({
    required this.name,
    required this.email,
    required this.lastPeriod,
    this.menstruationPhaseLength = 0,
    this.follicularPhaseLength = 0,
    this.ovulationPhaseLength = 0,
    this.lutealPhaseLength = 0,
    this.completeCycleLength = 0,
    this.timeToFallAsleep = 20,
    this.cycleRegular = false,
    this.cycleHeavy = false,
    this.would_like_reminders_about_data_log_in = false,
    this.would_like_reminders_about_self_care_checklist = false,
    this.dailyDataInput = const [],
    this.phaseRanges = const [],
    this.algorithmData = const {},
    this.tags = const {},
  });

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'email': email,
      'last_period': lastPeriod,
      'menstuation_phase_length': menstruationPhaseLength,
      'follicular_phase_length': follicularPhaseLength,
      'ovulation_phase_length': ovulationPhaseLength,
      'luteal_phase_length': lutealPhaseLength,
      'complete_cycle_length': completeCycleLength,
      'time_to_fall_asleep': timeToFallAsleep,
      'cycle_regular': cycleRegular,
      'cycle_heavy': cycleHeavy,
      'would_like_reminders_about_data_log_in':
          would_like_reminders_about_data_log_in,
      'would_like_reminders_about_self_care_checklist':
          would_like_reminders_about_self_care_checklist,
      'daily_data_input': dailyDataInput.map((input) => input.toMap()).toList(),
      'phase_ranges': phaseRanges.map((input) => input.toMap()).toList(),
      'algorithm_data': algorithmData,
      'tags': tags.map((key, value) =>
          MapEntry(key, value.map((tag) => tag.toMap()).toList())),
    };
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      name: map['name'],
      email: map['email'],
      lastPeriod: map['last_period'].toDate(),
      menstruationPhaseLength: map['menstuation_phase_length'],
      follicularPhaseLength: map['follicular_phase_length'],
      ovulationPhaseLength: map['ovulation_phase_length'],
      lutealPhaseLength: map['luteal_phase_length'],
      completeCycleLength: map['complete_cycle_length'],
      timeToFallAsleep: map['time_to_fall_asleep'],
      cycleRegular: map['cycle_regular'],
      cycleHeavy: map['cycle_heavy'],
      would_like_reminders_about_data_log_in:
          map['would_like_reminders_about_data_log_in'],
      would_like_reminders_about_self_care_checklist:
          map['would_like_reminders_about_self_care_checklist'],
      dailyDataInput: List<DailyDataInput>.from(
        map['daily_data_input']
                ?.map((input) => DailyDataInput.fromMap(input)) ??
            const [],
      ),
      phaseRanges: List<CustomDateTimeRange>.from(
        map['phase_ranges']
                ?.map((input) => CustomDateTimeRange.fromMap(input)) ??
            const [],
      ),
      algorithmData: Map<String, dynamic>.from(map['algorithm_data'] ?? {}),
      tags: (map['tags'] as Map<String, dynamic>?)?.map(
            (key, value) => MapEntry(
                key,
                List<InsightInfo>.from(
                    value.map((item) => InsightInfo.fromMap(item)))),
          ) ??
          {},
    );
  }
}

class DailyDataInput {
  String blood;
  DateTime date;
  String discharge;
  String energyLevel;
  int hoursOfSleep;
  List<String> symptoms;
  double temperature;
  String phase;

  DailyDataInput({
    this.blood = '',
    required this.date,
    this.discharge = '',
    this.energyLevel = '',
    this.hoursOfSleep = 0,
    this.symptoms = const [],
    this.temperature = 0,
    this.phase =
        "", // Should be equal to "menstrual", "follicular", "ovulation" or "luteal"
  });

  Map<String, dynamic> toMap() {
    return {
      'blood': blood,
      'date': date,
      'discharge': discharge,
      'energy_level': energyLevel,
      'hours_of_sleep': hoursOfSleep,
      'symptoms': symptoms,
      'temperature': temperature,
      'phase': phase,
    };
  }

  factory DailyDataInput.fromMap(Map<String, dynamic> map) {
    return DailyDataInput(
      blood: map['blood'] ?? '',
      date: map['date']
          .toDate(), // Assuming 'date' is stored as Firestore Timestamp
      discharge: map['discharge'] ?? '',
      energyLevel: map['energy_level'] ?? '',
      hoursOfSleep: map['hours_of_sleep'] ??
          0, // Ensure this matches the stored data type
      symptoms: List<String>.from(map['symptoms'] ?? []),
      temperature: map['temperature'].toDouble() ?? 0,
      phase: map['phase'] ?? '',
    );
  }

  @override
  String toString() {
    return 'DailyDataInput(blood: $blood, date: $date, discharge: $discharge, energy_level: $energyLevel, hours_of_sleep: $hoursOfSleep, symptoms: $symptoms, temperature: $temperature, phase: $phase)';
  }
}

class InsightInfo {
  String insightId;
  int viewCounter;
  List<String> tags;

  InsightInfo({
    required this.insightId,
    required this.viewCounter,
    required this.tags,
  });

  Map<String, dynamic> toMap() {
    return {
      'insightId': insightId,
      'viewCounter': viewCounter,
      'tags': tags,
    };
  }

  factory InsightInfo.fromMap(Map<String, dynamic> map) {
    return InsightInfo(
      insightId: map['insightId'] ?? '',
      viewCounter: map['viewCounter'] ?? 0,
      tags: List<String>.from(map['tags'] ?? []),
    );
  }

  @override
  String toString() {
    return 'InsightInfo(insightId: $insightId, viewCounter: $viewCounter, tags: $tags)';
  }
}

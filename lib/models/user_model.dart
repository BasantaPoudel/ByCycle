import 'package:by_cycle/models/custom_date_time_range.dart';
import 'package:by_cycle/models/daily_data_input.dart';
import 'package:by_cycle/models/insight_info.dart';
import 'package:flutter/material.dart';

class UserModel {
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
  TimeOfDay bedTime;
  bool would_like_reminders_about_data_log_in;
  bool would_like_reminders_about_self_care_checklist;
  List<DailyDataInput> dailyDataInput;
  List<CustomDateTimeRange> phaseRanges;
  Map<String, dynamic> algorithmData;
  Map<String, List<InsightInfo>> tags;

  UserModel({
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
    this.bedTime = const TimeOfDay(hour: 22, minute: 0),
    this.would_like_reminders_about_data_log_in = false,
    this.would_like_reminders_about_self_care_checklist = false,
    this.dailyDataInput = const [],
    this.phaseRanges = const [],
    this.algorithmData = const {
      "averageSleepTime": {
        "menstruation": {
          "inMinutes": 0,
          "count": 0,
        },
        "follicular": {
          "inMinutes": 0,
          "count": 0,
        },
        "ovulation": {
          "inMinutes": 0,
          "count": 0,
        },
        "luteal": {
          "inMinutes": 0,
          "count": 0,
        },
      }
    },
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
      'bedtime': {'hour': bedTime.hour, 'minute': bedTime.minute},
      'would_like_reminders_about_data_log_in':
          would_like_reminders_about_data_log_in,
      'would_like_reminders_about_self_care_checklist':
          would_like_reminders_about_self_care_checklist,
      'daily_data_input': dailyDataInput.map((input) => input.toMap()).toList(),
      'phase_ranges': phaseRanges.map((input) => input.toMap()).toList(),
      //'algorithm_data': algorithmData,
      'algorithm_data': {
        'lastFiveDays': algorithmData['lastFiveDays']
            ?.map((input) => (input as DailyDataInput).toMap())
            .toList(),
        'averageSleepTime': algorithmData['averageSleepTime']
      },
      'tags': tags.map((key, value) =>
          MapEntry(key, value.map((tag) => tag.toMap()).toList())),
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
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
            [], // Default to follicular phase
      ),
      phaseRanges: List<CustomDateTimeRange>.from(
        map['phase_ranges']
                ?.map((input) => CustomDateTimeRange.fromMap(input)) ??
            [],
      ),
      bedTime: TimeOfDay(
          hour: map['bedtime']['hour'], minute: map['bedtime']['minute']),
      //algorithmData: Map<String, dynamic>.from(map['algorithm_data'] ?? {}),
      algorithmData: {
        'lastFiveDays': List<DailyDataInput>.from(map['algorithm_data']
                ['lastFiveDays']
            .map((input) => DailyDataInput.fromMap(input))),
        'averageSleepTime':
            Map<String, dynamic>.from(map['algorithm_data']['averageSleepTime'])
      },

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

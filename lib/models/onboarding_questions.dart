import 'package:flutter/material.dart';

class OnBoardingQuestions {
  DateTime last_period = DateTime.now();
  int menstruation_phase_length;
  int complete_cycle_length;
  int time_to_fall_asleep;
  bool cycle_regular;
  bool cycle_heavy;
  bool would_like_reminders;
  TimeOfDay? reminders_about_data_log_in;
  TimeOfDay? reminders_about_self_care_checklist;

  OnBoardingQuestions({
    this.menstruation_phase_length = 0,
    this.complete_cycle_length = 0,
    this.time_to_fall_asleep = 20,
    this.cycle_regular = false,
    this.cycle_heavy = false,
    this.would_like_reminders = false,
    this.reminders_about_data_log_in,
    this.reminders_about_self_care_checklist,
  });

  Map<String, dynamic> toMap() {
    return {
      'last_period': last_period,
      'menstruation_phase_length': menstruation_phase_length,
      'complete_cycle_length': complete_cycle_length,
      'time_to_fall_asleep': time_to_fall_asleep,
      'cycle_regular': cycle_regular,
      'cycle_heavy': cycle_heavy,
      'would_like_reminders': would_like_reminders,
      'reminders_about_data_log_in':
          '${reminders_about_data_log_in?.hour}:${reminders_about_data_log_in?.minute}',
      'reminders_about_self_care_checklist':
          '${reminders_about_self_care_checklist?.hour}:${reminders_about_self_care_checklist?.minute}',
    };
  }
}

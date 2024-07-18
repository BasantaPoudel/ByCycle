import 'package:flutter/material.dart';

class OnBoardingQuestions {
  DateTime lastPeriod = DateTime.now();
  int menstruationPhaseLength;
  int completeCycleLength;
  int timeToFallAsleep;
  bool cycleRegular;
  bool cycleHeavy;
  bool wouldLikeReminders;
  TimeOfDay? remindersAboutDataLogIn;
  TimeOfDay? remindersAboutSelfCareChecklist;

  OnBoardingQuestions({
    this.menstruationPhaseLength = 0,
    this.completeCycleLength = 0,
    this.timeToFallAsleep = 20,
    this.cycleRegular = false,
    this.cycleHeavy = false,
    this.wouldLikeReminders = false,
    this.remindersAboutDataLogIn,
    this.remindersAboutSelfCareChecklist,
  });

  Map<String, dynamic> toMap() {
    return {
      'last_period': lastPeriod,
      'menstruation_phase_length': menstruationPhaseLength,
      'complete_cycle_length': completeCycleLength,
      'time_to_fall_asleep': timeToFallAsleep,
      'cycle_regular': cycleRegular,
      'cycle_heavy': cycleHeavy,
      'would_like_reminders': wouldLikeReminders,
      'reminders_about_data_log_in':
          '${remindersAboutDataLogIn?.hour}:${remindersAboutDataLogIn?.minute}',
      'reminders_about_self_care_checklist':
          '${remindersAboutSelfCareChecklist?.hour}:${remindersAboutSelfCareChecklist?.minute}',
    };
  }
}

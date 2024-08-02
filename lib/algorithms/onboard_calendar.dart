import 'package:by_cycle/algorithms/generate_date_time_ranges.dart';
import 'package:by_cycle/examples/users/new_user.dart';
import 'package:by_cycle/models/user_model.dart';
import 'package:by_cycle/models/daily_data_input.dart';
import 'package:logger/logger.dart';

var logger = Logger();

void onboardCalendar(UserModel user) {
  /* A function that can be executed immediately after the user logs in for the first time.
  The function assumes there is no daily_data_inputs yet and that the user instance has all
  onboarding information like the length of the period.

  Parameters:
    - an unonboarded instance of a user

  Returns: 
    - Nothing

  Side-effects:
    - Modifies the user instance so that 100 DailyDataInputs are created beginning 10 days before
      the date of the last period. For instance, if the user's last period was 2024-05-24, there will be
      one DailyDataInput per day from 2024-05-14 until 2024-08-22
  */

  if (user.dailyDataInput.isNotEmpty) {
    logger
        .d("User's dailyDataInput is not empty, aborting to avoid overwrites");
    return;
  }

  logger.d("dailyDataInput is empty");
  logger.d("Last period date: ${user.lastPeriod}");
  logger.d("Complete cycle length: ${user.completeCycleLength}");
  logger.d("Menstruation phase length: ${user.menstruationPhaseLength}");

  user.follicularPhaseLength =
      user.completeCycleLength - user.menstruationPhaseLength - 14;
  user.ovulationPhaseLength = 4;
  user.lutealPhaseLength = 10;

  logger.d("Follicular phase length: ${user.follicularPhaseLength}");
  logger.d("Ovulation phase length: ${user.ovulationPhaseLength}");
  logger.d("Luteal phase length: ${user.lutealPhaseLength}");
  logger.d("Time now: ${DateTime.now()}");

  // Function to determine phase based on day
  String determinePhase(DateTime date) {
    int dayOfCycle =
        date.difference(user.lastPeriod).inDays % user.completeCycleLength;

    if (dayOfCycle < user.menstruationPhaseLength) {
      return "menstruation";
    } else if (dayOfCycle <
        user.menstruationPhaseLength + user.follicularPhaseLength) {
      return "follicular";
    } else if (dayOfCycle <
        user.menstruationPhaseLength +
            user.follicularPhaseLength +
            user.ovulationPhaseLength) {
      return "ovulation";
    } else {
      return "luteal";
    }
  }

  // Create 100 DailyDataInput instances starting 10 days before last period
  for (int i = -10; i < 90; i++) {
    DateTime nextDay = user.lastPeriod.add(Duration(days: i));
    String phase = determinePhase(nextDay);
    user.dailyDataInput.add(DailyDataInput(date: nextDay, phase: phase));
  }

  user.phaseRanges = generateDateTimeRanges(user);

  for (var data in user.dailyDataInput) {
    logger.d(
        'DailyDataInput(date: DateTime(${data.date.year.toString()},${data.date.month.toString()},${data.date.day.toString()}), phase: "${data.phase}"),');
  }

  for (var data in user.phaseRanges) {
    logger.d(
        'CustomDateTimeRange(start: DateTime(${data.start.year.toString()},${data.start.month.toString()},${data.start.day.toString()}), end: DateTime(${data.end.year.toString()},${data.end.month.toString()},${data.end.day.toString()}), phase: "${data.phase}"),');
  }
}

void main() {
  onboardCalendar(new_user);
}

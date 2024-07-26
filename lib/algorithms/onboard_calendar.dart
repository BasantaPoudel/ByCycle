import 'package:by_cycle/algorithms/generate_date_time_ranges.dart';
import 'package:by_cycle/examples/users/new_user.dart';
import 'package:by_cycle/models/user.dart';
import 'package:by_cycle/models/daily_data_input.dart';
import 'package:logger/logger.dart';

var logger = Logger();
onboardCalendar(User user) {
/* a function that can be executed immediately after the user logs in for the first time.
The function assumes there is no daily_data_inputs yet and that the user instance has all
onboarding information like the length of the period.

Parameters:
  - an unonboarded instance of a user

Returns: 
  - Nothing

Side-effects:
  - Modifies the user instance so that 90 dailyDataInputs are created beginning with
  the date of last period. For instance, if the users last period was 2024-05-24, there will be
  one dailyDataInput per day from 2024-05-24 until 2024-08-22
*/
  if (user.dailyDataInput.isNotEmpty) {
    logger
        .d("user's dailyDataInput is not empty, aborting to avoid overwrites");
    return;
  }

  logger.d("dailyDataInput is empty");
  logger.d("last period date: ${user.lastPeriod}");
  logger.d("complete cycle length ${user.completeCycleLength}");
  logger.d("menstruation phase length ${user.menstruationPhaseLength}");
  user.follicularPhaseLength =
      user.completeCycleLength - user.menstruationPhaseLength - 14;
  user.ovulationPhaseLength = 4;
  user.lutealPhaseLength = 10;
  logger.d("follicular phase length ${user.follicularPhaseLength}");
  logger.d("ovulation phase length ${user.ovulationPhaseLength}");
  logger.d("luteal phase length ${user.lutealPhaseLength}");
  logger.d("Time now: ${DateTime.now()}");
  //user.daily_data_input.add(DailyDataInput(date: ))

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

  // Create three DailyDataInput instances for today and next 90 days
  //it would be easy to create the DailyDataInput instances also for the past.
  for (int i = 0; i <= 90; i++) {
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
  //logger.d(user.phaseRanges);
}

void main() {
  onboardCalendar(new_user);
  //logger.d(generateDateTimeRanges(new_user));
}

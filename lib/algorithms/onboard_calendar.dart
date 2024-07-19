import 'package:by_cycle/algorithms/generateDateTimeRanges.dart';
import 'package:by_cycle/examples/users/new_user.dart';
import 'package:by_cycle/models/user.dart';

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
    print("user's dailyDataInput is not empty, aborting to avoid overwrites");
    return;
  }

  print("dailyDataInput is empty");
  print("last period date: ${user.lastPeriod}");
  print("complete cycle length ${user.completeCycleLength}");
  print("menstrual phase length ${user.menstruationPhaseLength}");
  user.follicularPhaseLength =
      user.completeCycleLength - user.menstruationPhaseLength - 14;
  user.ovulationPhaseLength = 4;
  user.lutealPhaseLength = 10;
  print("follicular phase length ${user.follicularPhaseLength}");
  print("ovulation phase length ${user.ovulationPhaseLength}");
  print("luteal phase length ${user.lutealPhaseLength}");
  print("Time now: ${DateTime.now()}");
  //user.daily_data_input.add(DailyDataInput(date: ))

  // Function to determine phase based on day
  String determinePhase(DateTime date) {
    int dayOfCycle =
        date.difference(user.lastPeriod).inDays % user.completeCycleLength;

    if (dayOfCycle < user.menstruationPhaseLength) {
      return "menstrual";
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

  user.dailyDataInput.forEach((data) => print(
      'DailyDataInput(date: DateTime(${data.date.year.toString()},${data.date.month.toString()},${data.date.day.toString()}), phase: "${data.phase}"),'));
  user.phaseRanges.forEach((data) => print(
      'CustomDateTimeRange(start: DateTime(${data.start.year.toString()},${data.start.month.toString()},${data.start.day.toString()}), end: DateTime(${data.end.year.toString()},${data.end.month.toString()},${data.end.day.toString()}), phase: "${data.phase}"),'));
  //print(user.phaseRanges);
}

void main() {
  onboardCalendar(new_user);
  //print(generateDateTimeRanges(new_user));
}

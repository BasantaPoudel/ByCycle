import 'package:by_cycle/examples/users/new_user.dart';
import 'package:by_cycle/examples/users/user_in_menstrual_phase.dart';
import 'package:by_cycle/models/customDateTimeRange.dart';
import 'package:by_cycle/models/user.dart';

onboardCalendar(User user) {
  //check that no overwrite is possible
  if (user.daily_data_input.isEmpty) {
    print("daily_data_input is empty");
    print("last period date: ${user.last_period}");
    print("complete cycle length ${user.complete_cycle_length}");
    print("menstrual phase length ${user.menstuation_phase_length}");
    user.follicular_phase_length =
        user.complete_cycle_length - user.menstuation_phase_length - 14;
    user.ovulatory_phase_length = 4;
    user.luteal_phase_length = 10;
    print("follicular phase length ${user.follicular_phase_length}");
    print("ovulatory phase length ${user.ovulatory_phase_length}");
    print("luteal phase length ${user.luteal_phase_length}");
    print("Time now: ${DateTime.now()}");
    //user.daily_data_input.add(DailyDataInput(date: ))

    // Function to determine phase based on day
    String determinePhase(DateTime date) {
      int dayOfCycle =
          date.difference(user.last_period).inDays % user.complete_cycle_length;

      if (dayOfCycle < user.menstuation_phase_length) {
        return "menstrual";
      } else if (dayOfCycle <
          user.menstuation_phase_length + user.follicular_phase_length) {
        return "follicular";
      } else if (dayOfCycle <
          user.menstuation_phase_length +
              user.follicular_phase_length +
              user.ovulatory_phase_length) {
        return "ovulatory";
      } else {
        return "luteal";
      }
    }

    // Create three DailyDataInput instances for i next days
    for (int i = 1; i <= 31; i++) {
      DateTime nextDay = DateTime.now().add(Duration(days: i));
      String phase = determinePhase(nextDay);
      user.daily_data_input.add(DailyDataInput(date: nextDay, phase: phase));
    }

    user.daily_data_input.forEach((data) => print(data));
  } else {
    print("daily_data_input is not empty");
    print(user.daily_data_input);
  }
}

List<CustomDateTimeRange> generateDateTimeRanges(User user) {
  List<CustomDateTimeRange> dateTimeRanges = [];

  CustomDateTimeRange? currentRange;
  String currentPhase = '';

  for (int i = 0; i < user.daily_data_input.length; i++) {
    DailyDataInput data = user.daily_data_input[i];

    // Check if phase changes
    if (data.phase != currentPhase) {
      // If we were in a phase, finalize the range
      if (currentRange != null) {
        dateTimeRanges.add(currentRange);
      }

      // Start a new range for the new phase
      currentPhase = data.phase;
      currentRange = CustomDateTimeRange(
          start: data.date, end: data.date, phase: currentPhase);
    } else {
      // Continue extending the current range
      currentRange = CustomDateTimeRange(
          start: currentRange!.start, end: data.date, phase: currentPhase);
    }
  }

  // Finalize the last range
  if (currentRange != null) {
    dateTimeRanges.add(currentRange);
  }

  return dateTimeRanges;
}

void main() {
  onboardCalendar(new_user);
  print(generateDateTimeRanges(new_user));
  //print("BREAK");
}

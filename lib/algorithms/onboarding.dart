import 'package:by_cycle/examples/users/new_user.dart';
import 'package:by_cycle/examples/users/user_in_menstrual_phase.dart';
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

int findDailyDataInputIndexByDate(
    List<DailyDataInput> dailyDataInputs, DateTime targetDate) {
  for (int i = 0; i < dailyDataInputs.length; i++) {
    DailyDataInput input = dailyDataInputs[i];
    if (input.date.year == targetDate.year &&
        input.date.month == targetDate.month &&
        input.date.day == targetDate.day) {
      return i;
    }
  }
  return -1; // Return -1 if no matching date is found
}

redrawCalendar(User user, String tag) {
  int indexOfToday =
      findDailyDataInputIndexByDate(user.daily_data_input, DateTime.now());

  int shift = 0;
  if (tag == "follicular_to_ovulatory" &&
      user.daily_data_input[indexOfToday].phase == "follicular")
    shift = user.menstuation_phase_length + user.follicular_phase_length;
  if (tag == "ovulatory_to_luteal" &&
      user.daily_data_input[indexOfToday].phase == "ovulatory")
    shift = user.menstuation_phase_length + user.follicular_phase_length;
  if (tag == "luteal_to_menstrual" &&
      user.daily_data_input[indexOfToday].phase == "luteal") shift = 0;
  if (tag == "menstrual_to_follicular" &&
      user.daily_data_input[indexOfToday].phase == "menstrual") {
    print("menstrual_to_follicular activated");
    shift = user.menstuation_phase_length;
  }

  String determinePhase(DateTime date) {
    int dayOfCycle = date.difference(DateTime.now()).inDays +
        shift % user.complete_cycle_length;

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

  for (int i = 0; i <= 31; i++) {
    DateTime nextDay = DateTime.now().add(Duration(days: i));
    String phase = determinePhase(nextDay);
    int index = findDailyDataInputIndexByDate(user.daily_data_input, nextDay);
    if (index != -1) {
      user.daily_data_input[index].phase = phase;
    } else {
      user.daily_data_input.add(DailyDataInput(date: nextDay, phase: phase));
    }
  }

  user.daily_data_input.forEach((data) => print(data));
}

void main() {
  //onboardCalendar(new_user);
  print("BREAK");
  redrawCalendar(user_in_menstrual_phase, "menstrual_to_follicular");
}

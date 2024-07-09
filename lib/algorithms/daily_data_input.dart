import 'package:by_cycle/examples/users/new_user.dart';
import 'package:by_cycle/models/InsightInfo.dart';
import 'package:by_cycle/models/user.dart';
import 'package:by_cycle/examples/users/pa_lucia.dart';
import 'package:by_cycle/examples/users/pb_ovulation.dart';
import 'package:by_cycle/examples/users/test_user.dart';
import 'package:by_cycle/algorithms/A_to_F/all.dart';
/*
This file contains algorithms necessary for the adjusting the calendar and producing insights.
When used properly, the algorithm should produce 3 insights when a User class is provided to it.
*/

User minimizeUser(User user) {
/*A temporary solution for testing. Returns a user with a maximum of last 5 dailyDataInputs 
in reverse order, so that we don't pass large user instances as arguments and the dailyDataInputs
list can be accesssed intuitively:
user.daily_data_input[0] <- Today
user.daily_data_input[1] <- Yesterday
user.daily_data_input[2] <- 2 days ago etc.
This class might be outdated soon because possibly users will have dailDataInputs going into the 
future to display that information in the calendar...
Also, this function should be pure.

Parameters:
-an instance of User

Returns:
-a minimized instance of user with
a maximum of 5 dailyDataInputs 

*/
  List<DailyDataInput> minimizedDailyDataInput =
      user.daily_data_input.reversed.take(5).toList();
  user.daily_data_input = minimizedDailyDataInput;

  return user;
}

//A handy function for identifying the index of a dailyDataInput on a specific day.
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

List<InsightInfo> choseInsights(User user, List<String> tags) {
  /*A function that returns the InsightInfo instances containing ids
  of insights that should be shown to the user.

  Parameters:
  -a user instance (the tags property contains information on which
  insights were shown and how many times)
  -a list of tags e.g. ["blood", "backpain"...], can be a long list

  Returns:
  -At most 3 InsightInfo instances. Each InsightInfo instance contains an
  insightId that can be used to retrieve the right insight.

  Side-effects:
  -increases the viewCount of those InsightInfos that are shown in the end
  and all of their copies inside other tags.
  */

  //primary list collects InsightInfos that weren't shown before
  List<InsightInfo> primaryList = [];
  //secondary list collects InsightInfos that were shown before
  List<InsightInfo> secondaryList = [];
  for (var tag in tags) {
    if (user.tags.containsKey(tag)) {
      print(user.tags[tag]);
      InsightInfo lowestViewInsight = user.tags[tag]!.reduce((current, next) =>
          current.viewCounter < next.viewCounter ? current : next);

      if (lowestViewInsight.viewCounter == 0) {
        primaryList.add(
            lowestViewInsight); // Add the tag with the lowest viewCounter to out list
      } else {
        secondaryList.add(lowestViewInsight);
      }
    } else {
      print("No matching insight for ${tag} in user.tags or tag is empty");
    }
  }

  //combine the collected InsightInfos into one list
  List<InsightInfo> combinedList = primaryList + secondaryList;

  // Shorten down to at most the first three elements
  combinedList =
      combinedList.length > 3 ? combinedList.sublist(0, 3) : combinedList;

  //increase the viewCount of the InsightInfo appearing under different tags
  for (var insightInfo in combinedList) {
    for (var tag in tags) {
      if (user.tags.containsKey(tag)) {
        for (var insight in user.tags[tag]!) {
          if (insight.insightId == insightInfo.insightId) {
            insight.viewCounter++;
          }
        }
      }
    }
  }

  return combinedList;
}

void main() {
  print("Miau");

  //User minimizedUser = minimizeUser(test_user);
  //print(bodyTemperature(minimizedUser));
  //print(energyLevel(minimizedUser));
  print(choseInsights(new_user, ["blood", "backpain", "headache"]));
}

import 'package:by_cycle/algorithms/generateDateTimeRanges.dart';
import 'package:by_cycle/models/user.dart';

void redrawCalendar(User user, List<String> tags) {
/* a function that adjusts the phases in the user's calendar if there is a 
String tag in the list of tags that matches a phase.

Example: there is a tag: "ovulation_to_luteal" in the tags list, and today according
to the user's calendar is "ovulation", then today's phase is changed to luteal, and all the 
next days are adjusted as if the luteal phase started early.

However, if the tag doesn't match the day, e.g. tag is "ovulation_to_luteal" and
phase is menstruation, nothing will happen as the phases cannot be ommitted.


Parameters:
  -an instance of user
  -A List<String> of tags that may or may not contain some of the folowing:
    "follicular_to_ovulation", "ovulation_to_luteal",
    "luteal_to_menstruation", "menstruation_to_follicular"

  Returns:
    -Nothing

  Side-effects:
    -The user instance is modified directly and the phase property of today
    and following 90 days is adjusted (if there is a matching tag and today is 
    the right day)
    -user's phaseRanges property is updated to reflect the change in the phase
    of today's and 90 future DailyDataInputs (if there is a matching tag and today is 
    the right day)
*/
  List<String> tagsToCheck = [
    "follicular_to_ovulation",
    "ovulation_to_luteal",
    "luteal_to_menstruation",
    "menstruation_to_follicular"
  ];

  // Check if none of the tagsToCheck are in the tags list
  bool noneOfTagsPresent = tagsToCheck.every((tag) => !tags.contains(tag));

  if (noneOfTagsPresent) {
    print(
        "None of the adjusting phase tags are in the list, aborting redrawCalendar.");
    return;
  }

  int indexOfToday = user.algorithmData["indexOfToday"];

  int shift = 0;
  if (tags.contains("follicular_to_ovulation") &&
      user.dailyDataInput[indexOfToday].phase == "follicular") {
    shift = user.menstruationPhaseLength + user.follicularPhaseLength;
  } else if (tags.contains("ovulation_to_luteal") &&
      user.dailyDataInput[indexOfToday].phase == "ovulation") {
    shift = user.menstruationPhaseLength + user.follicularPhaseLength;
  } else if (tags.contains("luteal_to_menstruation") &&
      user.dailyDataInput[indexOfToday].phase == "luteal") {
    shift = 0;
  } else if (tags.contains("menstruation_to_follicular") &&
      user.dailyDataInput[indexOfToday].phase == "menstruation") {
    shift = user.menstruationPhaseLength;
  }

  String determinePhase(DateTime date) {
    int dayOfCycle = date.difference(DateTime.now()).inDays +
        shift % user.completeCycleLength;

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

  //fix phase property of today's and 90 future DailyDataInputs
  for (int i = 0; i <= 90; i++) {
    DateTime nextDay = DateTime.now().add(Duration(days: i));
    String phase = determinePhase(nextDay);
    int index = user.algorithmData["indexOfToday"] + i;
    if (index < user.dailyDataInput.length) {
      user.dailyDataInput[index].phase = phase;
    } else {
      user.dailyDataInput.add(DailyDataInput(date: nextDay, phase: phase));
    }
  }
  user.phaseRanges = generateDateTimeRanges(user);
  user.dailyDataInput.forEach((data) => print(data));
}

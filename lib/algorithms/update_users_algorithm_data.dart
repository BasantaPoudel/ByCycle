import 'package:by_cycle/models/user.dart';
import 'package:by_cycle/models/daily_data_input.dart';
import 'package:logger/logger.dart';

var logger = Logger();
void updateUsersAlgorithmData(User user) {
/*Returns a user with an updated AlgorithmData property. This function should be run before algorithms
A-F returning the tags are run to make sure they execute correctly.
As of now, the function just ensure that algorithmData property has the key-value pair lastFiveDays:
algorithmData["lastFiveDays"] = 5 dailyDataInputs such that:
algorithmData["lastFiveDays"][0] <- Today
algorithmData["lastFiveDays"][1] <- Yesterday
algorithmData["lastFiveDays"][2] <- 2 days ago etc.

Parameters:
  -an instance of User

Returns:
  -Nothing

Side-effects:
  -user's algorithmData["lastFiveDays"] contains last five days
*/
  DateTime today = DateTime.now();

  user.algorithmData["indexOfToday"] =
      findDailyDataInputIndexByDate(user.dailyDataInput, today);

  logger.d(user.algorithmData["indexOfToday"]);

  user.algorithmData["lastFiveDays"] = [];

  for (int i = 0; i < 5; i++) {
    user.algorithmData["lastFiveDays"]
        .add(user.dailyDataInput[user.algorithmData["indexOfToday"] - i]);
  }

  logger.d(user.algorithmData["lastFiveDays"]);
}

// a handy function for identifying the index of a dailyDataInput on a specific day.
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

import 'package:by_cycle/algorithms/produce_tags.dart';
import 'package:by_cycle/algorithms/update_users_algorithm_data.dart';
import 'package:by_cycle/examples/users/user_after_onboardCalendar.dart';

void main() {
  //how the
  var user = user_after_onboardCalendar;
  updateUsersAlgorithmData(user);
  print(user.algorithmData);
  hoursOfSleep(user);
  final indexOfToday =
      findDailyDataInputIndexByDate(user.dailyDataInput, DateTime.now());
  final phase = user.dailyDataInput[indexOfToday].phase;
  late int recommendedSleepTime;
  if (user.algorithmData["averageSleepTime"][phase]["count"] >= 3) {
    recommendedSleepTime =
        user.algorithmData["averageSleepTime"][phase]["inMinutes"];
  } else {
    recommendedSleepTime = phase == "follicular" || phase == "ovulation"
        ? 450 + user.timeToFallAsleep
        : 540 + user.timeToFallAsleep;
  }
  //bedTime should be possible to change and update from the main menu.
  var bedTime = user.bedTime;
}

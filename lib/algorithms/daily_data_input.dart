import 'package:by_cycle/models/user.dart';
import 'package:by_cycle/examples/pa_lucia.dart';
import 'package:by_cycle/examples/pb_ovulation.dart';
/*
This is the daily_data_input algorithm.
It should produce 3 insights when a User class is provided to it.

Parameters: 
- User class, current day??? Entire user class is pretty big,
so perhaps data passed to functions should be User with just
5 last data input instances 

returns: 
- three insights?? three tags?? Mb each A-F function should return a tag,
and this algorithm as a whole should return the specific insights
(bc we don't want the insights the repeat)
- changes phase?

Take into account: in the beginning and in many cases there'll be missing 
dailyDataInputs, you 
*/

User minimizeUser(User user) {
/*Get a user with just a maximum of last 5 dailyDataInputs in reverse order,
so that we don't pass large user instances as arguments and the dailyDataInputs
list can be accesssed intuitively:
user.daily_data_input[0] <- Today
user.daily_data_input[1] <- Yesterday
user.daily_data_input[2] <- 2 days ago etc.

Parameters:
-an instance of User

Returns:
-a minimized instance of user (no side effects) with
a maximum of 5 dailyDataInputs 

*/
  List<DailyDataInput> minimizedDailyDataInput =
      user.daily_data_input.reversed.take(5).toList();
  user.daily_data_input = minimizedDailyDataInput;

  return user;
}

// A) Body temperature
String bodyTemperature(User user) {
  if (user.daily_data_input[0].temperature -
          user.daily_data_input[1].temperature <=
      -0.3) {
    print("temperature fall greater or equal to 0.3");
    if(user.daily_data_input)
  } else {
    print("fall smaller than 0.3");
  }

  if (user.daily_data_input[1].temperature -
          user.daily_data_input[2].temperature <=
      -0.3) {}
  return "None";
}

// B) Mucus

void main() {
  print("Miau");
  bodyTemperature(pa_lucia);

  print(pb_ovulation.daily_data_input.length);
  print(pb_ovulation.daily_data_input[0].date);
  User minimizedUser = minimizeUser(pb_ovulation);
  print(minimizedUser.daily_data_input.length);
  print(minimizedUser.daily_data_input[0].date);

  print(pa_lucia.daily_data_input.length);
  print(pb_ovulation.daily_data_input[0].date);
  User minimizedLucia = minimizeUser(pa_lucia);
  print(minimizedLucia.daily_data_input.length);
  print(minimizedLucia.daily_data_input[0].date);
}

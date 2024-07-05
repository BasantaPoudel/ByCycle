import 'package:by_cycle/models/user.dart';
import 'package:by_cycle/examples/users/pa_lucia.dart';
import 'package:by_cycle/examples/users/pb_ovulation.dart';
import 'package:by_cycle/examples/users/test_user.dart';
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

Take into account:
- in the beginning and in many cases there'll be missing 
dailyDataInputs
- multiple tags can be returned
- sometimes both a tag is activated and the phase needs to be adjusted. 
I want to make the functions return tags; so perhaps adjust cycle should
not stop execution of the algorithm. Also, make a safe way for the cycle not 
to be changed twice in the same day for -
*/

User minimizeUser(User user) {
/*Get a user with a maximum of last 5 dailyDataInputs in reverse order,
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

/*class Actions {
  final List<String> tags;
  final Action = 
}*/

double tempDiff(double temperature1, double temperature2) {
  double difference = (temperature1 * 10 - temperature2 * 10) / 10;
  return difference;
}

// A) Body temperature taken in the morning
List<String> bodyTemperature(User user) {
  final List<String> out = [];

  final t0 = user.daily_data_input[0].temperature;
  final t1 = user.daily_data_input[1].temperature;

  //temperature FALL by 0.3 celsius or more
  if (tempDiff(user.daily_data_input[0].temperature,
          user.daily_data_input[1].temperature) <=
      -0.3) {
    print("temperature fall greater or equal to 0.3");
    if (user.daily_data_input[0].phase == "luteal") {
      print("NOTIFY: Prepare yourself for the upcoming menstruation");
      out.add("NOTIFY: Prepare...");
    }
  }

  //temperature RISE by 0.3 celsius or more for 2 data log ins
  print(user.daily_data_input[0].temperature);
  print(tempDiff(user.daily_data_input[1].temperature,
      user.daily_data_input[2].temperature));
  print(user.daily_data_input[1].temperature);
  print(user.daily_data_input[2].temperature);
  if (tempDiff(user.daily_data_input[0].temperature,
              user.daily_data_input[1].temperature) >=
          0.3 &&
      tempDiff(user.daily_data_input[1].temperature,
              user.daily_data_input[2].temperature) >=
          0.3) {
    print("TAGS: 'temperature', 'identify ovulation'");
    out.add('temperature');
    out.add('identify ovulation');
    if (user.daily_data_input[0].phase == "ovulation") {
      print("ADJUST: Change from ovulation into luteal phase");
      out.add('ovulation_to_luteal');
    }
  }

  return out;
}

// B) Mucus (same  as discharge)
// only one discharge option can be chosen at a time
List<String> mucus(User user) {
  final List<String> out = [];
  final d0 = user.daily_data_input[0].discharge;
  final d1 = user.daily_data_input[1].discharge;
  final d2 = user.daily_data_input[2].discharge;

  if (d0 == "no discharge") {
    return out;
  }

  Set<String> allowedValues = {"egg white", "watery", "stretchy"};

  //data repeated =/> 3 log ins
  if (allowedValues.contains(d0) &&
      allowedValues.contains(d1) &&
      allowedValues.contains(d2)) {
    print("ADJUST cycle, change into Ovulatory phase from follicular phase");
    out.add('follicular_to_ovulatory');

    //data repeated < 3 log ins
    //I'm assuming that we want to display it if it
    //happened the same day, hence just checks last day
  } else if (allowedValues.contains(d0)) {
    out.add("Cervical mucus");
  }
  //should it check that it's not the ovulatory phase???
  if (d0 == "spotting") {
    print("Spotting today!");
    user.algorithm_data.spottingOccurences.add(DateTime.now());
    print("Spotting occurences: ${user.algorithm_data.spottingOccurences}");
    final Duration diff = user.algorithm_data.spottingOccurences[0]
        .difference(user.algorithm_data.spottingOccurences[1]);
    print("Difference in days: ${diff.inDays.abs()}");

    //Data repeated across =/> 2 menstrual cycles
    if (diff.inDays.abs() > user.complete_cycle_length) {
      print("spotting, data repeated =/> 2 menstural cycle");
      print("DISPLAY General insights insight number 3");
      out.add("insight_3");
    } else if (user.daily_data_input[0].phase == "ovulatory") {
      print("Display datab > General insights > insight number: 4");
      out.add("insight_4");
    }
  }
  return out;
}

// C) Energy level
// not clear: tag energy "increase energy" ?in PAGE determined by COLOR?
// very unsure what kind of tags should be produced...
List<String> energyLevel(User user) {
  List<String> out = [];

  //if energy level is high or moderate, do nothing
  if (user.daily_data_input[0].energy_level == "high" ||
      user.daily_data_input[0].energy_level == "moderate") {
    return out;
  } else {
    if (user.daily_data_input[0].hours_of_sleep < 8) {
      print("DISPLAY database > Sleep insights > insight number: 1");
      out.add("insight_1");
    } else {
      switch (user.daily_data_input[0].phase) {
        case "luteal":
          print(
              'DISPLAY database > cycle:luteal > insight tag"increase energy"');
          out.add("increase energy");
          break;
        case "menstrual":
          print(
              'DISPLAY database > cycle:Menstruation > insight tag: "increase energy"');
          out.add("increase energy");
          break;
        case "follicular":
        case "ovulatory":
          print(
              'DISPLAY database > Cycle:Ovulation / Cycle:Follicular > insight tag 1 choice "Increase Energy" "Sleep Quality", "Alcohol" & "Coffee"');
          out.add("Increase Energy");
          out.add("Increase Energy");
      }
    }
  }
  return out;
}

// D) Hours of sleep tonight
List<String> hoursOfSleep(User user) {
  List<String> out = [];

  final h0 = user.daily_data_input[0].hours_of_sleep;
  final h1 = user.daily_data_input[1].hours_of_sleep;
  final h2 = user.daily_data_input[2].hours_of_sleep;

  final e0 = user.daily_data_input[0].energy_level;
  final e1 = user.daily_data_input[1].energy_level;
  final e2 = user.daily_data_input[2].energy_level;

  //if ()
  if (user.daily_data_input[0].hours_of_sleep == 0) {
    print('DISPLAY database > insight tags: "sleep disruption", "insomnia"');
    out.add("sleep disruption");
    out.add("insomnia");
  }
  return out;
}

void main() {
  print("Miau");

  User minimizedUser = minimizeUser(test_user);
  //print(bodyTemperature(minimizedUser));
  print(energyLevel(minimizedUser));
}

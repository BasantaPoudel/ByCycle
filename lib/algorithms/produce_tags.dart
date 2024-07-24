import 'package:by_cycle/models/user.dart';
import 'package:logger/web.dart';

var logger = Logger();
List<String> produceTagsForToday(User user) {
  /*A function that executes each of algorithms A-F to produce a list
  containing all tags relevant for the user today.

  Paremeters:
    - an instance of user (at least after onboardCalendar was run)

  Returns:
    - a List<String> of tags, e.g. "follicular_backpain" or "sleep_funfact"
  */
  List<String> out = [];
  // A) Body temperature taken in the morning
  out += bodyTemperature(user);
  // B) Mucus (same  as discharge)
  out += mucus(user);
  // C) Energy level
  out += energyLevel(user);
  // D) Hours of sleep tonight
  out += hoursOfSleep(user);
  return out;
}

/*
Work in progress. I stopped implementing the algorithms at D to wait for a new 
Figma of the algorithm.
This file contains the dailyDataInput algorithms A-F. Usually they follow the pattern:

Parameters:
-an instance of user

Returns:
-a list of tags (i.e. List<Strings>)
*/

//handy function
double tempDiff(double temperature1, double temperature2) {
  double difference = (temperature1 * 10 - temperature2 * 10) / 10;
  return difference;
}

// A) Body temperature taken in the morning
List<String> bodyTemperature(User user) {
  final List<String> out = [];

  //temperature FALL by 0.3 celsius or more
  if (tempDiff(user.dailyDataInput[0].temperature,
          user.dailyDataInput[1].temperature) <=
      -0.3) {
    logger.d("temperature fall greater or equal to 0.3");
    if (user.dailyDataInput[0].phase == "luteal") {
      logger.d("NOTIFY: Prepare yourself for the upcoming menstruation");
      out.add("NOTIFY: Prepare...");
    }
  }

  //temperature RISE by 0.3 celsius or more for 2 data log ins
  logger.d(user.dailyDataInput[0].temperature);
  logger.d(tempDiff(
      user.dailyDataInput[1].temperature, user.dailyDataInput[2].temperature));
  logger.d(user.dailyDataInput[1].temperature);
  logger.d(user.dailyDataInput[2].temperature);
  if (tempDiff(user.dailyDataInput[0].temperature,
              user.dailyDataInput[1].temperature) >=
          0.3 &&
      tempDiff(user.dailyDataInput[1].temperature,
              user.dailyDataInput[2].temperature) >=
          0.3) {
    logger.d("TAGS: 'temperature', 'identify ovulation'");
    out.add('temperature');
    out.add('identify ovulation');
    if (user.dailyDataInput[0].phase == "ovulation") {
      logger.d("ADJUST: Change from ovulation into luteal phase");
      out.add('ovulation_to_luteal');
    }
  }

  return out;
}

// B) Mucus (same  as discharge)
// only one discharge option can be chosen at a time
List<String> mucus(User user) {
  final List<String> out = [];
  final d0 = user.dailyDataInput[0].discharge;
  final d1 = user.dailyDataInput[1].discharge;
  final d2 = user.dailyDataInput[2].discharge;

  if (d0 == "no discharge") {
    return out;
  }

  Set<String> allowedValues = {"egg white", "watery", "stretchy"};

  //data repeated =/> 3 log ins
  if (allowedValues.contains(d0) &&
      allowedValues.contains(d1) &&
      allowedValues.contains(d2)) {
    logger.d("ADJUST cycle, change into Ovulatory phase from follicular phase");
    out.add('follicular_to_ovulatory');

    //data repeated < 3 log ins
    //I'm assuming that we want to display it if it
    //happened the same day, hence just checks last day
  } else if (allowedValues.contains(d0)) {
    out.add("Cervical mucus");
  }
  //should it check that it's not the ovulatory phase???
  if (d0 == "spotting") {
    logger.d("Spotting today!");
    user.algorithmData['spottingOccurences'].add(DateTime.now());
    logger
        .d("Spotting occurences: ${user.algorithmData['spottingOccurences']}");
    final Duration diff = user.algorithmData['spottingOccurences'][0]
        .difference(user.algorithmData['spottingOccurences'][1]);
    logger.d("Difference in days: ${diff.inDays.abs()}");

    //Data repeated across =/> 2 menstruation cycles
    if (diff.inDays.abs() > user.completeCycleLength) {
      logger.d("spotting, data repeated =/> 2 menstural cycle");
      logger.d("DISPLAY General insights insight number 3");
      out.add("insight_3");
    } else if (user.dailyDataInput[0].phase == "ovulatory") {
      logger.d("Display datab > General insights > insight number: 4");
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
  if (user.dailyDataInput[0].energyLevel == "high" ||
      user.dailyDataInput[0].energyLevel == "moderate") {
    return out;
  } else {
    if (user.dailyDataInput[0].hoursOfSleep < 8) {
      logger.d("DISPLAY database > Sleep insights > insight number: 1");
      out.add("insight_1");
    } else {
      switch (user.dailyDataInput[0].phase) {
        case "luteal":
          logger.d(
              'DISPLAY database > cycle:luteal > insight tag"increase energy"');
          out.add("increase energy");
          break;
        case "menstruation":
          logger.d(
              'DISPLAY database > cycle:Menstruation > insight tag: "increase energy"');
          out.add("increase energy");
          break;
        case "follicular":
        case "ovulatory":
          logger.d(
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
  //if ()
  if (user.dailyDataInput[0].hoursOfSleep == 0) {
    logger.d('DISPLAY database > insight tags: "sleep disruption", "insomnia"');
    out.add("sleep disruption");
    out.add("insomnia");
  }
  return out;
}

import 'package:android_intent_plus/android_intent.dart';
import 'package:android_intent_plus/flag.dart';
import 'package:by_cycle/models/custom_date_time_range.dart';
import 'package:by_cycle/models/user_model.dart';
import 'package:by_cycle/repository/user_repository.dart';
import 'package:by_cycle/screens/daily_data_input_screen.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:url_launcher/url_launcher.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final int _selectedIndex = 0;
  late TimeOfDay bedTime;
  late TimeOfDay wakeupTime;
  late String timeDifference;
  late int recommendedSleepTime;
  late int recommendedSleepCycles;
  late String phaseOfTheDay;
  late double phaseProgressPercentage;
  late var phaseColor;
  UserRepository userRepo = UserRepository();
  var logger = Logger();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {
      bedTime = TimeOfDay.now();
      wakeupTime = TimeOfDay.now();
    });
    // calculatePhaseOfTheDay();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: calculatePhaseOfTheDay(),
        builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
          if (snapshot.hasData) {
            return Center(
                child: CustomScrollView(
                    physics: NeverScrollableScrollPhysics(),
                    slivers: [
                  SliverFillRemaining(
                    hasScrollBody: false,
                    fillOverscroll: true,
                    child: Column(children: [
                      Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(
                              width: 250,
                              // height: 44,
                              child: ElevatedButton(
                                  style: ButtonStyle(
                                      backgroundColor: Theme.of(context)
                                                  .brightness ==
                                              Brightness.light
                                          ? MaterialStateProperty.all<Color>(
                                              const Color(0xFF31312F))
                                          : MaterialStateProperty.all<Color>(
                                              const Color(0xFFD6A879)),
                                      shape: MaterialStateProperty.all<
                                          RoundedRectangleBorder>(
                                        RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(22.0),
                                        ),
                                      )),
                                  onPressed: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                const DailyDataInputScreen()));
                                  },
                                  child: Text(
                                    "Log in your daily data",
                                  )),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            ElevatedButton(
                                style: ButtonStyle(
                                    backgroundColor:
                                        Theme.of(context).brightness ==
                                                Brightness.light
                                            ? MaterialStateProperty.all<Color>(
                                                const Color(0xFF31312F))
                                            : MaterialStateProperty.all<Color>(
                                                const Color(0xFFD6A879)),
                                    shape: MaterialStateProperty.all<
                                        RoundedRectangleBorder>(
                                      RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(22.0),
                                      ),
                                    )),
                                onPressed: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const DailyDataInputScreen()));
                                },
                                child: Icon(Icons.add_circle_outline,
                                    color: Theme.of(context).brightness ==
                                            Brightness.light
                                        ? Colors.white
                                        : Colors.black87)),
                          ]),
                      const SizedBox(
                        height: 40,
                      ),
                      const Center(
                        child: Text('Recommended sleep time'),
                      ),
                      Center(
                        child:
                            Text('for today - $recommendedSleepCycles cycles'),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      const SizedBox(
                        height: 15.0,
                      ),
                      Stack(alignment: Alignment.center, children: [
                        SizedBox(
                          height: 180,
                          width: 180,
                          child: CircularProgressIndicator(
                              strokeWidth: 15,
                              value: recommendedSleepTime / 1440,
                              backgroundColor:
                                  const Color.fromRGBO(222, 212, 197, 1),
                              valueColor:
                                  AlwaysStoppedAnimation<Color>(phaseColor)),
                        ),
                        Text(
                            '${recommendedSleepTime ~/ 60}h ${recommendedSleepTime % 60}m',
                            style: Theme.of(context).textTheme.displaySmall),
                      ]),
                      const SizedBox(
                        height: 15.0,
                      ),
                      Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Column(
                              children: [
                                SizedBox(
                                  width: 98,
                                  height: 37,
                                  child: ElevatedButton(
                                    style: ButtonStyle(
                                      padding:
                                          MaterialStateProperty.all<EdgeInsets>(
                                              EdgeInsets.zero),
                                      backgroundColor:
                                          MaterialStateProperty.all<Color>(
                                              Colors.transparent),
                                      shadowColor:
                                          MaterialStateProperty.all<Color>(
                                              Colors.transparent),
                                      shape: MaterialStateProperty.all<
                                          RoundedRectangleBorder>(
                                        RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(30.0),
                                          side: BorderSide(
                                            color:
                                                Theme.of(context).brightness ==
                                                        Brightness.light
                                                    ? Colors.black
                                                    : Colors.white,
                                          ),
                                        ),
                                      ),
                                    ),
                                    onPressed: () async {
                                      final TimeOfDay? setBedTime =
                                          await showTimePicker(
                                              context: context,
                                              initialTime: bedTime,
                                              initialEntryMode:
                                                  TimePickerEntryMode.dial);
                                      setState(() {
                                        if (setBedTime != null)
                                          bedTime = setBedTime;
                                      });
                                      calculateWakeUpTime(
                                          bedTime, recommendedSleepTime);
                                    },
                                    child: bedTime.minute > 9
                                        ? Text(
                                            "${bedTime.hour}:${bedTime.minute}",
                                            style: TextStyle(
                                              fontSize: 22,
                                              color: Theme.of(context)
                                                          .brightness ==
                                                      Brightness.light
                                                  ? Colors.black87
                                                  : Colors.white,
                                            ),
                                          )
                                        : Text(
                                            "${bedTime.hour}:0${bedTime.minute}",
                                            style: TextStyle(
                                              fontSize: 22,
                                              color: Theme.of(context)
                                                          .brightness ==
                                                      Brightness.light
                                                  ? Colors.black87
                                                  : Colors.white,
                                            ),
                                          ),
                                  ),
                                ),
                                const Text('Bedtime'),
                              ],
                            ),
                            Column(
                              children: [
                                SizedBox(
                                  width: 98,
                                  child: ElevatedButton(
                                      style: ButtonStyle(
                                        padding: MaterialStateProperty.all<
                                            EdgeInsets>(EdgeInsets.zero),
                                        backgroundColor:
                                            MaterialStateProperty.all<Color>(
                                                Colors.transparent),
                                        shadowColor:
                                            MaterialStateProperty.all<Color>(
                                                Colors.transparent),
                                        shape: MaterialStateProperty.all<
                                            RoundedRectangleBorder>(
                                          RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(30.0),
                                            side: BorderSide(
                                              color: Theme.of(context)
                                                          .brightness ==
                                                      Brightness.light
                                                  ? Colors.black
                                                  : Colors.white,
                                            ),
                                          ),
                                        ),
                                      ),
                                      onPressed: () async {
                                        final TimeOfDay? setWakeupTime =
                                            await showTimePicker(
                                                context: context,
                                                initialTime: wakeupTime,
                                                initialEntryMode:
                                                    TimePickerEntryMode.dial);

                                        // if (wakeupTime != null) {
                                        setState(() {
                                          if (setWakeupTime != null) {
                                            wakeupTime = setWakeupTime;
                                          }
                                        });
                                        calculateBedTime(
                                            wakeupTime, recommendedSleepTime);
                                      },
                                      // },
                                      child: wakeupTime.minute > 9
                                          ? Text(
                                              "${wakeupTime.hour}:${wakeupTime.minute}",
                                              style: TextStyle(
                                                fontSize: 22,
                                                color: Theme.of(context)
                                                            .brightness ==
                                                        Brightness.light
                                                    ? Colors.black87
                                                    : Colors.white,
                                              ),
                                            )
                                          : Text(
                                              "${wakeupTime.hour}:0${wakeupTime.minute}",
                                              style: TextStyle(
                                                fontSize: 22,
                                                color: Theme.of(context)
                                                            .brightness ==
                                                        Brightness.light
                                                    ? Colors.black87
                                                    : Colors.white,
                                              ),
                                            )),
                                ),
                                const Text('WakeUp'),
                              ],
                            ),
                          ]),
                      const SizedBox(
                        height: 15.0,
                      ),
                      SizedBox(
                        width: 110,
                        height: 28,
                        child: Theme.of(context).platform ==
                                TargetPlatform.android
                            ? ElevatedButton(
                                style: ButtonStyle(
                                  padding:
                                      MaterialStateProperty.all<EdgeInsets>(
                                          EdgeInsets.zero),
                                  backgroundColor:
                                      Theme.of(context).brightness ==
                                              Brightness.light
                                          ? MaterialStateProperty.all<Color>(
                                              const Color(0xFF31312F))
                                          : MaterialStateProperty.all<Color>(
                                              const Color(0xFFD6A879)),
                                  shape: MaterialStateProperty.all<
                                      RoundedRectangleBorder>(
                                    RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(30.0),
                                    ),
                                  ),
                                ),
                                onPressed: openAlarmApp,
                                child: Text(
                                    // style: Theme.of(context).textTheme.bodySmall,
                                    style: TextStyle(
                                      fontSize: 10,
                                    ),
                                    'SET ALARM'),
                              )
                            : null,
                      ),
                      const SizedBox(
                        height: 15.0,
                      ),
                      Transform.translate(
                        offset: const Offset(55, 10),
                        child: Row(
                          children: [
                            Text(
                                //TODO- Align Properly
                                style: Theme.of(context).textTheme.bodyLarge,
                                'You are in the $phaseOfTheDay phase'),
                            // TextButton(
                            //     onPressed: null,
                            //     child: Text('$phaseOfTheDay phase',
                            //         style: Theme.of(context).textTheme.bodyLarge)),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Container(
                        margin:
                            const EdgeInsets.only(right: 55, left: 55, top: 10),
                        child: LinearProgressIndicator(
                          minHeight: 10,
                          borderRadius:
                              const BorderRadius.all(Radius.circular(10)),
                          value: phaseProgressPercentage,
                          backgroundColor:
                              const Color.fromRGBO(222, 212, 197, 1),
                          valueColor: AlwaysStoppedAnimation<Color>(phaseColor),
                        ),
                      ),
                      Container(
                        margin:
                            const EdgeInsets.only(right: 55, left: 55, top: 10),
                        child: const Column(children: [
                          Text(
                              'The detailed information about the current phase can be consulted in the info page'),
                          // const SizedBox(height: 30),
                          // Text(
                          //     style: Theme.of(context).textTheme.bodyLarge,
                          //     'Your daily insights'),
                        ]),
                      ),
                    ]),
                  ),
                ]));
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        });
  }

  //TODO - Split methods into smaller methods while implementing BlocBuilder
  Future<String> calculatePhaseOfTheDay() async {
    phaseOfTheDay = await userRepo.getTodaysPhase();
    if (phaseOfTheDay == "follicular") {
      phaseColor = const Color(0xFF8E79BB);
    } else if (phaseOfTheDay == "ovulation") {
      phaseColor = const Color(0xFF85A79D);
    } else if (phaseOfTheDay == "luteal") {
      phaseColor = const Color(0xFFD6A879);
    } else if (phaseOfTheDay == "menstruation") {
      phaseColor = const Color(0xFFD48078);
    }

    //TODO - Remove Hardcoded fetch of user

    // ovulating.user@example.com
    // "pblongercycle@example.com"
    // "pcos_pa@example.com"
    // "lucia_pa@example.com"

    var user = await userRepo
        .getUserByEmailFromFirestore(userRepo.loggedInUser!.email!);

    // var dailyDataInput = user!.dailyDataInput;
    // int index = findDailyDataInputIndexByDate(dailyDataInput, DateTime.now());
    // phaseOfTheDay = dailyDataInput[index].phase;

    //Find the current phase DateTimeRange
    var currentDateTimeRange = findCurrentPhaseDateTimeRange(user);
    phaseProgressPercentage = findProgressPercentage(currentDateTimeRange);
    logger.d('Phase progress percentage: $phaseProgressPercentage');

    if (user!.algorithmData["averageSleepTime"][phaseOfTheDay]["count"] >= 3) {
      recommendedSleepTime =
          user.algorithmData["averageSleepTime"][phaseOfTheDay]["inMinutes"];
    } else {
      recommendedSleepTime =
          phaseOfTheDay == "follicular" || phaseOfTheDay == "ovulation"
              ? (450 + user.timeToFallAsleep)
              : 540 + user.timeToFallAsleep;
    }

    //  recommendedSleepTime ~/ 60 - hours
    recommendedSleepCycles =
        phaseOfTheDay == "follicular" || phaseOfTheDay == "ovulation" ? 5 : 6;

    calculateWakeUpTime(bedTime, recommendedSleepTime);

    return phaseOfTheDay;
  }

  // a handy function for identifying the index of a dailyDataInput on a specific day.
  int findDailyDataInputIndexByDate(
      List<dynamic> dailyDataInputs, DateTime targetDate) {
    for (int i = 0; i < dailyDataInputs.length; i++) {
      dynamic input = dailyDataInputs[i];
      DateTime inputDate = input['date'].toDate();
      if (inputDate.year == targetDate.year &&
          inputDate.month == targetDate.month &&
          inputDate.day == targetDate.day) {
        return i;
      }
    }
    return -1; // Return -1 if no matching date is found
  }

  findCurrentPhaseDateTimeRange(UserModel? user) {
    var currentPhaseDateTimeRange = CustomDateTimeRange(
        start: DateTime.now(), end: DateTime.now(), phase: '');
    if (user?.phaseRanges == null) return currentPhaseDateTimeRange;
    user?.phaseRanges.firstWhere((element) {
      var phaseStart =
          DateTime(element.start.year, element.start.month, element.start.day);
      var phaseEnd =
          DateTime(element.end.year, element.end.month, element.end.day);
      var currentTime = DateTime(
          DateTime.now().year, DateTime.now().month, DateTime.now().day);

      logger.d('Phase start: $phaseStart');
      logger.d('Phase end: $phaseEnd');
      logger.d('Current time: $currentTime');

      if ((currentTime.isAfter(phaseStart) && currentTime.isBefore(phaseEnd)) ||
          currentTime.isAtSameMomentAs(phaseStart) ||
          currentTime.isAtSameMomentAs(phaseEnd)) {
        currentPhaseDateTimeRange = element;
        return true;
      }
      return false;
    });
    return currentPhaseDateTimeRange;
    // return null;
  }

  void detectCurrentPhaseLength() {}

  void calculateWakeUpTime(TimeOfDay time, int recommendedSleepTime) {
    // Calculate the recommended sleep time
    var sleepCycle = 90;

    //TODO: Get period phase from the personś input data
    // var numberOfCycles = 5;
    // var sleepTime = numberOfCycles * sleepCycle;
    var timeInMins = time.hour * 60 + time.minute;
    var wakeUpTimeInMins = timeInMins + recommendedSleepTime;

    if (wakeUpTimeInMins >= 1440) {
      wakeUpTimeInMins = wakeUpTimeInMins - 1440;
    }

    TimeOfDay calculatedWakeUpTime = TimeOfDay(
        hour: (wakeUpTimeInMins ~/ 60), minute: (wakeUpTimeInMins % 60));

    // setState(() {
    //   wakeupTime = calculatedWakeUpTime;
    // });

    wakeupTime = calculatedWakeUpTime;
  }

  void calculateBedTime(TimeOfDay time, int recommendedSleepTime) {
    // var sleepCycle = 90;
    // var numberOfCycles = 5;
    // var sleepTime = numberOfCycles * sleepCycle;

    var timeInMins = time.hour * 60 + time.minute;
    var bedTimeInMins = timeInMins - recommendedSleepTime;

    if (bedTimeInMins < 0) {
      bedTimeInMins = bedTimeInMins + 1440;
    }

    TimeOfDay calculatedBedTime =
        TimeOfDay(hour: (bedTimeInMins ~/ 60), minute: (bedTimeInMins % 60));

    // setState(() {
    //   bedTime = calculatedBedTime;
    // });
    bedTime = calculatedBedTime;
  }

  void openAlarmApp() async {
    if (Theme.of(context).platform == TargetPlatform.android) {
      AndroidIntent intent = const AndroidIntent(
        action: 'android.intent.action.SET_ALARM',
        //TODO - Find what flag serves for
        flags: <int>[Flag.FLAG_ACTIVITY_NEW_TASK],
      );
      await intent.launch();
    } else if (Theme.of(context).platform == TargetPlatform.iOS) {
      final Uri iosClockAppUri = Uri(scheme: 'clock');

      //Test launching external link
      if (await canLaunchUrl(Uri.parse("photos-redirect://"))) {
        await launchUrl(Uri.parse("photos-redirect://"));
      } else {
        throw 'Could not open the Clock app.';
      }
    } else {
      throw 'Platform not supported';
    }
  }

  findProgressPercentage(currentDateTimeRange) {
    var phaseStart = DateTime(currentDateTimeRange.start.year,
        currentDateTimeRange.start.month, currentDateTimeRange.start.day);
    var phaseEnd = DateTime(currentDateTimeRange.end.year,
        currentDateTimeRange.end.month, currentDateTimeRange.end.day);
    var currentTime =
        DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day);

    //Added one day to adjust the difference in days
    var totalLength = phaseEnd.difference(phaseStart).inDays + 1;
    var currentProgress = currentTime.difference(phaseStart).inDays + 1;

    var progressPercentage = currentProgress / totalLength;
    return progressPercentage;
    // return
  }
}

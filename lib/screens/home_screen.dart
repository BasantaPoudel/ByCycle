import 'package:android_intent_plus/android_intent.dart';
import 'package:android_intent_plus/flag.dart';
import 'package:by_cycle/algorithms/onboard_calendar.dart';
import 'package:by_cycle/examples/users/new_ovulating_user.dart';
import 'package:by_cycle/examples/users/new_pa_lucia.dart';
import 'package:by_cycle/examples/users/new_pb_longer_cycle.dart';
import 'package:by_cycle/examples/users/new_pcos_pa.dart';
import 'package:by_cycle/examples/users/new_user.dart';
import 'package:by_cycle/repository/user_repository.dart';
import 'package:by_cycle/screens/daily_data_input_screen.dart';
import 'package:flutter/material.dart';
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

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {
      bedTime = TimeOfDay.now();
      wakeupTime =
          TimeOfDay.now().replacing(hour: bedTime.hour, minute: bedTime.minute);
    });
  }

  final userRepository = UserRepository();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(children: [
        Row(mainAxisAlignment: MainAxisAlignment.center, children: [
          ElevatedButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const DailyDataInputScreen()));
              },
              child: const Text("What is your temperature?")),
          ElevatedButton(
              onPressed: () {
                null;
              },
              child: const Text("+"))
        ]),
        const Center(
          child: Text('Recommended sleep time'),
        ),
        const SizedBox(
          height: 15.0,
        ),
        const SizedBox(
            height: 180.0,
            width: 180.0,
            child: CircularProgressIndicator(
              strokeWidth: 15,
              value: 0.4,
              backgroundColor: Color.fromRGBO(222, 212, 197, 1),
              valueColor: AlwaysStoppedAnimation<Color>(Colors.black),
            )),
        const SizedBox(
          height: 15.0,
        ),
        Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
          Column(
            children: [
              ElevatedButton(
                style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all<Color>(const Color(0xFFDED4C5)),
                  foregroundColor:
                      MaterialStateProperty.all<Color>(Colors.white),
                  padding: MaterialStateProperty.all<EdgeInsets>(
                      const EdgeInsets.all(16)),
                  textStyle: MaterialStateProperty.all<TextStyle>(
                      const TextStyle(fontSize: 20)),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                  ),
                  elevation: MaterialStateProperty.all<double>(5.0),
                ),
                onPressed: () async {
                  final TimeOfDay? setBedTime = await showTimePicker(
                      context: context,
                      initialTime: bedTime,
                      initialEntryMode: TimePickerEntryMode.dial);
                  setState(() {
                    if (setBedTime != null) bedTime = setBedTime;
                  });
                  calculateWakeUpTime(bedTime);
                },
                child: bedTime.minute > 9
                    ? Text("${bedTime.hour}:${bedTime.minute}")
                    : Text("${bedTime.hour}:0${bedTime.minute}"),
              ),
              const Text('Bed time'),
            ],
          ),
          Column(
            children: [
              ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(
                        const Color(0xFFDED4C5)),
                    foregroundColor:
                        MaterialStateProperty.all<Color>(Colors.white),
                    padding: MaterialStateProperty.all<EdgeInsets>(
                        const EdgeInsets.all(16)),
                    textStyle: MaterialStateProperty.all<TextStyle>(
                        const TextStyle(fontSize: 20)),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                    ),
                    elevation: MaterialStateProperty.all<double>(5.0),
                  ),
                  onPressed: () async {
                    final TimeOfDay? setWakeupTime = await showTimePicker(
                        context: context,
                        initialTime: wakeupTime,
                        initialEntryMode: TimePickerEntryMode.dial);

                    // if (wakeupTime != null) {
                    setState(() {
                      if (setWakeupTime != null) wakeupTime = setWakeupTime;
                    });
                    calculateBedTime(wakeupTime);
                  },
                  // },
                  child: wakeupTime.minute > 9
                      ? Text("${wakeupTime.hour}:${wakeupTime.minute}")
                      : Text("${wakeupTime.hour}:0${wakeupTime.minute}")),
              const Text('WakeUp time'),
            ],
          ),
        ]),
        const SizedBox(
          height: 15.0,
        ),
        ElevatedButton(
          style: ButtonStyle(
            backgroundColor:
                MaterialStateProperty.all<Color>(const Color(0xFFDED4C5)),
            foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
            padding: MaterialStateProperty.all<EdgeInsets>(
                const EdgeInsets.only(left: 25, right: 25)),
            textStyle: MaterialStateProperty.all<TextStyle>(
                const TextStyle(fontSize: 20, color: Colors.black)),
            elevation: MaterialStateProperty.all<double>(5.0),
          ),
          onPressed: openAlarmApp,
          child: const Text('Set Alarm'),
        ),
        ElevatedButton(
          onPressed: () {
            print(new_user);
            onboardCalendar(new_user);
            print(new_user);
          },
          child: const Text('onboard new_user aka pa lucia'),
        ),
        ElevatedButton(
          onPressed: () {
            print(new_pb_longer_cycle);
            onboardCalendar(new_pb_longer_cycle);
            print(new_pb_longer_cycle);
            userRepository.addUserToFirestore(new_pb_longer_cycle,
                documentId: "new_pb_longer_cycle");
          },
          child: const Text('onboard new_pb_longer_cycle'),
        ),
        ElevatedButton(
          onPressed: () {
            print(new_pcos_pa);
            onboardCalendar(new_pcos_pa);
            print(new_pcos_pa);
            userRepository.addUserToFirestore(new_pcos_pa,
                documentId: "new_pcos_pa");
          },
          child: const Text('onboard new_pcos_pa'),
        ),
        ElevatedButton(
          onPressed: () {
            print(new_pa_lucia);
            onboardCalendar(new_pa_lucia);
            print(new_pa_lucia);
            userRepository.addUserToFirestore(new_pa_lucia,
                documentId: "new_pa_lucia");
          },
          child: const Text('onboard new_pa_lucia'),
        ),
        ElevatedButton(
          onPressed: () {
            print(new_ovulating_user);
            onboardCalendar(new_ovulating_user);
            print(new_ovulating_user);
            userRepository.addUserToFirestore(new_ovulating_user,
                documentId: "new_ovulating_user");
          },
          child: const Text('onboard new_ovulating_user'),
        ),
      ]),
    );
  }

  void calculateWakeUpTime(TimeOfDay time) {
    // Calculate the recommended sleep time
    var sleepCycle = 90;

    //TODO: Get period phase from the personś input data
    var numberOfCycles = 5;
    var sleepTime = numberOfCycles * sleepCycle;
    var timeInMins = time.hour * 60 + time.minute;
    var wakeUpTimeInMins = timeInMins + sleepTime;

    if (wakeUpTimeInMins >= 1440) {
      wakeUpTimeInMins = wakeUpTimeInMins - 1440;
    }

    TimeOfDay calculatedWakeUpTime = TimeOfDay(
        hour: (wakeUpTimeInMins ~/ 60), minute: (wakeUpTimeInMins % 60));

    setState(() {
      wakeupTime = calculatedWakeUpTime;
    });
  }

  void calculateBedTime(TimeOfDay time) {
    var sleepCycle = 90;
    var numberOfCycles = 5;
    var sleepTime = numberOfCycles * sleepCycle;

    var timeInMins = time.hour * 60 + time.minute;
    var bedTimeInMins = timeInMins - sleepTime;

    if (bedTimeInMins < 0) {
      bedTimeInMins = bedTimeInMins + 1440;
    }

    TimeOfDay calculatedBedTime =
        TimeOfDay(hour: (bedTimeInMins ~/ 60), minute: (bedTimeInMins % 60));

    setState(() {
      bedTime = calculatedBedTime;
    });
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
}

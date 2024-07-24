import 'package:android_intent_plus/android_intent.dart';
import 'package:android_intent_plus/flag.dart';
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
  late String timeDifference;
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

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(children: [
        Row(mainAxisAlignment: MainAxisAlignment.center, children: [
          SizedBox(
            width: 280,
            // height: 44,
            child: ElevatedButton(
                style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(
                        const Color(0xFFD6A879)),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30.0),
                      ),
                    )),
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const DailyDataInputScreen()));
                },
                child: const Text("What is your temperature?")),
          ),
          const SizedBox(
            width: 10,
          ),
          ElevatedButton(
              style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all<Color>(const Color(0xFFD6A879)),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                  )),
              onPressed: () {
                null;
              },
              child: const Icon(Icons.add_circle_rounded)),
        ]),
        const SizedBox(
          height: 40,
        ),
        const Center(
          child: Text('Recommended sleep time'),
        ),
        const Center(
          child: Text('for today ---cycles'),
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
              value: 0.4,
              backgroundColor: const Color.fromRGBO(222, 212, 197, 1),
              valueColor: Theme.of(context).brightness == Brightness.light
                  ? const AlwaysStoppedAnimation<Color>(Colors.black)
                  : const AlwaysStoppedAnimation<Color>(Color(0xFFD6A879)),
            ),
          ),
          Text('7h 30m', style: Theme.of(context).textTheme.displaySmall),
        ]),
        const SizedBox(
          height: 15.0,
        ),
        Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
          Column(
            children: [
              TextButton(
                style: TextButton.styleFrom(
                    foregroundColor:
                        Theme.of(context).brightness == Brightness.light
                            ? Colors.black
                            : Colors.white,
                    textStyle: const TextStyle(
                        fontSize: 22,
                        decoration: TextDecoration.underline,
                        color: Colors.green)),
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
              const Text('Bedtime'),
            ],
          ),
          Column(
            children: [
              TextButton(
                  style: TextButton.styleFrom(
                      foregroundColor:
                          Theme.of(context).brightness == Brightness.light
                              ? Colors.black
                              : Colors.white,
                      textStyle: const TextStyle(
                          fontSize: 22,
                          decoration: TextDecoration.underline,
                          color: Colors.black)),
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
              const Text('WakeUp'),
            ],
          ),
        ]),
        const SizedBox(
          height: 15.0,
        ),
        SizedBox(
          width: 110,
          // height: 40,
          child: Theme.of(context).platform == TargetPlatform.android
              ? ElevatedButton(
                  style: ButtonStyle(
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30.0),
                      ),
                    ),
                  ),
                  onPressed: openAlarmApp,
                  child: Text(
                      style: Theme.of(context).textTheme.bodySmall,
                      'SET ALARM'),
                )
              : null,
        ),
        const SizedBox(
          height: 15.0,
        ),
        Text(
            //TODO- Align Properly
            textAlign: TextAlign.left,
            style: Theme.of(context).textTheme.bodyLarge,
            'You are in the --- phase'),
        Container(
          margin: const EdgeInsets.only(right: 55, left: 55, top: 10),
          child: const LinearProgressIndicator(
            minHeight: 10,
            borderRadius: BorderRadius.all(Radius.circular(10)),
            value: 0.5,
            backgroundColor: Color.fromRGBO(222, 212, 197, 1),
            valueColor: AlwaysStoppedAnimation<Color>(Color(0xFFD6A879)),
          ),
        ),
        Container(
          margin: const EdgeInsets.only(right: 55, left: 55, top: 10),
          child: Column(children: [
            const Text(
                'Phase description - Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.'),
            const SizedBox(height: 30),
            Text(
                style: Theme.of(context).textTheme.bodyLarge,
                'Your daily insights'),
          ]),
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

import 'package:by_cycle/main.dart';
import 'package:by_cycle/models/onboarding_questions.dart';
import 'package:by_cycle/repository/user_repository.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OnboardingPageSix extends StatefulWidget {
  final OnBoardingQuestions formData;

  const OnboardingPageSix({
    super.key,
    required this.formData,
  });

  @override
  _OnboardingScreenHomeState createState() => _OnboardingScreenHomeState();
}

class _OnboardingScreenHomeState extends State<OnboardingPageSix> {
  int currentIndex = 0;
  DateTime selectedDate = DateTime.now();
  static var logInDataController = TextEditingController();
  static var insightsController = TextEditingController();

  @override
  void dispose() {
    logInDataController.dispose();
    insightsController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
            child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text(
          'When do you want to receive reminders?',
          style: TextStyle(fontSize: 20),
        ),
        const SizedBox(height: 10),
        Column(
          // mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
              Text(logInDataController.text),
              ElevatedButton(
                onPressed: () => _selectTime(context),
                child: const Text('Data Log In'),
              ),
            ]),
            Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
              Text(insightsController.text),
              ElevatedButton(
                onPressed: () => _selectTimeReminder(context),
                child: const Text('Insights'),
              ),
            ]),
            TextButton(
              onPressed: () {
                widget.formData.wouldLikeReminders = false;
                widget.formData.remindersAboutDataLogIn = null;
                widget.formData.remindersAboutSelfCareChecklist = null;
              },
              child: const Text('I do not want reminders'),
            )
          ],
        ),
        const SizedBox(height: 20),
        ElevatedButton(
          onPressed: () async {
            UserRepository().saveOnboardingData(widget.formData);

            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const MyHomePage(title: "Bycycle"),
              ),
            );

            final prefs = await SharedPreferences.getInstance();
            await prefs.setBool('onboardingComplete', true);
          },
          child: const Text('Done'),
        ),
      ],
    )));
  }

  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (picked != null) {
      setState(() {
        widget.formData.remindersAboutDataLogIn = picked;
        widget.formData.wouldLikeReminders = true;
        logInDataController.text = picked.format(context);
      });
    }
  }

  Future<void> _selectTimeReminder(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (picked != null) {
      setState(() {
        widget.formData.remindersAboutSelfCareChecklist = picked;
        widget.formData.wouldLikeReminders = true;
        insightsController.text = picked.format(context);
      });
    }
  }
}

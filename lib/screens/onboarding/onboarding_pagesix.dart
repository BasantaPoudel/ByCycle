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
  //TODO - Before commit
  static var logInDataController = TextEditingController();
  static var insightsController = TextEditingController();

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
                ElevatedButton(
                  onPressed: () => _selectTime(context),
                  child: const Text('Data Log In'),
                ),
                ElevatedButton(
                  onPressed: () => _selectTimeReminder(context),
                  child: const Text('Insights'),
                ),
                TextButton(
                  onPressed: () {
                    widget.formData.would_like_reminders = false;
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
                //   // TODO: Implement done button functionality

                //TODO - Fix this function call
                final prefs = await SharedPreferences.getInstance();
                await prefs.setBool('onboardingComplete', true);
              },
              child: const Text('Done'),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (picked != null) {
      setState(() {
        widget.formData.reminders_about_data_log_in = picked;
        widget.formData.would_like_reminders = true;
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
        widget.formData.reminders_about_data_log_in = picked;
        widget.formData.would_like_reminders = true;
      });
    }
  }
}

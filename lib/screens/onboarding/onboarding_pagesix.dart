import 'package:by_cycle/main.dart';
import 'package:by_cycle/models/onboarding_questions.dart';
import 'package:by_cycle/models/user.dart';
import 'package:by_cycle/repository/user_repository.dart';
import 'package:flutter/material.dart';

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
              children: [
                ElevatedButton(
                  onPressed: () => _selectTime(context),
                  child: Text('Data Log In'),
                ),
                ElevatedButton(
                  onPressed: () => _selectTimeReminder(context),
                  child: Text('Insights'),
                ),
                TextButton(
                  onPressed: () {
                    widget.formData.would_like_reminders = false;
                  },
                  child: Text('I do not want reminders'),
                )
              ],
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                UserRepository().saveOnboardingData(widget.formData);

                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => MyHomePage(title: "Bycycle"),
                  ),
                );
                //   // TODO: Implement done button functionality

                //TODO - Fix this function call
              },
              child: Text('Done'),
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

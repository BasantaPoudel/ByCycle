import 'package:by_cycle/main.dart';
import 'package:by_cycle/models/onboarding_questions.dart';
import 'package:by_cycle/repository/user_repository.dart';
import 'package:by_cycle/screens/onboarding/onboarding_pageseven.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
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

  // @override
  // void dispose() {
  //   logInDataController.dispose();
  //   insightsController.dispose();
  //   super.dispose();
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
            child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          'When do you want to receive reminders?',
          style: GoogleFonts.poppins(
            fontSize: 22,
            fontWeight: FontWeight.w500,
          ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 10),
        Column(
          // mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Container(
              width: 282,
              // margin: const EdgeInsets.all(15),
              padding: const EdgeInsets.only(left: 20, right: 20),
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(
                  Radius.circular(20),
                ),
                color: Color(0xFFDED4C5),
              ),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(logInDataController.text == ''
                        ? '08:00 AM'
                        : logInDataController.text),
                    Container(
                      color: Color(0xFFD2C8B8),
                      // color: Colors.red,
                      child: TextButton(
                        onPressed: () => _selectTime(context),
                        child: Text(
                          'Log In Data',
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                      ),
                    ),
                  ]),
            ),
            SizedBox(height: 10),
            Container(
              width: 282,
              // margin: const EdgeInsets.all(15),
              padding: const EdgeInsets.only(left: 20, right: 20),
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(
                  Radius.circular(20),
                ),
                color: Color(0xFFDED4C5),
              ),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(insightsController.text == ''
                        ? '08:00 AM'
                        : insightsController.text),
                    Container(
                      color: Color(0xFFD2C8B8),
                      child: TextButton(
                        onPressed: () => _selectTimeReminder(context),
                        child: Text(
                          'Insights',
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                      ),
                    ),
                  ]),
            ),
            TextButton(
              onPressed: () {
                widget.formData.wouldLikeReminders = false;
                widget.formData.remindersAboutDataLogIn = null;
                widget.formData.remindersAboutSelfCareChecklist = null;

                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => OnboardingPageSeven(
                      formData: widget.formData,
                    ),
                  ),
                );
              },
              child: Text(
                'I don\'t want to receive reminders',
                style: GoogleFonts.poppins(
                  fontSize: 12,
                  // fontWeight: FontWeight.w500,
                  color: const Color(0xFF9B907E),
                ),
              ),
            )
          ],
        ),
        const SizedBox(height: 20),
        SizedBox(
          width: 224,
          child: ElevatedButton(
            style: ButtonStyle(
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                ),
                backgroundColor: insightsController.text == "" &&
                        logInDataController.text == "" &&
                        widget.formData.wouldLikeReminders
                    ? MaterialStateProperty.all<Color>(const Color(0xFFDED4C5))
                    : MaterialStateProperty.all<Color>(
                        const Color.fromRGBO(1, 1, 1, 1))),
            onPressed: () async {
              if (logInDataController.text != "") {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => OnboardingPageSeven(
                      formData: widget.formData,
                    ),
                  ),
                );
              } else {
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                  content: Text("Please input the data to continue"),
                  duration: Duration(seconds: 2),
                ));
              }
            },
            child: const Text('Done!'),
          ),
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

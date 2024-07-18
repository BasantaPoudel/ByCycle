import 'package:by_cycle/models/onboarding_questions.dart';
import 'package:by_cycle/screens/onboarding/onboarding_pagetwo.dart';
import 'package:flutter/material.dart';

class OnboardingPageOne extends StatefulWidget {
  const OnboardingPageOne({super.key});

  // const OnboardingPageOne({
  //   required this.formData,
  // });

  @override
  _OnboardingScreenHomeState createState() => _OnboardingScreenHomeState();
}

class _OnboardingScreenHomeState extends State<OnboardingPageOne> {
  int currentIndex = 0;
  DateTime selectedDate = DateTime.now();
  static var controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final OnBoardingQuestions formData = OnBoardingQuestions();

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'What is the Date of your last period?',
              style: TextStyle(fontSize: 20),
            ),
            const SizedBox(height: 10),
            SizedBox(
              width: 200,
              child: TextField(
                controller: controller,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'YYYY-MM-DD',
                ),
                onTap: () => _selectDate(context),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                formData.lastPeriod = DateTime.parse(controller.text);
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          OnboardingPageTwo(formData: formData),
                    ));
              },
              child: const Text('Next'),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != DateTime.now()) {
      setState(() {
        controller.text = "${picked.toLocal()}".split(' ')[0];
      });
    }
  }
}

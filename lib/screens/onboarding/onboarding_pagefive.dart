import 'package:by_cycle/models/onboarding_questions.dart';
import 'package:by_cycle/screens/onboarding/onboarding_pagesix.dart';
import 'package:flutter/material.dart';

class OnboardingPageFive extends StatefulWidget {
  final OnBoardingQuestions formData;

  const OnboardingPageFive({
    super.key,
    required this.formData,
  });

  @override
  _OnboardingScreenHomeState createState() => _OnboardingScreenHomeState();
}

class _OnboardingScreenHomeState extends State<OnboardingPageFive> {
  int currentIndex = 0;
  DateTime selectedDate = DateTime.now();
  static var controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    // final OnBoardingQuestions formData = OnBoardingQuestions();

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Is your cycle regular?',
              style: TextStyle(fontSize: 20),
            ),
            const SizedBox(height: 10),
            Container(
              width: 200,
              child: Row(
                children: [
                  ElevatedButton(
                      onPressed: () {
                        widget.formData.cycle_regular = true;
                      },
                      child: Text('Yes')),
                  ElevatedButton(
                      onPressed: () {
                        widget.formData.cycle_regular = true;
                      },
                      child: Text('No'))
                ],
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        OnboardingPageSix(formData: widget.formData),
                  ),
                );
                //   // TODO: Implement done button functionality
              },
              child: Text('Next'),
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

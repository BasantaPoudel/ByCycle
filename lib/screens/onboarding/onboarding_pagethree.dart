import 'package:by_cycle/models/onboarding_questions.dart';
import 'package:by_cycle/screens/onboarding/onboarding_pagefour.dart';
import 'package:flutter/material.dart';

class OnboardingPageThree extends StatefulWidget {
  OnBoardingQuestions formData;

  OnboardingPageThree({
    required this.formData,
  });

  @override
  _OnboardingScreenHomeState createState() => _OnboardingScreenHomeState();
}

class _OnboardingScreenHomeState extends State<OnboardingPageThree> {
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
              'How long is your complete period cycle?',
              style: TextStyle(fontSize: 20),
            ),
            const SizedBox(height: 10),
            Container(
              width: 200,
              child: TextField(
                controller: controller,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: '# Days',
                ),
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                widget.formData.complete_cycle_length =
                    int.parse(controller.text);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        OnboardingPageFour(formData: widget.formData),
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

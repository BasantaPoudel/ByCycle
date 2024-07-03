import 'package:by_cycle/models/onboarding_questions.dart';
import 'package:by_cycle/screens/onboarding/onboarding_pagethree.dart';
import 'package:flutter/material.dart';

class OnboardingPageTwo extends StatefulWidget {
  final OnBoardingQuestions formData;

  const OnboardingPageTwo({
    super.key,
    required this.formData,
  });

  @override
  _OnboardingScreenHomeState createState() => _OnboardingScreenHomeState();
}

class _OnboardingScreenHomeState extends State<OnboardingPageTwo> {
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
              'How long does your period last?',
              style: TextStyle(fontSize: 20),
            ),
            const SizedBox(height: 10),
            Container(
              width: 200,
              child: TextField(
                controller: controller,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: '# Days',
                ),
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                widget.formData.menstruation_phase_length =
                    int.parse(controller.text);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        OnboardingPageThree(formData: widget.formData),
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
}

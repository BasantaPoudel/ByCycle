import 'package:by_cycle/models/onboarding_questions.dart';
import 'package:by_cycle/screens/onboarding/onboarding_pagefive.dart';
import 'package:flutter/material.dart';

class OnboardingPageFour extends StatefulWidget {
  OnBoardingQuestions formData;

  OnboardingPageFour({
    required this.formData,
  });

  @override
  _OnboardingScreenHomeState createState() => _OnboardingScreenHomeState();
}

class _OnboardingScreenHomeState extends State<OnboardingPageFour> {
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
              'How long does it take you to fall asleep?',
              style: TextStyle(fontSize: 20),
            ),
            const SizedBox(height: 10),
            Container(
              width: 200,
              child: TextField(
                controller: controller,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: '# Mins',
                ),
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                widget.formData.time_to_fall_asleep =
                    int.parse(controller.text);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        OnboardingPageFive(formData: widget.formData),
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

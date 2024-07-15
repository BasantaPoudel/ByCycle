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
            SizedBox(
              width: 200,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                      onPressed: () {
                        widget.formData.cycleRegular = true;
                      },
                      child: const Text('Yes')),
                  ElevatedButton(
                      onPressed: () {
                        widget.formData.cycleRegular = true;

                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text(
                                'Since your cycle is not regular, we recommend you not to rely only on predictions. It’s very important to input your temperature and cervical mucus everyday!'),
                            duration: Duration(seconds: 5),
                          ),
                        );
                      },
                      child: const Text('No'))
                ],
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        OnboardingPageSix(formData: widget.formData),
                  ),
                );
              },
              child: const Text('Next'),
            ),
          ],
        ),
      ),
    );
  }
}

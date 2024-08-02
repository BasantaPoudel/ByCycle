import 'package:by_cycle/models/onboarding_questions.dart';
import 'package:by_cycle/screens/onboarding/onboarding_pagesix.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class OnboardingPageFivePlus extends StatefulWidget {
  final OnBoardingQuestions formData;

  const OnboardingPageFivePlus({
    super.key,
    required this.formData,
  });

  @override
  _OnboardingScreenHomeState createState() => _OnboardingScreenHomeState();
}

class _OnboardingScreenHomeState extends State<OnboardingPageFivePlus> {
  int currentIndex = 0;
  DateTime selectedDate = DateTime.now();
  bool alertButtonVisibility = false;
  @override
  Widget build(BuildContext context) {
    // final OnBoardingQuestions formData = OnBoardingQuestions();

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Is your period flow heavy?',
              style: TextStyle(fontSize: 20),
            ),
            const SizedBox(height: 10),
            SizedBox(
                // width: 200,
                child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  // height: 44,
                  width: 108,
                  child: ElevatedButton(
                      style: ButtonStyle(
                          padding: MaterialStateProperty.all<EdgeInsets>(
                              EdgeInsets.zero),
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30.0),
                            ),
                          ),
                          backgroundColor: MaterialStateProperty.all<Color>(
                              const Color.fromRGBO(1, 1, 1, 1))),
                      onPressed: () {
                        widget.formData.cycleHeavy = true;
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => OnboardingPageSix(
                              formData: widget.formData,
                            ),
                          ),
                        );
                      },
                      child: const Text('Yes')),
                ),
                const SizedBox(
                  width: 24,
                ),
                SizedBox(
                  // height: 44,
                  width: 108,
                  child: ElevatedButton(
                      style: ButtonStyle(
                          padding: MaterialStateProperty.all<EdgeInsets>(
                              EdgeInsets.zero),
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30.0),
                            ),
                          ),
                          backgroundColor: MaterialStateProperty.all<Color>(
                              const Color.fromRGBO(1, 1, 1, 1))),
                      onPressed: () {
                        widget.formData.cycleHeavy = false;
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => OnboardingPageSix(
                              formData: widget.formData,
                            ),
                          ),
                        );
                      },
                      child: const Text('No')),
                ),
              ],
            )),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}

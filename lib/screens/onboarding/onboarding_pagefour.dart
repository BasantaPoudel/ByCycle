import 'package:by_cycle/models/onboarding_questions.dart';
import 'package:by_cycle/screens/onboarding/onboarding_pagefive.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class OnboardingPageFour extends StatefulWidget {
  final OnBoardingQuestions formData;

  const OnboardingPageFour({
    super.key,
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
            Text(
              'How long does it take you to fall asleep?',
              style: GoogleFonts.poppins(
                fontSize: 22,
                fontWeight: FontWeight.w500,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 10),
            SizedBox(
              width: 200,
              child: TextField(
                controller: controller,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  filled: true,
                  fillColor: Color(0xFFDED4C5),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(30.0)),
                    // borderSide: BorderSide.none,
                  ),
                  hintText: '30 Minutes',
                ),
                onChanged: (value) {
                  setState(() {
                    controller.text = value;
                  });
                },
              ),
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
                    backgroundColor: controller.text == ""
                        ? MaterialStateProperty.all<Color>(
                            const Color(0xFFDED4C5))
                        : MaterialStateProperty.all<Color>(
                            const Color.fromRGBO(1, 1, 1, 1))),
                onPressed: () {
                  if (controller.text != "") {
                    widget.formData.timeToFallAsleep =
                        int.parse(controller.text);
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            OnboardingPageFive(formData: widget.formData),
                      ),
                    );
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      content: Text("Please input the data to continue"),
                      duration: Duration(seconds: 2),
                    ));
                  }
                },
                child: const Text('Next'),
              ),
            ),
            const SizedBox(
              height: 28,
            ),
            TextButton(
              style: TextButton.styleFrom(
                  foregroundColor:
                      Theme.of(context).brightness == Brightness.light
                          ? Colors.black
                          : Colors.white,
                  textStyle: const TextStyle(
                      fontSize: 22,
                      decoration: TextDecoration.underline,
                      color: Colors.green)),
              onPressed: () {
                widget.formData.timeToFallAsleep = int.parse(controller.text);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        OnboardingPageFive(formData: widget.formData),
                  ),
                );
              },
              child: Text(
                'I don\'t know',
                style: GoogleFonts.poppins(
                  fontSize: 12,
                  // fontWeight: FontWeight.w500,
                  color: const Color(0xFF9B907E),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

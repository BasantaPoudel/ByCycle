import 'package:by_cycle/models/onboarding_questions.dart';
import 'package:by_cycle/screens/onboarding/onboarding_pagefiveplus.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

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
              'Is your cycle regular?',
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
                          padding: WidgetStateProperty.all<EdgeInsets>(
                              EdgeInsets.zero),
                          shape:
                              WidgetStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30.0),
                            ),
                          ),
                          backgroundColor: WidgetStateProperty.all<Color>(
                              const Color.fromRGBO(1, 1, 1, 1))),
                      onPressed: () {
                        widget.formData.cycleRegular = true;
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => OnboardingPageFivePlus(
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
                          padding: WidgetStateProperty.all<EdgeInsets>(
                              EdgeInsets.zero),
                          shape:
                              WidgetStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30.0),
                            ),
                          ),
                          backgroundColor: WidgetStateProperty.all<Color>(
                              const Color.fromRGBO(1, 1, 1, 1))),
                      onPressed: () {
                        // ScaffoldMessenger.of(context).showSnackBar(
                        //   const SnackBar(
                        //     content: Text(
                        //         'Since your cycle is not regular, we recommend you not to rely only on predictions. It’s very important to input your temperature and cervical mucus everyday!'),
                        //     duration: Duration(seconds: 5),
                        //   ),
                        // );
                        setState(() {
                          alertButtonVisibility = true;
                        });
                      },
                      child: const Text('No')),
                ),
              ],
            )),
            const SizedBox(height: 20),
            Visibility(
              visible: alertButtonVisibility,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    margin: const EdgeInsets.only(left: 80, right: 80),
                    child: Text(
                      'Since your cycle is not regular, we recommend you not to rely only on predictions. It’s very important to input your temperature and cervical mucus everyday!',
                      style: GoogleFonts.poppins(
                        fontSize: 16,
                        // fontWeight: FontWeight.w500,
                        color: Colors.black,
                      ),
                      textAlign: TextAlign.justify,
                    ),
                  ),
                  const SizedBox(height: 20),
                  SizedBox(
                    // height: 44,
                    width: 224,
                    child: TextButton(
                        onPressed: () {
                          widget.formData.cycleRegular = false;
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => OnboardingPageFivePlus(
                                formData: widget.formData,
                              ),
                            ),
                          );
                        },
                        child: Text(
                          'Ok, got it!',
                          style: GoogleFonts.poppins(
                            fontSize: 12,
                            // fontWeight: FontWeight.w500,
                            color: const Color(0xFF9B907E),
                          ),
                        )),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

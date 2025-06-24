import 'package:by_cycle/models/onboarding_questions.dart';
import 'package:by_cycle/screens/onboarding/onboarding_pagethree.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

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
        child: Container(
          width: 280,
          margin: const EdgeInsets.all(40),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'How long does your period last?',
                style: GoogleFonts.poppins(
                  fontSize: 22,
                  fontWeight: FontWeight.w500,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 10),
              SizedBox(
                width: 282,
                height: 46,
                child: TextField(
                  controller: controller,
                  decoration: const InputDecoration(
                    contentPadding: EdgeInsets.only(left: 15, right: 20),
                    filled: true,
                    fillColor: Color(0xFFDED4C5),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(30.0)),
                      // borderSide: BorderSide.none,
                    ),
                    hintText: '5 Days',
                  ),
                  keyboardType: TextInputType.number,
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
                height: 44,
                child: ElevatedButton(
                  style: ButtonStyle(
                      padding:
                          WidgetStateProperty.all<EdgeInsets>(EdgeInsets.zero),
                      shape: WidgetStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30.0),
                        ),
                      ),
                      backgroundColor: controller.text == ""
                          ? WidgetStateProperty.all<Color>(
                              const Color(0xFFDED4C5))
                          : WidgetStateProperty.all<Color>(
                              const Color.fromRGBO(1, 1, 1, 1))),
                  onPressed: () {
                    if (controller.text != "") {
                      widget.formData.menstruationPhaseLength =
                          int.parse(controller.text);
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              OnboardingPageThree(formData: widget.formData),
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
            ],
          ),
        ),
      ),
    );
  }
}

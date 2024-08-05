import 'package:by_cycle/main.dart';
import 'package:by_cycle/models/onboarding_questions.dart';
import 'package:by_cycle/repository/user_repository.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OnboardingPageSeven extends StatefulWidget {
  final OnBoardingQuestions formData;

  const OnboardingPageSeven({
    super.key,
    required this.formData,
  });

  @override
  _OnboardingScreenHomeState createState() => _OnboardingScreenHomeState();
}

class _OnboardingScreenHomeState extends State<OnboardingPageSeven> {
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
            Text(
              'You are ready!',
              style: GoogleFonts.poppins(
                fontSize: 38,
                fontWeight: FontWeight.w500,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 10),
            SizedBox(
              // width: 200,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    // height: 44,
                    width: 224,
                    child: ElevatedButton(
                        style: ButtonStyle(
                            padding: WidgetStateProperty.all<EdgeInsets>(
                                EdgeInsets.zero),
                            shape: WidgetStateProperty.all<
                                RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30.0),
                              ),
                            ),
                            backgroundColor: WidgetStateProperty.all<Color>(
                                const Color.fromRGBO(1, 1, 1, 1))),
                        onPressed: () async {
                          UserRepository().saveOnboardingData(widget.formData);

                          Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(builder: (context) {
                              return const MyApp();
                            }),
                            (route) => false,
                          );

                          final prefs = await SharedPreferences.getInstance();
                          await prefs.setBool('onboardingComplete', true);
                        },
                        child: Text(
                          'Let\'s Go!',
                          style: GoogleFonts.poppins(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                          ),
                          textAlign: TextAlign.center,
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

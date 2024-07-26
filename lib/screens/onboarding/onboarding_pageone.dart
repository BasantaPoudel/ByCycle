import 'package:by_cycle/cubits/theme/theme_cubit.dart';
import 'package:by_cycle/models/onboarding_questions.dart';
import 'package:by_cycle/screens/onboarding/onboarding_pagetwo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

class OnboardingPageOne extends StatefulWidget {
  const OnboardingPageOne({super.key});

  // const OnboardingPageOne({
  //   required this.formData,
  // });

  @override
  _OnboardingScreenHomeState createState() => _OnboardingScreenHomeState();
}

class _OnboardingScreenHomeState extends State<OnboardingPageOne> {
  int currentIndex = 0;
  DateTime selectedDate = DateTime.now();
  static var controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var themeCubit = BlocProvider.of<ThemeCubit>(context);
    final OnBoardingQuestions formData = OnBoardingQuestions();
    return BlocBuilder(
        bloc: themeCubit,
        builder: (context, state) {
          return Scaffold(
            body: Center(
              child: Container(
                width: 280,
                margin: const EdgeInsets.all(40),
                decoration: const BoxDecoration(
                    // color: Colors.red,
                    ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'What is the date of your last period?',
                      style: GoogleFonts.poppins(
                        fontSize: 22,
                        fontWeight: FontWeight.w500,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 10),
                    SizedBox(
                      width: 282,
                      // height: 46,
                      child: TextField(
                        controller: controller,
                        decoration: const InputDecoration(
                          filled: true,
                          fillColor: Color(0xFFDED4C5),
                          border: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(30.0)),
                            // borderSide: BorderSide.none,
                          ),
                          hintText: 'YYYY-MM-DD',
                        ),
                        onTap: () => _selectDate(context),
                      ),
                    ),
                    const SizedBox(height: 20),
                    SizedBox(
                      width: 224,
                      child: ElevatedButton(
                          style: ButtonStyle(
                              shape: MaterialStateProperty.all<
                                  RoundedRectangleBorder>(
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
                              formData.lastPeriod =
                                  DateTime.parse(controller.text);
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        OnboardingPageTwo(formData: formData),
                                  ));
                            } else {
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(const SnackBar(
                                content:
                                    Text("Please input the data to continue"),
                                duration: Duration(seconds: 2),
                              ));
                            }
                          },
                          child: const Text('Next')),
                    ),
                  ],
                ),
              ),
            ),
          );
        });
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

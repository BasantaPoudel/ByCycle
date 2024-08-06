import 'package:by_cycle/repository/user_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class FeedbackWidget extends StatefulWidget {
  const FeedbackWidget({super.key});

  @override
  _FeedbackWidgetState createState() => _FeedbackWidgetState();
}

class _FeedbackWidgetState extends State<FeedbackWidget> {
  final TextEditingController _feedbackController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  UserRepository userRepo = UserRepository();
  int currentLength = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          iconTheme: Theme.of(context).brightness == Brightness.light
              ? const IconThemeData(color: Colors.black)
              : const IconThemeData(color: Colors.white),
          // title: Text("FEEDBACK FORM"),
        ),
        body: Padding(
          padding: const EdgeInsets.all(40.0),
          child: SingleChildScrollView(
            child: Center(
              child: Column(
                children: [
                  const SizedBox(
                    height: 20,
                  ),
                  Theme.of(context).brightness == Brightness.light
                      ? SvgPicture.asset(
                          'assets/icons/drawer_icon.svg',
                          height: 100,
                        )
                      : SvgPicture.asset('assets/icons/drawer_dark.svg',
                          height: 100),
                  const SizedBox(
                    height: 20,
                  ),
                  const Text("FEEDBACK FORM"),
                  const SizedBox(
                    height: 40,
                  ),
                  Container(
                    width: 300, // Set the desired width
                    height: 250, // Set the desired height
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(
                          15.0), // Set the desired border radius
                      border: Border.all(
                        color: Colors.grey, // Set the desired border color
                      ),
                    ),
                    child: TextField(
                      controller: _feedbackController,
                      maxLines: null, // Allow multiple lines
                      // min: maxLength, // Set the maximum length for the text
                      decoration: const InputDecoration(
                        labelText: 'Feedback',
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.all(16.0),
                      ),
                      onChanged: (value) => setState(() {
                        // Update the current length
                        currentLength = _feedbackController.text.length;
                      }),
                    ),
                  ),

                  //TODO: Display the updated current count
                  Container(
                    alignment: Alignment.centerRight,
                    padding: EdgeInsets.only(right: 20),
                    height: 30,
                    child: Text(
                      '${currentLength}', // Display the current count
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey,
                      ),
                      textAlign: TextAlign.right,
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Column(
                    children: [
                      Container(
                        width: 300, // Set the desired width
                        height: 60, // Set the desired height
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(
                              15.0), // Set the desired border radius
                          border: Border.all(
                            color: Colors.grey, // Set the desired border color
                          ),
                        ),
                        child: TextField(
                          controller: _emailController,
                          maxLines: null, // Allow multiple lines
                          decoration: const InputDecoration(
                            labelText: 'Email',
                            border: InputBorder
                                .none, // Remove the default TextField border
                            contentPadding: EdgeInsets.all(
                                10.0), // Adjust padding as needed
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 50,
                      ),
                      SizedBox(
                        width: 108,
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
                          onPressed: () {
                            if (_feedbackController.text == "" ||
                                _feedbackController.text.length <= 60) {
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(const SnackBar(
                                content: Text(
                                    "Feedback must be at least 60 characters long"),
                                duration: Duration(seconds: 2),
                              ));
                            } else if (_emailController.text == "") {
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(const SnackBar(
                                content: Text("Please input your email"),
                                duration: Duration(seconds: 2),
                              ));
                            } else {
                              // Add your submit button logic here
                              userRepo.saveFeedback(_feedbackController.text,
                                  _emailController.text);
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(const SnackBar(
                                content: Text("Thank you for your feedback"),
                                duration: Duration(seconds: 2),
                              ));
                              Navigator.pop(context);
                            }
                          },
                          child: const Text('Submit'),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}

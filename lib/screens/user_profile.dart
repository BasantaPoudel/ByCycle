import 'package:by_cycle/main.dart';
import 'package:by_cycle/models/user_model.dart';
import 'package:by_cycle/repository/user_repository.dart';
import 'package:by_cycle/screens/feedback.dart';
import 'package:by_cycle/screens/onboarding/onboarding_pageone.dart';
import 'package:firebase_ui_auth/firebase_ui_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  UserRepository userRepo = UserRepository();

  @override
  Widget build(BuildContext context) {
    return ProfileScreen(
      appBar: AppBar(
        title: const Text('Your Profile'),
      ),
      actions: [
        SignedOutAction((context) {
          RestartWidget.restartApp(context);
          Navigator.of(context).pop();
        }),
        DisplayNameChangedAction((context, oldName, newName) async {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              backgroundColor: Colors.green,
              content: Text(
                  'Display name changed to $newName, Please Sign Out and Sign In again once you verify your email!'),
              duration: const Duration(seconds: 5),
            ),
          );

          await userRepo.updateNewUserToFirestore(UserModel(
              name: newName,
              email: userRepo.loggedInUser!.email!,
              lastPeriod: DateTime.now()));

          //TODO - Look for alternatives as well
        })
      ],
      children: [
        const Divider(),
        //TODO - Unhide Edit Onboarding Answers when we have edit functionality planned
        // TextButton(
        //     onPressed: () {
        //       Navigator.push(
        //           context,
        //           MaterialPageRoute(
        //               builder: (context) =>
        //                   const OnboardingPageOne()));
        //     },
        //     child:
        //         const Text("Edit Onboarding Answers")),
        // const Divider(),
        TextButton(
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => FeedbackWidget()));
            },
            child: const Text("Provide Feedback")),
        const Divider(),
        Padding(
          padding: const EdgeInsets.all(2),
          child: AspectRatio(
            aspectRatio: 3,
            child: SvgPicture.asset(
              'assets/icons/drawer_icon.svg',
            ),
          ),
        ),
      ],
    );
  }
}

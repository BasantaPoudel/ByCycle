import 'package:by_cycle/main.dart';
import 'package:by_cycle/models/user_model.dart';
import 'package:by_cycle/repository/user_repository.dart';
import 'package:by_cycle/screens/feedback.dart';
import 'package:by_cycle/screens/settings.dart';
import 'package:by_cycle/screens/user_profile.dart';
import 'package:firebase_auth/firebase_auth.dart' hide EmailAuthProvider;
import 'package:firebase_ui_auth/firebase_ui_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

class AuthGate extends StatelessWidget {
  AuthGate({super.key});
  final UserRepository userRepo = UserRepository();

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return SignInScreen(
            showPasswordVisibilityToggle: true,
            providers: [
              EmailAuthProvider(),
            ],
            actions: [
              AuthStateChangeAction<UserCreated>((context, state) async {
                Navigator.of(context).pushReplacement(MaterialPageRoute(
                  builder: (context) => ProfileScreen(
                    appBar: AppBar(
                        iconTheme:
                            Theme.of(context).brightness == Brightness.light
                                ? const IconThemeData(color: Colors.black)
                                : const IconThemeData(color: Colors.white),
                        title: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            // crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text('Your Profile'),
                              // Text(userRepo.loggedInUser!.email!),
                            ])),
                    actions: [
                      SignedOutAction((context) {
                        RestartWidget.restartApp(context);
                        Navigator.of(context).pop();
                      }),
                      DisplayNameChangedAction(
                          (context, oldName, newName) async {
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
                      Container(
                          decoration: BoxDecoration(
                            color: Colors.grey,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          padding: const EdgeInsets.all(10),
                          child: Text(
                            "Please input your name to complete the account creation process. Also, please verify your email and if needed sign out and sign in again!",
                            style: GoogleFonts.poppins(
                              fontSize: 14.0,
                              fontWeight: FontWeight.bold,
                              // color: Colors.white,
                            ),
                          )),
                    ],
                  ),
                ));
              }),
            ],
            headerBuilder: (context, constraints, shrinkOffset) {
              return Padding(
                padding: const EdgeInsets.all(20),
                child: AspectRatio(
                    aspectRatio: 1,
                    child: SvgPicture.asset(
                      'assets/icons/drawer_icon.svg',
                    )),
              );
            },
            subtitleBuilder: (context, action) {
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: action == AuthAction.signIn
                    ? const Text('Welcome to ByCycle, please sign in!')
                    : const Text('Welcome to ByCycle, please sign up!'),
              );
            },
            footerBuilder: (context, action) {
              return const Padding(
                padding: EdgeInsets.only(top: 16),
                child: Text(
                  'By signing in, you agree to our terms and conditions.',
                  style: TextStyle(color: Colors.grey),
                ),
              );
            },
            sideBuilder: (context, shrinkOffset) {
              return Padding(
                padding: const EdgeInsets.all(20),
                child: AspectRatio(
                  aspectRatio: 1,
                  child: SvgPicture.asset(
                    'assets/icons/drawer_icon.svg',
                  ),
                ),
              );
            },
          );
          // } else if (snapshot.data?.displayName != null &&
          //     snapshot.data?.emailVerified == true) {
        } else if (snapshot.data?.displayName != null) {
          return const MyApp();
        }
        return ProfileScreen(
          appBar: AppBar(
              iconTheme: Theme.of(context).brightness == Brightness.light
                  ? const IconThemeData(color: Colors.black)
                  : const IconThemeData(color: Colors.white),
              title: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  // crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text('Your Profile'),
                    // Text(userRepo.loggedInUser!.email!),
                  ])),
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
            Container(
                decoration: BoxDecoration(
                  color: Colors.grey,
                  borderRadius: BorderRadius.circular(10),
                ),
                padding: const EdgeInsets.all(10),
                child: Text(
                  "Please input your name to complete the account creation process. Also, please verify your email and if needed sign out and sign in again!",
                  style: GoogleFonts.poppins(
                    fontSize: 14.0,
                    fontWeight: FontWeight.bold,
                    // color: Colors.white,
                  ),
                )),
          ],
        );
      },
    );
  }
}

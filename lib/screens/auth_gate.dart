import 'package:by_cycle/main.dart';
import 'package:by_cycle/models/user_model.dart';
import 'package:by_cycle/repository/user_repository.dart';
import 'package:by_cycle/screens/feedback.dart';
import 'package:by_cycle/screens/new_user_profile.dart';
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
                  builder: (context) => NewUserProfile(),
                ));
              }),
            ],
            headerBuilder: (context, constraints, shrinkOffset) {
              return Padding(
                padding: const EdgeInsets.all(20),
                child: AspectRatio(
                  aspectRatio: 1,
                  child: Theme.of(context).brightness == Brightness.light
                      ? SvgPicture.asset('assets/icons/drawer_icon.svg')
                      : SvgPicture.asset('assets/icons/drawer_dark.svg'),
                ),
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
        return NewUserProfile();
      },
    );
  }
}

import 'package:by_cycle/main.dart';
import 'package:by_cycle/models/user_model.dart';
import 'package:by_cycle/repository/user_repository.dart';
import 'package:firebase_ui_auth/firebase_ui_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  UserRepository userRepo = UserRepository();
  // final bool _showMessageToNewUser = false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ProfileScreen(
      appBar: AppBar(
          iconTheme: Theme.of(context).brightness == Brightness.light
              ? const IconThemeData(color: Colors.black)
              : const IconThemeData(color: Colors.white),
          title: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              // crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                const Text('Your Profile'),
                Text(userRepo.loggedInUser!.email!),
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
        const Divider(),
        Padding(
          padding: const EdgeInsets.all(2),
          child: AspectRatio(
            aspectRatio: 3,
            child: Theme.of(context).brightness == Brightness.light
                ? SvgPicture.asset('assets/icons/drawer_icon.svg')
                : SvgPicture.asset('assets/icons/drawer_dark.svg'),
          ),
        ),
      ],
    );
  }
}

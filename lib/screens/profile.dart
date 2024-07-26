import 'package:firebase_ui_auth/firebase_ui_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(
          height: 100,
        ),
        ListTile(
          title: const Text('MyAccount'),
          // selected: _selectedIndex == 0,
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute<ProfileScreen>(
                builder: (context) => ProfileScreen(
                  appBar: AppBar(
                    title: const Text('User Profile'),
                  ),
                  actions: [
                    SignedOutAction((context) {
                      Navigator.of(context).pop();
                    })
                  ],
                  children: [
                    const Divider(),
                    Padding(
                      padding: const EdgeInsets.all(2),
                      child: AspectRatio(
                        aspectRatio: 1,
                        child: SvgPicture.asset(
                          'assets/icons/drawer_icon.svg',
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
        ListTile(
          title: const Text('Subscription'),
          // selected: _selectedIndex == 1,
          onTap: () {
            // Update the state of the app
            // _onItemTapped(1);
            // Then close the drawer
            Navigator.pop(context);
          },
        ),
        ListTile(
          title: const Text('Contact'),
          // selected: _selectedIndex == 2,
          onTap: () {
            // Update the state of the app
            // Then close the drawer
            Navigator.pop(context);
          },
        ),
        const Spacer(
          flex: 3,
        ),
        SvgPicture.asset('assets/icons/drawer_icon.svg'),
        const SizedBox(
          height: 50,
        ),
      ],
    );
  }
}

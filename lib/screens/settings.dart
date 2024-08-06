import 'package:by_cycle/screens/feedback.dart';
import 'package:by_cycle/screens/user_profile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Settings extends StatefulWidget {
  const Settings({super.key});

  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: Theme.of(context).brightness == Brightness.light
            ? const IconThemeData(color: Colors.black)
            : const IconThemeData(color: Colors.white),
      ),
      body: Column(
        children: [
          const SizedBox(
            height: 10,
          ),
          ListTile(
            title: Text('MyAccount',
                style: Theme.of(context).textTheme.displaySmall),
            // selected: _selectedIndex == 0,
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const Profile()),
              );
            },
          ),
          const Padding(
            padding: const EdgeInsets.all(12.0),
            child: const Divider(
              height: 1,
              thickness: 1,
              // indent: 15,
              // endIndent: 50,
            ),
          ),
          ListTile(
            title: Text('Feedback form',
                style: Theme.of(context).textTheme.displaySmall),
            // selected: _selectedIndex == 1,
            onTap: () {
              // Update the state of the app
              // _onItemTapped(1);
              // Then close the drawer

              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const FeedbackWidget()),
              );
              // Navigator.pop(context);
            },
          ),
          // ListTile(
          //   title: const Text('Contact'),
          //   // selected: _selectedIndex == 2,
          //   onTap: () {
          //     // Update the state of the app
          //     // Then close the drawer
          //     Navigator.pop(context);
          //   },
          // ),
          const Spacer(
            flex: 3,
          ),
          Theme.of(context).brightness == Brightness.light
              ? SvgPicture.asset('assets/icons/drawer_icon.svg')
              : SvgPicture.asset('assets/icons/drawer_dark.svg'),
          const SizedBox(
            height: 50,
          ),
        ],
      ),
    );
  }
}

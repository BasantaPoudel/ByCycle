import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Profile extends StatefulWidget {
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
            // Update the state of the app
            // _onItemTapped(0);
            // Then close the drawer
            Navigator.pop(context);
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

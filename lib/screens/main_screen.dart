import 'package:flutter/material.dart';

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Container(
          child: Expanded(
              child: Row(
            children: [
              IconButton(
                icon: Icon(Icons.more_vert),
                onPressed: () {
                  // Navigate to the search screen
                },
              ),
              Text('YESTERDAY'),
              Text('TODAY'),
              Text('TOMORROW'),
            ],
          )),
        ),
      ),
      body: Container(
        child: Center(
          child: Text('Hello, Worlcvxcvd!'),
        ),
      ),
    );
  }
}

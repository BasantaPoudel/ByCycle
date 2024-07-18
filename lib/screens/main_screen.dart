import 'package:flutter/material.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

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
                icon: const Icon(Icons.more_vert),
                onPressed: () {
                  // Navigate to the search screen
                },
              ),
              const Text('YESTERDAY'),
              const Text('TODAY'),
              const Text('TOMORROW'),
            ],
          )),
        ),
      ),
      body: Container(
        child: const Center(
          child: Text('Hello, Worlcvxcvd!'),
        ),
      ),
    );
  }
}

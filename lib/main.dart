import 'package:by_cycle/screens/calendar.dart';
import 'package:by_cycle/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ByCycle',
      theme: AppTheme.lightTheme,
      home: const MyHomePage(
        title: 'ByCycle Home Page',
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;
  int _selectedIndex = 0;
  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                IconButton(
                  color: Colors.black,
                  icon: Icon(Icons.more_vert_outlined),
                  onPressed: () {
                    // Navigate to the search screen
                  },
                ),
                Text(
                    style: Theme.of(context).textTheme.bodyMedium, 'YESTERDAY'),
                Text(style: AppTheme.lightTheme.textTheme.bodyMedium, 'TODAY'),
                Text(
                    style: AppTheme.lightTheme.textTheme.bodyMedium,
                    'TOMORROW'),
                IconButton(
                  color: Colors.black,
                  icon: Icon(Icons.calendar_today_outlined),
                  onPressed: () {
                    // Navigate to the search screen
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            Calendar(), // Calendar is the name of the class
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
        body: const Center(
            child: Column(children: [
          Row(mainAxisAlignment: MainAxisAlignment.center, children: [
            ElevatedButton(
                onPressed: null, child: Text("What is your temperature?")),
            ElevatedButton(onPressed: null, child: Text("+"))
          ]),
          Center(
            child: Text('Recommended sleep time'),
          ),
          SizedBox(
            height: 15.0,
          ),
          SizedBox(
              height: 180.0,
              width: 180.0,
              child: CircularProgressIndicator(
                strokeWidth: 15,
                value: 0.4,
                backgroundColor: Color.fromRGBO(222, 212, 197, 1),
                valueColor: AlwaysStoppedAnimation<Color>(Colors.black),
              )),
        ])),
        bottomNavigationBar: BottomNavigationBar(
          onTap: (int index) {
            setState(() {
              _selectedIndex = index;
            });
          },
          currentIndex: _selectedIndex,
          type: BottomNavigationBarType.fixed,
          items: [
            const BottomNavigationBarItem(
              // icon: SvgPicture.asset(
              //   'assets/icons/shop.svg',
              // ),
              icon: Icon(Icons.shopping_bag_outlined),
              label: 'Shop',
            ),
            BottomNavigationBarItem(
              icon: SvgPicture.asset(
                'assets/icons/sleep.svg',
              ),
              label: 'Sleep',
            ),
            BottomNavigationBarItem(
              icon: SvgPicture.asset(
                'assets/icons/home.svg',
              ),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: SvgPicture.asset(
                'assets/icons/blood.svg',
              ),
              label: 'Symtoms',
            ),
            BottomNavigationBarItem(
              icon: SvgPicture.asset(
                'assets/icons/food.svg',
              ),
              label: 'Food',
            ),
          ],
        ) // This trailing comma makes auto-formatting nicer for build methods.
        );
  }
}

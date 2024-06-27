import 'package:by_cycle/firebase_options.dart';
import 'package:by_cycle/repository/main_repository.dart';
import 'package:by_cycle/cubits/theme/theme_cubit.dart';
import 'package:by_cycle/screens/calendar.dart';
import 'package:by_cycle/theme/app_theme.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(BlocProvider(
      create: (BuildContext context) => ThemeCubit(),
      child:
          // Create the ThemeCubit
          MyApp()));
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    var themeCubit = BlocProvider.of<ThemeCubit>(context);

    return BlocBuilder(
      bloc: themeCubit,
      builder: (context, state) {
        return MaterialApp(
          title: 'ByCycle',
          theme: themeCubit.getThemeData(),
          darkTheme: themeCubit.getDarkThemeData(),
          home: MyHomePage(
            title: 'ByCycle Home Page',
          ),
        );
      },
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

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
    final themeCubit = BlocProvider.of<ThemeCubit>(context);
    return Scaffold(
        floatingActionButton: FloatingActionButton(
            //TODO - CleanUp this example code
            onPressed: () {
              MainRepository().addDataToFirestore(<String, dynamic>{
                'email': "test@gmail.com",
                'name': "test",
              });
            },
            tooltip: 'Increment',
            child: const Icon(Icons.add)),
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
                  'YESTERDAY',
                  style: Theme.of(context).textTheme.bodySmall,
                ),
                Text(
                  'TODAY',
                  style: Theme.of(context).textTheme.bodySmall,
                ),
                Text(
                  'TOMORROW',
                  style: Theme.of(context).textTheme.bodySmall,
                ),
                IconButton(
                  color: Colors.black,
                  icon: Icon(Icons.calendar_today_outlined),
                  onPressed: () {
                    // Navigate to the search screen
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Calendar(),
                      ),
                    );
                  },
                ),
                IconButton(
                  color: Colors.black,
                  icon: Icon(Icons.dark_mode_outlined),
                  onPressed: () {
                    themeCubit.toggleTheme();
                    // Navigate to the search screen
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

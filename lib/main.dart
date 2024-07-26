import 'package:by_cycle/cubits/theme/theme_cubit.dart';
import 'package:by_cycle/examples/customDateTimeRanges/example_initial_date_time_ranges.dart';
import 'package:by_cycle/examples/users/new_ovulating_user.dart';
import 'package:by_cycle/firebase_options.dart';
import 'package:by_cycle/screens/home_screen.dart';
import 'package:by_cycle/screens/onboarding/onboarding_pageone.dart';
import 'package:by_cycle/screens/calendar.dart';
import 'package:by_cycle/screens/profile.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final SharedPreferences prefs = await SharedPreferences.getInstance();
  final bool onboardingComplete = prefs.getBool('onboardingComplete') ?? false;

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(BlocProvider(
      create: (BuildContext context) => ThemeCubit(),
      child: onboardingComplete
          ?
          // Create the ThemeCubit
          //TODO - Fix the way to access themeData if this is not correct
          const MyApp()
          : MaterialApp(
              home: const OnboardingPageOne(),
              theme: ThemeCubit().getLightThemeData(),
              darkTheme: ThemeCubit().getDarkThemeData(),
              themeMode: ThemeCubit().state,
            )));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});
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
          theme: themeCubit.getLightThemeData(),
          darkTheme: themeCubit.getDarkThemeData(),
          themeMode: themeCubit.state, // Set the theme mode
          home: const MyHomePage(
            title: 'ByCycle Home Page',
          ),
        );
      },
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
  int _selectedIndex = 0;
  late TimeOfDay bedTime;
  late TimeOfDay wakeupTime;

  @override
  void initState() {
    super.initState();
    setState(() {
      bedTime = TimeOfDay.now();
      wakeupTime =
          TimeOfDay.now().replacing(hour: bedTime.hour, minute: bedTime.minute);
    });
    // initializeDateFormatting();
  }

  final List<Widget> _children = [
    const HomeScreen(),
    const HomeScreen(),
    Calendar(
      //initialDateTimeRanges: new_ovulating_user.phaseRanges,
      initialDateTimeRanges: exampleInitialDateTimeRanges,
    )
  ];

  @override
  Widget build(BuildContext context) {
    final themeCubit = BlocProvider.of<ThemeCubit>(context);
    final isLightTheme = Theme.of(context).brightness == Brightness.light;

    return Scaffold(
        appBar: AppBar(
          leading: Builder(
            builder: (context) => IconButton(
              color: isLightTheme ? Colors.black : Colors.white,
              icon: const Icon(Icons.more_vert_outlined),
              // Change this to your custom icon
              onPressed: () => Scaffold.of(context).openDrawer(),
            ),
          ),
          title: Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(
                  'YESTERDAY',
                  style: Theme.of(context).textTheme.bodySmall,
                ),
                TextButton(
                  child: const Text('TODAY'),
                  onPressed: () {
                    // Navigate to the search screen
                    null;
                  },
                  // style: Theme.of(context).buttonTheme.layoutBehavior,
                ),
                Text(
                  'TOMORROW',
                  style: Theme.of(context).textTheme.bodySmall,
                ),
                IconButton(
                  color: Colors.black,
                  icon: isLightTheme
                      ? SvgPicture.asset(
                          'assets/icons/dark_mode.svg',
                        )
                      : SvgPicture.asset(
                          'assets/icons/light_mode.svg',
                        ),
                  onPressed: () {
                    themeCubit.toggleTheme();
                    // Navigate to the search screen
                  },
                ),
              ],
            ),
          ),
        ),
        drawer: SizedBox(
          width: MediaQuery.of(context).size.width * 0.8,
          child: const Drawer(
              // Add a ListView to the drawer. This ensures the user can scroll
              // through the options in the drawer if there isn't enough vertical
              // space to fit everything.
              child: Profile()),
        ),
        body: _children[_selectedIndex],
        bottomNavigationBar: BottomNavigationBar(
          onTap: (int index) {
            setState(() {
              _selectedIndex = index;
            });
          },
          currentIndex: _selectedIndex,
          type: BottomNavigationBarType.fixed,
          items: [
            BottomNavigationBarItem(
              icon: SvgPicture.asset(
                'assets/icons/stats.svg',
              ),
              label: 'Stats',
            ),
            BottomNavigationBarItem(
              icon: SvgPicture.asset(
                'assets/icons/home.svg',
              ),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: SvgPicture.asset(
                'assets/icons/calendar.svg',
              ),
              label: 'Calendar',
            ),
          ],
        )); // This trailing comma makes auto-formatting nicer for build methods.
  }
}

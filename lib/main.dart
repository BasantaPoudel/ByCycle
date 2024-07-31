import 'package:by_cycle/cubits/theme/theme_cubit.dart';

import 'package:by_cycle/firebase_options.dart';
import 'package:by_cycle/models/custom_date_time_range.dart';
import 'package:by_cycle/repository/user_repository.dart';
import 'package:by_cycle/screens/auth_gate.dart';
import 'package:by_cycle/screens/home_screen.dart';
import 'package:by_cycle/screens/onboarding/onboarding_pageone.dart';
import 'package:by_cycle/screens/calendar.dart';
import 'package:by_cycle/screens/user_profile.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:logger/logger.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(RestartWidget(
    child: BlocProvider(
        create: (BuildContext context) => ThemeCubit(),
        child: MaterialApp(
          home: const AuthGate(),
          theme: ThemeCubit().getLightThemeData(),
          darkTheme: ThemeCubit().getDarkThemeData(),
          themeMode: ThemeCubit().state,
        )),
  ));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool onboardingCompleteCheck = false;

  @override
  initState() {
    super.initState();
    // getPhaseRanges();
    // initializeDateFormatting();
    getOnBoadingCompleteValue();
  }

  Future<void> getOnBoadingCompleteValue() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final bool onboardingComplete =
        prefs.getBool('onboardingComplete') ?? false;
    setState(() {
      onboardingCompleteCheck = onboardingComplete;
    });
  }

  @override
  Widget build(BuildContext context) {
    var themeCubit = BlocProvider.of<ThemeCubit>(context);
    return BlocBuilder(
      bloc: themeCubit,
      builder: (context, state) {
        return onboardingCompleteCheck
            ? MaterialApp(
                title: 'ByCycle',
                theme: themeCubit.getLightThemeData(),
                darkTheme: themeCubit.getDarkThemeData(),
                themeMode: themeCubit.state, // Set the theme mode
                home: const MyHomePage(
                  title: 'ByCycle Home Page',
                ),
              )
            : const OnboardingPageOne();
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

  var logger = Logger();
  late List<CustomDateTimeRange> phaseRanges;
  UserRepository userRepo = UserRepository();
  @override
  void initState() {
    super.initState();
    // getPhaseRanges();
    // initializeDateFormatting();
  }

  final List<Widget> _children = [
    const HomeScreen(),
    const HomeScreen(),
  ];

  Future<String> getPhaseRanges() async {
    var phaseRangesFromUser = await userRepo.getPhaseRanges();
    setState(() {
      phaseRanges = phaseRangesFromUser;
      if (_children.length == 3) _children.remove(2);
      // _children.remove(3);
      _children.add(Calendar(initialDateTimeRanges: phaseRanges));
    });
    return 'Success';
  }

  @override
  Widget build(BuildContext context) {
    final themeCubit = BlocProvider.of<ThemeCubit>(context);
    final isLightTheme = Theme.of(context).brightness == Brightness.light;
    // );
    return FutureBuilder(
        future: getPhaseRanges(),
        builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
          if (snapshot.hasData) {
            return Scaffold(
                appBar: AppBar(
                  // leading: Builder(
                  //   builder: (context) => IconButton(
                  //     color: isLightTheme ? Colors.black : Colors.white,
                  //     icon: const Icon(Icons.assistant_outlined),
                  //     // Change this to your custom icon
                  //     // onPressed: () => Scaffold.of(context).openDrawer(),
                  //     onPressed: () {
                  //       Navigator.push(
                  //         context,
                  //         MaterialPageRoute(builder: (context) => Profile()),
                  //       );
                  //     },
                  //   ),
                  // ),
                  title: Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        IconButton(
                          color: isLightTheme ? Colors.black : Colors.white,
                          icon: const Icon(Icons.assistant_outlined),
                          // Change this to your custom icon
                          // onPressed: () => Scaffold.of(context).openDrawer(),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => Profile()),
                            );
                          },
                        ),
                        TextButton(
                          child: Text(
                            'TODAY',
                            style: Theme.of(context).textTheme.bodyLarge,
                          ),
                          onPressed: () {
                            // Navigate to the search screen
                            null;
                          },
                          // style: Theme.of(context).buttonTheme.layoutBehavior,
                        ),
                        Text(
                          DateFormat('dd.mm.yyyy').format(DateTime.now()),
                          style: Theme.of(context).textTheme.bodyLarge,
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
                // drawer: SizedBox(
                //   width: MediaQuery.of(context).size.width * 0.8,
                //   child: Drawer(
                //       // Add a ListView to the drawer. This ensures the user can scroll
                //       // through the options in the drawer if there isn't enough vertical
                //       // space to fit everything.
                //       child: Profile()),
                // ),
                body: _children[_selectedIndex],
                bottomNavigationBar: Container(
                  //TODO - fix height property so that it doesn't produce 8.0 pixels overflow on-screen error
                  // height: 70,
                  decoration: const BoxDecoration(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(25),
                        topRight: Radius.circular(25),
                      ),
                      color: Colors.red),
                  child: ClipRRect(
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(25),
                      topRight: Radius.circular(25),
                    ),
                    child: BottomNavigationBar(
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
                    ),
                  ),
                ));
          } else {
            return Center(child: CircularProgressIndicator());
          }
        }); // This trailing comma makes auto-formatting nicer for build methods.
  }
}

class RestartWidget extends StatefulWidget {
  final Widget child;

  const RestartWidget({Key? key, required this.child}) : super(key: key);

  static void restartApp(BuildContext context) {
    context.findAncestorStateOfType<_RestartWidgetState>()?.restartApp();
  }

  @override
  _RestartWidgetState createState() => _RestartWidgetState();
}

class _RestartWidgetState extends State<RestartWidget> {
  Key key = UniqueKey();

  void restartApp() {
    setState(() {
      key = UniqueKey();
    });
  }

  @override
  Widget build(BuildContext context) {
    return KeyedSubtree(
      key: key,
      child: widget.child,
    );
  }
}

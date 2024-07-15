import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';

enum ThemeMode { lightTheme, darkTheme }

class ThemeCubit extends Cubit<ThemeMode> {
  ThemeCubit() : super(ThemeMode.darkTheme);

  void toggleTheme() {
    if (state == ThemeMode.lightTheme) {
      emit(ThemeMode.darkTheme);
    } else {
      emit(ThemeMode.lightTheme);
    }
  }

  ThemeData getThemeData() {
    if (state == ThemeMode.lightTheme) {
      return ThemeData(
        brightness: Brightness.light,
        buttonTheme: const ButtonThemeData(
          buttonColor: Color(0xFFDED4C5), // Set the button color
          textTheme: ButtonTextTheme.primary, // Set the button text theme
        ),
        floatingActionButtonTheme: const FloatingActionButtonThemeData(
          backgroundColor:
              Color(0xFFDED4C5), // Set the floating button background color
        ),
        textTheme: const TextTheme(
          displayLarge: TextStyle(
            fontSize: 72.0,
            fontWeight: FontWeight.bold,
          ),
          displayMedium: TextStyle(
            fontSize: 36.0,
            fontStyle: FontStyle.italic,
          ),
          displaySmall: TextStyle(
            fontSize: 14.0,
            fontFamily: 'Hind',
          ),
          bodyLarge: TextStyle(
            fontSize: 14.0,
            fontFamily: 'Hind',
          ),
          bodyMedium: TextStyle(
            fontSize: 12.0,
            fontFamily: 'Hind',
          ),
          bodySmall: TextStyle(
            fontSize: 10.0,
            fontFamily: 'Hind',
          ),
        ),
        bottomNavigationBarTheme: const BottomNavigationBarThemeData(
            backgroundColor: Color(0xFFDED4C5),
            selectedItemColor: Colors.black,
            selectedIconTheme: IconThemeData(
                fill:
                    BorderSide.strokeAlignCenter) // Set the selected item color
            ),

        cardTheme: CardTheme(
          color: const Color.fromRGBO(222, 212, 197, 1), // Set the card color
          elevation: 2, // Set the card elevation
          shape: RoundedRectangleBorder(
            borderRadius:
                BorderRadius.circular(8), // Set the card border radius
          ),
        ),
        scaffoldBackgroundColor:
            const Color(0xFFFEF7ED), // Set the background color
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFFFEF7ED), // Set the app bar color
          iconTheme: IconThemeData(
            color: Colors.white, // Set the icon color
          ),
        ),
      );
    } else {
      return ThemeData(
        brightness: Brightness.dark,
        buttonTheme: const ButtonThemeData(
          buttonColor: Colors.blue, // Set the button color
          textTheme: ButtonTextTheme.primary, // Set the button text theme
        ),

        iconTheme: const IconThemeData(
          color: Colors.white, // Set the default color for icons
        ),

        cardTheme: CardTheme(
          color: Colors.grey[800], // Set the card color to a dark shade
          elevation: 2, // Set the card elevation
          shape: RoundedRectangleBorder(
            borderRadius:
                BorderRadius.circular(8), // Set the card border radius
          ),
        ),
        textTheme: const TextTheme(
          displayLarge: TextStyle(
            fontSize: 72.0,
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
          displayMedium: TextStyle(
            fontSize: 36.0,
            color: Colors.white,
            fontStyle: FontStyle.italic,
          ),
          displaySmall: TextStyle(
            fontSize: 14.0,
            color: Colors.white,
            fontFamily: 'Hind',
          ),
          bodyLarge: TextStyle(
            fontSize: 14.0,
            color: Colors.white,
            fontFamily: 'Hind',
          ),
          bodyMedium: TextStyle(
            fontSize: 12.0,
            color: Colors.white,
            fontFamily: 'Hind',
          ),
          bodySmall: TextStyle(
            fontSize: 10.0,
            color: Colors.white,
            fontFamily: 'Hind',
          ),
        ),

        scaffoldBackgroundColor:
            Colors.black, // Set the background color to a dark shade
      );
    }
  }

  ThemeData getDarkThemeData() {
    return ThemeData(
      brightness: Brightness.dark,
      buttonTheme: const ButtonThemeData(
        buttonColor: Colors.blue, // Set the button color
        textTheme: ButtonTextTheme.primary, // Set the button text theme
      ),

      iconTheme: const IconThemeData(
        color: Colors.white, // Set the default color for icons
      ),

      cardTheme: CardTheme(
        color: Colors.grey[800], // Set the card color to a dark shade
        elevation: 2, // Set the card elevation
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8), // Set the card border radius
        ),
      ),
      textTheme: const TextTheme(
        displayLarge: TextStyle(
          fontSize: 72.0,
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ),
        displayMedium: TextStyle(
          fontSize: 36.0,
          color: Colors.white,
          fontStyle: FontStyle.italic,
        ),
        displaySmall: TextStyle(
          fontSize: 14.0,
          color: Colors.white,
          fontFamily: 'Hind',
        ),
        bodyLarge: TextStyle(
          fontSize: 14.0,
          color: Colors.white,
          fontFamily: 'Hind',
        ),
        bodyMedium: TextStyle(
          fontSize: 12.0,
          color: Colors.white,
          fontFamily: 'Hind',
        ),
        bodySmall: TextStyle(
          fontSize: 10.0,
          color: Colors.white,
          fontFamily: 'Hind',
        ),
      ),

      scaffoldBackgroundColor:
          Colors.black, // Set the background color to a dark shade
    );
  }

  ThemeData getLightThemeData() {
    return ThemeData(
      brightness: Brightness.light,
      buttonTheme: const ButtonThemeData(
        buttonColor: Color(0xFFDED4C5), // Set the button color
        textTheme: ButtonTextTheme.primary, // Set the button text theme
      ),
      floatingActionButtonTheme: const FloatingActionButtonThemeData(
        backgroundColor:
            Color(0xFFDED4C5), // Set the floating button background color
      ),
      textTheme: const TextTheme(
        displayLarge: TextStyle(
          fontSize: 72.0,
          fontWeight: FontWeight.bold,
        ),
        displayMedium: TextStyle(
          fontSize: 36.0,
          fontStyle: FontStyle.italic,
        ),
        displaySmall: TextStyle(
          fontSize: 14.0,
          fontFamily: 'Hind',
        ),
        bodyLarge: TextStyle(
          fontSize: 14.0,
          fontFamily: 'Hind',
        ),
        bodyMedium: TextStyle(
          fontSize: 12.0,
          fontFamily: 'Hind',
        ),
        bodySmall: TextStyle(
          fontSize: 10.0,
          fontFamily: 'Hind',
        ),
      ),
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
          backgroundColor: Color(0xFFDED4C5),
          selectedItemColor: Colors.black,
          selectedIconTheme: IconThemeData(
              fill: BorderSide.strokeAlignCenter) // Set the selected item color
          ),

      cardTheme: CardTheme(
        color: const Color.fromRGBO(222, 212, 197, 1), // Set the card color
        elevation: 2, // Set the card elevation
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8), // Set the card border radius
        ),
      ),
      scaffoldBackgroundColor:
          const Color(0xFFFEF7ED), // Set the background color
      appBarTheme: const AppBarTheme(
        backgroundColor: Color(0xFFFEF7ED), // Set the app bar color
        iconTheme: IconThemeData(
          color: Colors.white, // Set the icon color
        ),
      ),
    );
  }
}

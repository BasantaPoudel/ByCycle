import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ThemeCubit extends Cubit<ThemeMode> {
  ThemeCubit() : super(ThemeMode.system);

  void toggleTheme() {
    if (state == ThemeMode.light) {
      emit(ThemeMode.dark);
    } else if (state == ThemeMode.system) {
      final brightness =
          WidgetsBinding.instance.platformDispatcher.platformBrightness;
      emit((brightness == Brightness.dark) ? ThemeMode.light : ThemeMode.dark);
    } else {
      emit(ThemeMode.light);
    }
  }

  ThemeData getDarkThemeData() {
    return ThemeData(
      brightness: Brightness.dark,
      elevatedButtonTheme: ElevatedButtonThemeData(
          style: ButtonStyle(
        backgroundColor:
            MaterialStateProperty.all<Color>(const Color(0xFFDED4C5)),
        foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
        padding:
            MaterialStateProperty.all<EdgeInsets>(const EdgeInsets.all(16)),
        // textStyle:
        //     MaterialStateProperty.all<TextStyle>(TextStyle(fontSize: 20)),
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.0),
          ),
        ),
        // elevation: MaterialStateProperty.all<double>(5.0),
      )),

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
      textTheme: TextTheme(
        displayLarge: GoogleFonts.poppins(
          fontSize: 72.0,
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ),
        displayMedium: GoogleFonts.poppins(
          fontSize: 36.0,
          color: Colors.white,
          // fontStyle: FontStyle.italic,
        ),
        displaySmall: GoogleFonts.poppins(
          fontSize: 20.0,
          color: Colors.white,
        ),
        bodyLarge: GoogleFonts.poppins(
          fontSize: 14.0,
          color: Colors.white,
        ),
        bodyMedium: GoogleFonts.poppins(
          fontSize: 12.0,
          color: Colors.white,
        ),
        bodySmall: GoogleFonts.poppins(
          fontSize: 10.0,
          color: Colors.white,
        ),
      ),
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
          backgroundColor: Color(0xFFD6A879),
          selectedItemColor: Colors.black,
          selectedIconTheme: IconThemeData(
              fill: BorderSide.strokeAlignCenter) // Set the selected item color
          ),
      scaffoldBackgroundColor:
          Colors.black, // Set the background color to a dark shade
    );
  }

  ThemeData getLightThemeData() {
    return ThemeData(
      brightness: Brightness.light,
      elevatedButtonTheme: ElevatedButtonThemeData(
          style: ButtonStyle(
        backgroundColor:
            MaterialStateProperty.all<Color>(const Color(0xFFDED4C5)),
        foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
        padding:
            MaterialStateProperty.all<EdgeInsets>(const EdgeInsets.all(16)),
        // textStyle:
        //     MaterialStateProperty.all<TextStyle>(TextStyle(fontSize: 20)),
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.0),
          ),
        ),
        // elevation: MaterialStateProperty.all<double>(5.0),
      )),
      buttonTheme: const ButtonThemeData(
          // buttonColor: Color(0xFFDED4C5), // Set the button color
          // textTheme: ButtonTextTheme.primary, // Set the button text theme
          ),
      floatingActionButtonTheme: const FloatingActionButtonThemeData(
        backgroundColor:
            Color(0xFFDED4C5), // Set the floating button background color
      ),
      textTheme: TextTheme(
        displayLarge: GoogleFonts.poppins(
          fontSize: 72.0,
          color: Colors.black,
          fontWeight: FontWeight.bold,
        ),
        displayMedium: GoogleFonts.poppins(
          fontSize: 36.0,
          color: Colors.black,
          // fontStyle: FontStyle.italic,
        ),
        displaySmall: GoogleFonts.poppins(
          fontSize: 20.0,
          color: Colors.black,
        ),
        bodyLarge: GoogleFonts.poppins(
          fontSize: 14.0,
          color: Colors.black,
        ),
        bodyMedium: GoogleFonts.poppins(
          fontSize: 12.0,
          color: Colors.black,
        ),
        bodySmall: GoogleFonts.poppins(
          fontSize: 10.0,
          color: Colors.black,
        ),
      ),
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
          backgroundColor: Color(0xFFDED4C5),
          selectedItemColor: Colors.black,
          selectedIconTheme: IconThemeData(
              fill: BorderSide.strokeAlignCenter) // Set the selected item color
          ),

      cardTheme: CardTheme(
        color: const Color(0xFFDED4C5), // Set the card color
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

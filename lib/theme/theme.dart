import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/material.dart';

import '../utilities/constants.dart';

// This is our  main focus
// Let's apply light and dark theme on our app
// Now let's add dark theme on our app
ThemeData lightThemeData(BuildContext context) {
  return ThemeData.light().copyWith(
    primaryColor: kPrimaryColor,
    scaffoldBackgroundColor: Colors.white,
    appBarTheme: const AppBarTheme(
      centerTitle: true,
      elevation: 0,
      backgroundColor: Colors.white,
      foregroundColor: kContentColorLightTheme,
    ),
    inputDecorationTheme: InputDecorationTheme(
      fillColor: Colors.grey.withOpacity(0.30),
    ),
    tabBarTheme: TabBarTheme(
      labelColor: kContentColorLightTheme,
      unselectedLabelColor: kContentColorLightTheme.withOpacity(0.80),
      indicatorSize: TabBarIndicatorSize.label,
      labelStyle: const TextStyle(fontWeight: FontWeight.bold),
      indicator: const BoxDecoration(
          color: kContentColorLightTheme,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(3), bottomRight: Radius.circular(3))),
    ),
    iconTheme: const IconThemeData(color: kContentColorLightTheme),
    textTheme: GoogleFonts.interTextTheme(Theme.of(context).textTheme)
        .apply(bodyColor: kContentColorLightTheme),
    colorScheme: const ColorScheme.light(
      primary: kPrimaryColor,
      secondary: kSecondaryColor,
      error: kErrorColor,
    ),
  );
}

ThemeData darkThemeData(BuildContext context) {
  // Bydefault flutter provie us light and dark theme
  // we just modify it as our need
  return ThemeData.dark().copyWith(
    primaryColor: kPrimaryColor,
    scaffoldBackgroundColor: kContentColorLightTheme,
    appBarTheme: const AppBarTheme(
      centerTitle: true,
      elevation: 0,
      backgroundColor: kSecondaryColor,
    ),
    tabBarTheme: TabBarTheme(
      labelColor: kContentColorDarkTheme,
      unselectedLabelColor: kContentColorDarkTheme.withOpacity(0.32),
      indicatorSize: TabBarIndicatorSize.label,
      labelStyle: const TextStyle(fontWeight: FontWeight.bold),
      indicator: const BoxDecoration(
          color: kContentColorDarkTheme,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(3), bottomRight: Radius.circular(3))),
    ),
    iconTheme: const IconThemeData(color: kContentColorDarkTheme),
    textTheme: GoogleFonts.interTextTheme(Theme.of(context).textTheme)
        .apply(bodyColor: kContentColorDarkTheme),
    colorScheme: const ColorScheme.dark().copyWith(
      primary: kContentColorLightTheme,
      secondary: kSecondaryColor,
      error: kPrimaryColor,
    ),
  );
}

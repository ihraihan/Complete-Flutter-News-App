import 'package:flutter/material.dart';

class L10n {
  static const all = [
    Locale('en', ''), // English, no country code
    Locale('ar', ''), // English, no country code
    Locale('es', ''), // Spanish, no country code
    Locale('bn', ''), // Spanish, no country code
    Locale('hi', ''), // Hindi, no country code
    Locale('de', ''), // German, no country code
  ];

  static String getFlag(String code) {
    switch (code) {
      case 'ar':
        return "🇦🇪";
      case 'es':
        return "🇪🇸";
      case 'bn':
        return "🇧🇩";
      case 'hi':
        return "🇮🇳";
      case 'de':
        return "🇩🇪";
      default:
        return "🇺🇸";
    }
  }
}

import 'package:flutter/material.dart';

import '../l10n/l10n.dart';

class LocaleProvider with ChangeNotifier {
  Locale? _locale;

  Locale? get getLocale => _locale;

  void setLocale(locale) {
    if (!L10n.all.contains(locale)) return;

    _locale = locale;
    notifyListeners();
  }

  void clearLocale() {
    L10n.all.clear();
    notifyListeners();
  }
}

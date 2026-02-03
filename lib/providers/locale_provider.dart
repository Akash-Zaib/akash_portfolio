import 'package:flutter/material.dart';

class LocaleProvider extends ChangeNotifier {
  Locale _locale = const Locale('en');

  Locale get locale => _locale;

  void setLocale(Locale locale) {
    if (!supportedLocales.contains(locale)) return;
    _locale = locale;
    notifyListeners();
  }

  static const List<Locale> supportedLocales = [
    Locale('en'), // English
    Locale('ur'), // Urdu
    Locale('fr'), // French
    Locale('es'), // Spanish
    Locale('de'), // German
    Locale('ar'), // Arabic
  ];

  static const Map<String, String> localeNames = {
    'en': 'English',
    'ur': 'اردو',
    'fr': 'Français',
    'es': 'Español',
    'de': 'Deutsch',
    'ar': 'العربية',
  };

  static const Map<String, String> localeFlags = {
    'en': '🇺🇸',
    'ur': '🇵🇰',
    'fr': '🇫🇷',
    'es': '🇪🇸',
    'de': '🇩🇪',
    'ar': '🇸🇦',
  };

  // Check if the current locale is RTL (Right-to-Left)
  bool get isRTL => _locale.languageCode == 'ar' || _locale.languageCode == 'ur';
}

import 'dart:async';

import 'package:flutter/material.dart';

import 'wpb_localizations.dart';

//  See:  https://phraseapp.com/blog/posts/how-to-internationalize-a-flutter-app/

class SitLocalizationsDelegate extends LocalizationsDelegate<SitLocalizations> {
  const SitLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) => ['ar', 'en'].contains(locale.languageCode);

  @override
  Future<SitLocalizations> load(Locale locale) => SitLocalizations.load(locale);

  @override
  bool shouldReload(LocalizationsDelegate<SitLocalizations> old) => false;
}
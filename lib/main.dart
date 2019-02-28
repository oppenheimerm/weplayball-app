import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'lang/wpb_localizations_delegate.dart';
import 'package:weplayball/pages/page_root.dart';
import 'package:weplayball/service/auth/auth_provider.dart';
import 'package:weplayball/service/auth/Auth.dart';


//  Entry point for our application
void main() {

  //  Set our app to vertical orientation only
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown])
      .then((_) => runApp(new MyApp()));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AuthProvider(
      auth: Auth(),
      child: MaterialApp(
        title: 'WePlayBall',
        home: RootPage(),
        theme: ThemeData(fontFamily: 'Poppins'),
        debugShowCheckedModeBanner: false,
        localizationsDelegates: [
          const SitLocalizationsDelegate(),
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
        ],
        supportedLocales: [
          // The order of this list matters. By default, if the
          // device's locale doesn't exactly match a locale in
          // supportedLocales then the first locale in
          // supportedLocales with a matching
          // Locale.languageCode is used. If that fails then the
          // first locale in supportedLocales is used.
          const Locale('en'),
        ],
      ),
    );
  }
}
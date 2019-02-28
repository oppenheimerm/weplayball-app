import 'package:flutter/material.dart';
import 'package:weplayball/pages/login.dart';
import 'package:weplayball/pages/main.dart';
import 'package:weplayball/service/authenticationStatus.dart';
import 'package:weplayball/service/auth/auth_provider.dart';

class RootPage extends StatefulWidget {

  @override
  State<StatefulWidget> createState() => _RootPageState();
}


class _RootPageState extends State<RootPage> {
  //  init page
  AuthStatus authStatus = AuthStatus.notDetermined;


  //  Called when a dependency of this State object changes
  //  see: https://docs.flutter.io/flutter/widgets/SingleTickerProviderStateMixin/didChangeDependencies.html
  @override
  void didChangeDependencies() async {
    super.didChangeDependencies();
    var auth = AuthProvider.of(context).auth;
    auth.currentUser().then((user) {
      setState(() {
        authStatus = (user.userId == null) ? AuthStatus.notSignedIn : AuthStatus.signedIn;
      });
    });
  }

  void _signedIn() {
    setState(() {
      authStatus = AuthStatus.signedIn;
    });
  }

  void _signedOut() {
    setState(() {
      authStatus = AuthStatus.notSignedIn;
    });
  }

  @override
  Widget build(BuildContext context) {
    switch (authStatus) {
      case AuthStatus.notDetermined:
        return _buildWaitingScreen();
      case AuthStatus.notSignedIn:
        return LoginPage(
          onSignedIn: _signedIn,
        );
      case AuthStatus.signedIn:
        return MainPage(
          onSignedOut: _signedOut,
          authStatus: AuthStatus.signedIn,
        );
    }
    return null;
  }

  Widget _buildWaitingScreen() {
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        child: CircularProgressIndicator(),
      ),
    );
  }
}
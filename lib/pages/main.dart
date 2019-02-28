import 'package:flutter/material.dart';
import 'package:weplayball/pages/login.dart';
import 'package:weplayball/pages/tabs/fixtures.dart';
import 'package:weplayball/pages/tabs/instafavs.dart';
import 'package:weplayball/pages/tabs/results.dart';
import 'package:weplayball/pages/tabs/standings.dart';
import 'package:weplayball/service/auth/auth_provider.dart';
import 'package:weplayball/service/authenticationStatus.dart';
import 'package:weplayball/ui/colors.dart';
import 'package:weplayball/ui/layout.dart';


class MainPage extends StatefulWidget {
  MainPage({this.onSignedOut, this.authStatus});

  final VoidCallback onSignedOut;
  var _assetBaseUrl = "https://weplayball.azurewebsites.net";
  AuthStatus authStatus;

  @override
  _MainPageState createState() => _MainPageState();

  void _signOut(BuildContext context) async {
    try {
      var auth = AuthProvider.of(context).auth;
      await auth.signOut();
      onSignedOut();
    } catch (e) {
      print(e);
    }
  }

}


class _MainPageState extends State<MainPage> {
  int _currentIndex = 0;
  //AuthStatus authStatus = AuthStatus.notDetermined;
  //  init page
  AuthStatus authStatus = AuthStatus.notDetermined;


  //  handle ontap
  _onTapped(int index) {
    setState(() {
      _currentIndex = index;
      //print('index is now: $index');
    });
  }

  //  We can't execute an asynchronous operation in the render method of a widget.
  //  This doesn't work, but is also bad because it gets called every time the state
  //  or properties get updated. It can lead to a lot of unnecessary work.
  //  See:  https://flutter.institute/run-async-operation-on-widget-creation/
  /*@override
  void initState() {
    // This is the proper place to make the async calls
    // This way they only get called once
    // During development, if you change this code,
    // you will need to do a full restart instead of just a hot reload
    // You can't use async/await here,
    // We can't mark this method as async because of the @override
    BaseAuth auth = new Auth();
    auth.currentUser().then((result) {
      // If we need to rebuild the widget with the resulting data,
      // make sure to use `setState`
      setState(() {
        widget._userModel = result;
      });
    });
  }*/

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


  @override
  Widget build(BuildContext context) {

    if(authStatus == AuthStatus.signedIn)
    {
      //  Screens
      List<Widget> _screens = [
        FixturesTab(AuthStatus.signedIn, widget._assetBaseUrl),
        ResultsTab(AuthStatus.signedIn, widget._assetBaseUrl),
        StandingsTab(widget._assetBaseUrl),
        InstFavsTabTab(AuthStatus.signedIn, widget._assetBaseUrl),
        //Center(child: Text('Latest')),
      ];

      return Scaffold(
        backgroundColor: Color(getColourHexFromString(primaryWhiteGrey)),
        appBar: AppBar(
          title: Text(
            'WEPLAYBALL',
            style: TextStyle(
              fontFamily: 'Poppins',
              fontWeight: FontWeight.w800,
              letterSpacing: 0.8,
              fontSize: 15.0,
              color: Color(getColourHexFromString(primaryBlack)),
            ),
          ),
          iconTheme: new IconThemeData(
              color: Color(getColourHexFromString(primaryBlack))),
          centerTitle: true,
          elevation: 0.025,
          backgroundColor: Colors.white,
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.exit_to_app),
              onPressed: () => widget._signOut(context),
            ),
          ],
        ),
        drawer: Drawer(
          child: ListView(
            children: <Widget>[
              Stack(
                  children: <Widget>[
                    Container(
                      height: 250.0,
                      width: double.infinity,
                      color: Color(getColourHexFromString(primaryOrange)),
                    ),
                    //  Create our bubble effect
                    //  Control where the child of a stack is created
                    Positioned(
                      // bottom margin
                      bottom: 50.0,
                      //  right margin
                      right: 100.0,
                      child: Container(
                        height: 400.0,
                        width: 400.0,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(200.0),
                          color: Color(getColourHexFromString("#FFFFFF")).withOpacity(0.2),

                        ),
                      ),
                    ),
                    Positioned(
                      // bottom margin
                      bottom: -100.0,
                      //  right margin
                      left: 50.0,
                      child: Container(
                        height: 300.0,
                        width: 300.0,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(200.0),
                          color: Color(getColourHexFromString("#FFFFFF")).withOpacity(0.2),

                        ),
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        addSizedBoxPadding(15.0, 0),
                        Row(
                          children: <Widget>[
                            //  add some padding
                            SizedBox( width: 8.0,),
                            Container(
                              alignment: Alignment.center,
                              height: 50.0,
                              width: 50.0,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(25.0),
                                border:Border.all(color: Colors.white,
                                  style: BorderStyle.solid,
                                  width: 2.0,
                                ),
                                image: DecorationImage(
                                  image: AssetImage('graphics/profile.png'),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ]
              )
            ],
          ),
        ),
        //body: _screens[_currentIndex],
        body: Container(
          decoration: BoxDecoration(
            gradient: new LinearGradient(colors: [gradientStart, gradientEnd],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                stops: [0.0,1.0],
            ),
          ),
          child: _screens[_currentIndex],
        ),
        bottomNavigationBar: BottomNavigationBar(
            currentIndex: _currentIndex,
            onTap: _onTapped,
            type: BottomNavigationBarType.fixed,
            fixedColor: Color(getColourHexFromString(primaryBlue)),
            items: [
              BottomNavigationBarItem(
                  title: Text('Fixtures'), icon: Icon(Icons.home)),
              BottomNavigationBarItem(
                  title: Text('Results'), icon: Icon(Icons.whatshot)),
              BottomNavigationBarItem(
                  title: Text('Standings'), icon: Icon(Icons.insert_chart)),
              BottomNavigationBarItem(
                  title: Text('Instagram'), icon: Icon(Icons.photo_album)),
            ]),
      );
    }
    else {
      return LoginPage(
        onSignedIn: _signedIn,
      );
    }
  }
}
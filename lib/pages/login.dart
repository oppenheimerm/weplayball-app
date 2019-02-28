import 'package:flutter/material.dart';
import 'package:weplayball/pages/main.dart';
import 'package:weplayball/service/auth/auth_provider.dart';
import 'package:weplayball/service/authenticationStatus.dart';
import 'package:weplayball/ui/colors.dart';
import 'package:weplayball/ui/layout.dart';


class LoginPage extends StatefulWidget {
  LoginPage({this.onSignedIn});
  final VoidCallback onSignedIn;

  @override
  State<StatefulWidget> createState() => _LoginPageState();
}


class _LoginPageState extends State<LoginPage> {
  final formKey = GlobalKey<FormState>();
  AuthStatus authStatus = AuthStatus.notSignedIn;

  String _username;
  String _password;
  var _userNameMinLength = 5;

  bool validateAndSave() {
    final form = formKey.currentState;
    if (form.validate()) {
      form.save();
      return true;
    }
    return false;
  }

  void validateAndSubmit() async {
    print('validateAndSubmit() called');
    if (validateAndSave()) {
      try {

        var auth = AuthProvider.of(context).auth;
        var user = await auth.requestLoginAPI(_username, _password);
        print('Signed in as: ${user.body.userName}');
        widget.onSignedIn();
      } catch (e) {
        print('Error: $e');
      }
    }
  }



  String validateName(String stringVal, int minLength, String fieldName) {
    if (stringVal.length < minLength)
      return '$fieldName must be a minimum of $minLength charaters';
    else
      return null;
  }

  String validateUsername(String value){
    return validateName(value, _userNameMinLength, "Username");
  }


  @override
  Widget build(BuildContext context,) {

    return new Scaffold(
      resizeToAvoidBottomPadding: false,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            child: Stack(
              children: <Widget>[
                Container(
                  padding: EdgeInsets.fromLTRB(16.0, 110.0, 0.0, 0.0),
                  child: Text(
                      "Let's",
                      style: TextStyle(
                        fontSize: 80.0,
                        fontWeight: FontWeight.bold,
                        color: Color(getColourHexFromString(primaryBlack)),
                      )
                  ),
                ),
                Container(
                  padding: EdgeInsets.fromLTRB(16.0, 175.0, 0.0, 0.0),
                  child: Text(
                      "Play",
                      style: TextStyle(
                        fontSize: 80.0,
                        fontWeight: FontWeight.bold,
                        color: Color(getColourHexFromString(primaryBlack)),
                      )
                  ),
                ),
                Container(
                  padding: EdgeInsets.fromLTRB(165.0, 175.0, 0.0, 0.0),
                  child: Text(
                      ".",
                      style: TextStyle(
                        fontSize: 80.0,
                        fontWeight: FontWeight.bold,
                        color: Color(getColourHexFromString(primaryBlue)),
                      )
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.only(top: 35.0, left: 20.0, right: 20.0),
            child: Column(
              children: <Widget>[
                Container(
                  child:SingleChildScrollView(
                    child: ConstrainedBox(
                      constraints: BoxConstraints(),
                      child: Form(
                        //  Set the form key:
                        key: formKey,
                        child: Column(
                          //  Require all children to fill the cross axis
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: <Widget>[
                            TextFormField(
                              decoration: InputDecoration(
                                labelText: 'USERNAME',
                                labelStyle: TextStyle(
                                  fontFamily: stdFontFamily,
                                  fontWeight: FontWeight.bold,
                                  color: Color(getColourHexFromString(primaryDarkGrey)),
                                ),
                                focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: Color(getColourHexFromString(primaryBlue))),
                                ),
                              ),

                              validator: validateUsername,
                              onSaved: (value) => _username = value,
                            ),
                            //  add some padding
                            addSizedBoxPadding(16.0, 0),
                            TextFormField(
                              decoration: InputDecoration(
                                labelText: 'PASSWORD',
                                labelStyle: TextStyle(
                                  fontFamily: stdFontFamily,
                                  fontWeight: FontWeight.bold,
                                  color: Color(getColourHexFromString(primaryDarkGrey)),
                                ),
                                focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: Color(getColourHexFromString(primaryBlue))),
                                ),
                              ),
                              obscureText: true,
                              validator: (value) => value.isEmpty ? 'Password required' : null,
                              onSaved: (value) => _password = value,
                            ),
                            addSizedBoxPadding(16.0, 0),
                            Container(
                              height: 40.0,
                              child: Material(
                                borderRadius: BorderRadius.circular(20.0),
                                shadowColor: Color(getColourHexFromString(primaryDarkGrey)),
                                color: Color(getColourHexFromString(primaryBlue)),
                                elevation: 0.65,
                                child: GestureDetector(
                                  onTap: validateAndSubmit,
                                  behavior:  HitTestBehavior.deferToChild,
                                  child: Center(
                                    child: Text(
                                      'LOGIN',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontFamily: stdFontFamily,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),

        ],
      ),
    );




    /*return SingleChildScrollView(
      child:ConstrainedBox(
        constraints: BoxConstraints(
          minHeight: MediaQuery.of(context).size.height,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              child: Stack(
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.fromLTRB(16.0, 110.0, 0.0, 0.0),
                    child: Text(
                        "Hello",
                        style: TextStyle(
                          fontSize: 80.0,
                          fontWeight: FontWeight.bold,
                          color: Color(getColourHexFromString(primaryBlack)),
                        )
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.fromLTRB(16.0, 175.0, 0.0, 0.0),
                    child: Text(
                        "There",
                        style: TextStyle(
                          fontSize: 80.0,
                          fontWeight: FontWeight.bold,
                          color: Color(getColourHexFromString(primaryBlack)),
                        )
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.fromLTRB(225.0, 175.0, 0.0, 0.0),
                    child: Text(
                        ".",
                        style: TextStyle(
                          fontSize: 80.0,
                          fontWeight: FontWeight.bold,
                          color: Color(getColourHexFromString(primaryBlue)),
                        )
                    ),
                  ),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.only(top: 35.0, left: 20.0, right: 20.0),
              child: Column(
                children: <Widget>[
                  Container(
                    child:SingleChildScrollView(
                      child: ConstrainedBox(
                        constraints: BoxConstraints(),
                        child: Form(
                          //  Set the form key:
                          key: formKey,
                          child: Column(
                            //  Require all children to fill the cross axis
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: <Widget>[
                              TextFormField(
                                decoration: InputDecoration(
                                  labelText: 'USERNAME',
                                  labelStyle: TextStyle(
                                    fontFamily: stdFontFamily,
                                    fontWeight: FontWeight.bold,
                                    color: Color(getColourHexFromString(primaryDarkGrey)),
                                  ),
                                  focusedBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(color: Color(getColourHexFromString(primaryBlue))),
                                  ),
                                ),
                                validator: validateUsername,
                                onSaved: (value) => _username = value,
                              ),
                              //  add some padding
                              addSizedBoxPadding(16.0, 0),
                              TextFormField(
                                decoration: InputDecoration(
                                  labelText: 'PASSWORD',
                                  labelStyle: TextStyle(
                                    fontFamily: stdFontFamily,
                                    fontWeight: FontWeight.bold,
                                    color: Color(getColourHexFromString(primaryDarkGrey)),
                                  ),
                                  focusedBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(color: Color(getColourHexFromString(primaryBlue))),
                                  ),
                                ),
                                obscureText: true,
                                validator: (value) => value.isEmpty ? 'Password required' : null,
                                onSaved: (value) => _password = value,
                              ),
                              addSizedBoxPadding(16.0, 0),
                              RaisedButton(
                                child: Text(
                                    'Sumbit',
                                    style: TextStyle(fontSize: 20.0)
                                ),
                                onPressed: validateAndSubmit,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );*/



    /*return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            child: Stack(
              children: <Widget>[
                Container(
                  padding: EdgeInsets.fromLTRB(16.0, 110.0, 0.0, 0.0),
                  child: Text(
                      "Hello",
                      style: TextStyle(
                        fontSize: 80.0,
                        fontWeight: FontWeight.bold,
                        color: Color(getColourHexFromString(primaryBlack)),
                      )
                  ),
                ),
                Container(
                  padding: EdgeInsets.fromLTRB(16.0, 175.0, 0.0, 0.0),
                  child: Text(
                      "There",
                      style: TextStyle(
                        fontSize: 80.0,
                        fontWeight: FontWeight.bold,
                        color: Color(getColourHexFromString(primaryBlack)),
                      )
                  ),
                ),
                Container(
                  padding: EdgeInsets.fromLTRB(225.0, 175.0, 0.0, 0.0),
                  child: Text(
                      ".",
                      style: TextStyle(
                        fontSize: 80.0,
                        fontWeight: FontWeight.bold,
                        color: Color(getColourHexFromString(primaryBlue)),
                      )
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.only(top: 35.0, left: 20.0, right: 20.0),
            child: Column(
              children: <Widget>[
                Container(
                  child:SingleChildScrollView(
                    child: ConstrainedBox(
                      constraints: BoxConstraints(),
                      child: Form(
                        //  Set the form key:
                        key: formKey,
                        child: Column(
                          //  Require all children to fill the cross axis
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: <Widget>[
                            TextFormField(
                              decoration: InputDecoration(
                                  labelText: 'USERNAME',
                                labelStyle: TextStyle(
                                  fontFamily: stdFontFamily,
                                  fontWeight: FontWeight.bold,
                                  color: Color(getColourHexFromString(primaryDarkGrey)),
                                ),
                                focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: Color(getColourHexFromString(primaryBlue))),
                                ),
                              ),
                              validator: validateUsername,
                              onSaved: (value) => _username = value,
                            ),
                            //  add some padding
                            addSizedBoxPadding(16.0, 0),
                            TextFormField(
                              decoration: InputDecoration(
                                labelText: 'PASSWORD',
                                labelStyle: TextStyle(
                                  fontFamily: stdFontFamily,
                                  fontWeight: FontWeight.bold,
                                  color: Color(getColourHexFromString(primaryDarkGrey)),
                                ),
                                focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: Color(getColourHexFromString(primaryBlue))),
                                ),
                              ),
                              obscureText: true,
                              validator: (value) => value.isEmpty ? 'Password required' : null,
                              onSaved: (value) => _password = value,
                            ),
                            addSizedBoxPadding(16.0, 0),
                            RaisedButton(
                              child: Text(
                                  'Sumbit',
                                  style: TextStyle(fontSize: 20.0)
                              ),
                              onPressed: validateAndSubmit,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );*/
  }
}
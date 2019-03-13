import 'package:flutter/material.dart';
import 'package:weplayball/pages/register.dart';
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
  var formHasErrors = false;
  var loading = false;


  bool validateAndSave() {
    final form = formKey.currentState;
    if (form.validate()) {
      form.save();
      return true;
    }
    return false;
  }

  void validateAndSubmit() async {
    _resetLoginError();
    _showLoader();
    if (validateAndSave()) {
      try {

        var auth = AuthProvider.of(context).auth;
        var user = await auth.requestLoginAPI(_username, _password);

        if(user.statusCode == 200)
          {
            print('Signed in as: ${user.body.userName}');
            widget.onSignedIn();
          }
          else if(user.statusCode == 404)
          {
            _resetLoader();
            _showLoginError();
          }
           else{
          _resetLoader();
          _showLoginError();
        }
      } catch (e) {
        print('Error: $e');
      }
    }
  }

  void GoToRegister(BuildContext context){
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => RegisterPage(onSignedIn: widget.onSignedIn)),
    );
  }

  void _showLoginError(){
    setState(() {
      formHasErrors = true;
    });
  }

  void _resetLoginError(){
    setState(() {
      formHasErrors = false;
    });
  }

  void _showLoader(){
    setState(() {
      loading = true;
    });
  }

  void _resetLoader(){
    setState(() {
      loading = false;
    });
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
                  child: SingleChildScrollView(
                    child: ConstrainedBox(
                      constraints: BoxConstraints(),
                      child: Form(
                        //  Set the form key:
                        key: formKey,
                        child: Column(
                          //  Require all children to fill the cross axis
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: <Widget>[
                            //  Username field
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
                            addSizedBoxPadding(12.0, 0),

                            //  Password field
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
                            addSizedBoxPadding(12.0, 0),


                            // Login button
                            Container(
                              height: 50.0,
                              child: RaisedButton(
                                elevation: 3.0,
                                padding: const EdgeInsets.all(12.0),
                                textColor: Colors.white,
                                child: Text("LOGIN",
                                  style: TextStyle(
                                    fontWeight: FontWeight.w400,
                                    fontSize: fontSizeH3,
                                  ),
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: stdButtonBorderRadius,
                                ),
                                color: Color(getColourHexFromString(primaryBlue)),
                                onPressed: validateAndSubmit,
                              ),
                            ),

                            //  Register link
                            //addSizedBoxPadding(6.0, 0),
                            Container(
                              alignment: Alignment(1.0, 0.0),
                              padding: EdgeInsets.only(top: 15.0, left: 20.0),
                              child: InkWell(
                                onTap: () => GoToRegister(context),
                                child: Text(
                                  'Register',
                                  style: TextStyle(
                                      color: Color(getColourHexFromString(primaryBlue)),
                                      fontWeight: FontWeight.bold,
                                      decoration: TextDecoration.underline,
                                      fontSize: fontSizeH4,
                                      letterSpacing: 0.5,
                                  ),
                                ),
                              ),
                            ),

                            // Show error if any
                            addSizedBoxPadding(12.0, 0),
                            Container(
                              child: formHasErrors ?
                              Center(
                                child: Text(
                                  'Username or password was incorrect.',
                                  style: TextStyle(
                                    color: Colors.red,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: stdFontFamily,
                                    fontSize: fontSizeH4,
                                  ),
                                ),
                              ) :
                              Center(),
                            ),

                            //  Loading
                            addSizedBoxPadding(16.0, 0),
                            Center(
                              child: loading? new CircularProgressIndicator()
                              : Center(),
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

  }
}
import 'package:flutter/material.dart';
import 'package:weplayball/pages/login.dart';
import 'package:weplayball/service/auth/auth_provider.dart';
import 'package:weplayball/ui/colors.dart';
import 'package:weplayball/ui/layout.dart';

class RegisterPage extends StatefulWidget
{
  RegisterPage({this.onSignedIn});
  //  our required method for StatefulWidgets
  //  return a new _LoginPageState
  @override
  State<StatefulWidget> createState() => new _RegisterPageState();
  final VoidCallback onSignedIn;
}

class _RegisterPageState extends State<RegisterPage>{

  //  Note: This is a `GlobalKey<FormState>`, not a GlobalKey<MyCustomFormState>
  final formKey = new GlobalKey<FormState>();

  String _username;
  String _password;
  String _confirmPassword;
  String _email;
  String _firstname;
  var passwordKey = GlobalKey<FormFieldState>();
  var _userNameMinLength = 5;
  var _firstNameMinLength = 3;
  var passwordMinLength = 7;
  String _errorMessage = "";

  var formHasErrors = false;
  var loading = false;

  void _showRegisterError(String errorMessage){
    setState(() {
      _errorMessage = errorMessage;
      formHasErrors = true;
    });
  }

  void _resetRegisterError(){
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
      _errorMessage = "";
    });
  }


  bool validateAndSave(){
    //  Get a form from the key
    final form = formKey.currentState;

    if(form.validate()){
      form.save();
      //print('Form is valid. Username: $_username Firstname: $_firstname Email:$_email Password: $_password Confirm password: $_confirmPassword');
      return true;
    }else{
      //print('Form is invalid.  Username: $_username Firstname: $_firstname Email:$_email Password: $_password Confirm password: $_confirmPassword');
      return false;
    }
  }

  void validateAndSubmit() async {
    _resetRegisterError();
    if(validateAndSave()){
      _showLoader();
      try{
        var auth = AuthProvider.of(context).auth;
        var user = await auth.registerUser(_username, _password, _email, _firstname);

        if(user.statusCode == 200)
        {
          print('Signed in as: ${user.body.userName}');
          widget.onSignedIn();
        }else if(user.statusCode == 404){
          _resetLoader();
          _showRegisterError(user.body.errorMessage);
        }else{
          _resetLoader();
          _showRegisterError(user.body.errorMessage);
        }
      }catch (e) {
        print('Error: $e');
      }
    }
  }

  void GoToLogin(BuildContext context){
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => LoginPage()),
    );
  }

  String validateEmail(String value) {
    Pattern pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = new RegExp(pattern);
    if (!regex.hasMatch(value))
      return 'Enter Valid Email';
    else
      return null;
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

  String validateFirstname(String value){
    return validateName(value, _firstNameMinLength, "Firstname");
  }

  String validatePassword(String value){
    return validateName(value, passwordMinLength, "Password");
  }

  @override
  Widget build(BuildContext context) {
    /*return new Scaffold(
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
                  padding: EdgeInsets.fromLTRB(220.0, 175.0, 0.0, 0.0),
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
                            TextFormField(
                              decoration: InputDecoration(
                                labelText: 'USERNAME',
                                labelStyle: TextStyle(
                                  fontFamily: stdFontFamily,
                                  fontWeight: FontWeight.bold,
                                  fontSize: fontSizeH4,
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
                            TextFormField(
                              decoration: InputDecoration(
                                labelText: 'FIRST NAME',
                                labelStyle: TextStyle(
                                  fontFamily: stdFontFamily,
                                  fontWeight: FontWeight.bold,
                                  fontSize: fontSizeH4,
                                  color: Color(getColourHexFromString(primaryDarkGrey)),
                                ),
                                focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: Color(getColourHexFromString(primaryBlue))),
                                ),
                              ),
                              validator: validateFirstname,
                              onSaved: (value) => _firstname = value,
                            ),
                            //  add some padding
                            addSizedBoxPadding(12.0, 0),
                            TextFormField(
                              decoration: InputDecoration(
                                labelText: 'EMAIL',
                                  labelStyle: TextStyle(
                                    fontFamily: stdFontFamily,
                                    fontWeight: FontWeight.bold,
                                    fontSize: fontSizeH4,
                                    color: Color(getColourHexFromString(primaryDarkGrey)),
                                  ),
                                  focusedBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(color: Color(getColourHexFromString(primaryBlue))),
                                  )
                              ),
                              keyboardType: TextInputType.emailAddress,
                              validator: validateEmail,
                              onSaved: (value) => _email = value,
                            ),
                            //  add some padding
                            addSizedBoxPadding(12.0, 0),
                            TextFormField(
                              key: passwordKey,
                              decoration: InputDecoration(
                                labelText: 'PASSWORD',
                                  labelStyle: TextStyle(
                                    fontFamily: stdFontFamily,
                                    fontWeight: FontWeight.bold,
                                    fontSize: fontSizeH4,
                                    color: Color(getColourHexFromString(primaryDarkGrey)),
                                  ),
                                  focusedBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(color: Color(getColourHexFromString(primaryBlue))),
                                  )
                              ),
                              obscureText: true,
                              validator: (value) => value.isEmpty ? 'Password required' : null,
                              onSaved: (value) => _password = value,
                            ),
                            //  add some padding
                            addSizedBoxPadding(12.0, 0),
                            TextFormField(
                              decoration: InputDecoration(
                                labelText: 'CONFIRM PASSWORD',
                                  labelStyle: TextStyle(
                                    fontFamily: stdFontFamily,
                                    fontWeight: FontWeight.bold,
                                    fontSize: fontSizeH4,
                                    color: Color(getColourHexFromString(primaryDarkGrey)),
                                  ),
                                  focusedBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(color: Color(getColourHexFromString(primaryBlue))),
                                  )
                              ),
                              obscureText: true,
                              validator: (confirmation){
                                var password = passwordKey.currentState.value;
                                return (confirmation.toString()== password.toString()) ? null : "Confirm password and password must match";
                              },
                              onSaved: (value) => _confirmPassword = value,
                            ),
                            //  add some padding
                            addSizedBoxPadding(12.0, 0),

                            Container(
                              alignment: Alignment(1.0, 0.0),
                              padding: EdgeInsets.only(top: 15.0, left: 20.0),
                              child: InkWell(
                                onTap: () => GoToLogin(context),
                                child: Text(
                                  'Already have an account?',
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
      )
    );*/

    return Scaffold(
      resizeToAvoidBottomPadding: true,
      body: SingleChildScrollView(
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
                    padding: EdgeInsets.fromLTRB(220.0, 175.0, 0.0, 0.0),
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
                  Form(
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
                              fontSize: fontSizeH4,
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
                        TextFormField(
                          decoration: InputDecoration(
                            labelText: 'FIRST NAME',
                            labelStyle: TextStyle(
                              fontFamily: stdFontFamily,
                              fontWeight: FontWeight.bold,
                              fontSize: fontSizeH4,
                              color: Color(getColourHexFromString(primaryDarkGrey)),
                            ),
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Color(getColourHexFromString(primaryBlue))),
                            ),
                          ),
                          validator: validateFirstname,
                          onSaved: (value) => _firstname = value,
                        ),
                        //  add some padding
                        addSizedBoxPadding(12.0, 0),
                        TextFormField(
                          decoration: InputDecoration(
                              labelText: 'EMAIL',
                              labelStyle: TextStyle(
                                fontFamily: stdFontFamily,
                                fontWeight: FontWeight.bold,
                                fontSize: fontSizeH4,
                                color: Color(getColourHexFromString(primaryDarkGrey)),
                              ),
                              focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Color(getColourHexFromString(primaryBlue))),
                              )
                          ),
                          keyboardType: TextInputType.emailAddress,
                          validator: validateEmail,
                          onSaved: (value) => _email = value,
                        ),
                        //  add some padding
                        addSizedBoxPadding(12.0, 0),
                        TextFormField(
                          key: passwordKey,
                          decoration: InputDecoration(
                              labelText: 'PASSWORD',
                              labelStyle: TextStyle(
                                fontFamily: stdFontFamily,
                                fontWeight: FontWeight.bold,
                                fontSize: fontSizeH4,
                                color: Color(getColourHexFromString(primaryDarkGrey)),
                              ),
                              focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Color(getColourHexFromString(primaryBlue))),
                              )
                          ),
                          obscureText: true,
                          validator: (value) => value.isEmpty ? 'Password required' : null,
                          onSaved: (value) => _password = value,
                        ),
                        //  add some padding
                        addSizedBoxPadding(12.0, 0),
                        TextFormField(
                          decoration: InputDecoration(
                              labelText: 'CONFIRM PASSWORD',
                              labelStyle: TextStyle(
                                fontFamily: stdFontFamily,
                                fontWeight: FontWeight.bold,
                                fontSize: fontSizeH4,
                                color: Color(getColourHexFromString(primaryDarkGrey)),
                              ),
                              focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Color(getColourHexFromString(primaryBlue))),
                              )
                          ),
                          obscureText: true,
                          validator: (confirmation){
                            var password = passwordKey.currentState.value;
                            return (confirmation.toString()== password.toString()) ? null : "Confirm password and password must match";
                          },
                          onSaved: (value) => _confirmPassword = value,
                        ),
                        //  add some padding
                        addSizedBoxPadding(12.0, 0),

                        //  Loading
                        addSizedBoxPadding(12.0, 0),
                        Center(
                          child: loading? new CircularProgressIndicator()
                              : Center(),
                        ),

                        addSizedBoxPadding(12.0, 0),
                        // Login button
                        Container(
                          height: 50.0,
                          child: RaisedButton(
                            elevation: 3.0,
                            padding: const EdgeInsets.all(12.0),
                            textColor: Colors.white,
                            child: Text("SUBMIT",
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

                        //  add some padding
                        addSizedBoxPadding(12.0, 0),
                        Container(
                          alignment: Alignment(1.0, 0.0),
                          padding: EdgeInsets.only(top: 10.0, left: 20.0),
                          child: InkWell(
                            onTap: () => GoToLogin(context),
                            child: Text(
                              'Already have an account?',
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
                              _errorMessage,
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


                        //  add some padding
                        //  Key
                        addSizedBoxPadding(36.0, 0),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
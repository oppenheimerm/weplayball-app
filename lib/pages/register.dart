import 'package:flutter/material.dart';

class RegisterPage extends StatefulWidget
{
  //  our required method for StatefulWidgets
  //  return a new _LoginPageState
  @override
  State<StatefulWidget> createState() => new _RegisterPageState();
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
  var passowrdMinLength = 7;


  bool validateAndSave(){
    //  Get a form from the key
    final form = formKey.currentState;

    if(form.validate()){
      form.save();
      print('Form is valid. Username: $_username Firstname: $_firstname Email:$_email Password: $_password Confirm password: $_confirmPassword');
      return true;
    }else{
      print('Form is invalid.  Username: $_username Firstname: $_firstname Email:$_email Password: $_password Confirm password: $_confirmPassword');
      return false;
    }
  }


  void validateAndSubmit() async {
    if(validateAndSave()){
      print('Form ready for submission');
    }
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
    return validateName(value, passowrdMinLength, "Password");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: Text('Register page')
        ),
        body: Container(
          padding: EdgeInsets.all(16.0),
          //  It is the form itself that is responsible for validating the status
          //  or the state of it's children
          child: new SingleChildScrollView(
            child: ConstrainedBox(
              constraints: BoxConstraints(),
              child: Form(
                //  Set the form key:
                key: formKey,
                child: Column(
                  //  Require all children to fill the cros axis
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    TextFormField(
                      decoration: InputDecoration(
                          labelText: 'Username'
                      ),
                      validator: validateUsername,
                      onSaved: (value) => _username = value,
                    ),
                    TextFormField(
                      decoration: InputDecoration(
                        labelText: 'Firstname',
                      ),
                      validator: validateFirstname,
                      onSaved: (value) => _firstname = value,
                    ),
                    TextFormField(
                      decoration: InputDecoration(
                        labelText: 'Email',
                      ),
                      keyboardType: TextInputType.emailAddress,
                      validator: validateEmail,
                      onSaved: (value) => _email = value,
                    ),
                    TextFormField(
                      key: passwordKey,
                      decoration: InputDecoration(
                        labelText: 'Password',
                      ),
                      obscureText: true,
                      validator: (value) => value.isEmpty ? 'Password required' : null,
                      onSaved: (value) => _password = value,
                    ),
                    TextFormField(
                      decoration: InputDecoration(
                        labelText: 'Confirm Password',
                      ),
                      obscureText: true,
                      validator: (confirmation){
                        var password = passwordKey.currentState.value;
                        return (confirmation.toString()== password.toString()) ? null : "Confirm password and password must match";
                      },
                      onSaved: (value) => _confirmPassword = value,
                    ),
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
        )
    );
  }
}
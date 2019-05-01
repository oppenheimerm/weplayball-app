import 'package:flutter/material.dart';
import 'package:weplayball/service/auth/Auth.dart';
import 'package:weplayball/service/authenticationStatus.dart';


class User {
  String firstName;
  String lastName;
  String email;

  User(this.firstName, this.lastName, this.email);
}

//  Our InheritedWidget works as store by connecting to an StatefulWidget. So your
//  StateContainer is really three classes:
//    class StateContainer extends StatefulWidget
//    class StateContainerState extends State<StateContainer>
//    class _InheritedStateContainer extends InheritedWidget

//  Once the StateContainer is set up it doesn’t change.
class StateContainer extends StatefulWidget {
  @override
  StateContainerState createState() => new StateContainerState();


  // You must pass through a child.
  final Widget child;
  final BaseAuth auth;

  StateContainer({
    @required this.child,
    this.auth,
  });


  //  Note the use of the ‘of’ method
  //  See: https://docs.flutter.io/flutter/widgets/BuildContext/inheritFromWidgetOfExactType.html
  //
  //  This is the secret sauce. Write your own 'of' method that will behave exactly like
  //  'MediaQuery.of' and 'Theme.of'.  It basically says 'get the data from the widget
  //  of this type.
  //
  //  NOTE: The ‘of’ method should really never do anything else.
  //  In fact those two classes can just be left alone forever.
  static StateContainerState of(BuildContext context) {
    return (context.inheritFromWidgetOfExactType(_InheritedStateContainer) as _InheritedStateContainer).auth;
  }

}


//  This Widget is where all your state and logic lives. Here is where we will be
//  able to manipulate our user data / state;
class StateContainerState extends State<StateContainer> {

  //  init page
  AuthStatus authStatus = AuthStatus.notDetermined;

  //  Called when a dependency of this State object changes
  //  see: https://docs.flutter.io/flutter/widgets/SingleTickerProviderStateMixin/didChangeDependencies.html
  @override
  void didChangeDependencies() async {
    super.didChangeDependencies();
    var auth = StateContainer.of(context).auth;
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


  /*void updateUserInfo({firstName, lastName, email}) {
    if (user == null) {
      user = new User(firstName, lastName, email);
      setState(() {
        user = user;
      });
    } else {
      setState(() {
        user.firstName = firstName ?? user.firstName;
        user.lastName = lastName ?? user.lastName;
        user.email = email ?? user.email;
      });
    }
  }*/

  @override
  Widget build(BuildContext context) {
    return new _InheritedStateContainer(
      auth: this,
      child: widget.child,
    );
  }
}

//  Like the StateContainer,  once it's set up it doesn’t change.
//  Equivalent to AuthProvider in auth_provider.dart
class _InheritedStateContainer extends InheritedWidget {
  //  Data is your entire state. In our case just UserModel 'user'
  //final StateContainerState data;
  final BaseAuth auth;

  // You must pass through a child and your state.
  _InheritedStateContainer({
    Key key,
    @required this.auth,
    @required Widget child,
  }) : super(key: key, child: child);

  // This is a built in method which you can use to check, if any state
  // has changed. If no : no reason to rebuild all the widgets that rely
  // on your state.
  @override
  bool updateShouldNotify(_InheritedStateContainer old) => true;
}

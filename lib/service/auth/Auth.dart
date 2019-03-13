import 'dart:async';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:weplayball/models/user.dart';
import 'package:weplayball/models/login.dart';
import 'package:weplayball/service/authenticationStatus.dart';
import 'package:weplayball/service/saveCurrentLogin.dart';
import 'package:weplayball/service/response/parsedResponse.dart';

final int NO_INTERNET = 404;

abstract class BaseAuth {
  Future<ParsedResponse<UserModel>> requestLoginAPI(String username, String password);
  Future<UserModel> currentUser();
  Future<void> signOut();
}

class Auth implements BaseAuth {

  Future<ParsedResponse<UserModel>> requestLoginAPI(String username, String password) async {

    final url = "https://weplayball.azurewebsites.net/api/token/authenticate";

    var body = json.encode({
      'username': username,
      'password': password,
    });

    final response = await http.post(
        Uri.encodeFull(url),
        body: body,
        headers: {'accept' : 'application/json','content-type':'application/json'}
    );

    if (response == null) {
      return new ParsedResponse(NO_INTERNET, new UserModel("", "", "", "", "", AuthStatus.notSignedIn));
    }

    if (response.statusCode == 200) {
      final responseJson = json.decode(response.body);
      var userData = new LoginModel.fromJson(responseJson);
      await saveCurrentLogin(responseJson);

      var user = new UserModel(
          userData.userName,
          userData.token,
          userData.firstName,
          userData.email,
          userData.userId,
          AuthStatus.signedIn);

      return new ParsedResponse(response.statusCode, user);

      //  return a user model
      //return user;
    }/*else if(response.statusCode == 400){
      //  Username or password was incorrect

    }*/
    else {

      //  response will always be null if it is a error code: i.e. status 415
      //  We really need to catch all the types of responses and create a
      //  switch case and notify user of error.  For now just return null

      return new ParsedResponse(NO_INTERNET, new UserModel("", "", "", "", "", AuthStatus.notSignedIn));
      //return null;
    }
  }

  Future<UserModel> currentUser() async {
    //  Shared Preferences — How to save Flutter application settings and user preferences for later re-use?
    //  https://medium.com/flutter-community/shared-preferences-how-to-save-flutter-application-settings-and-user-preferences-for-later-554d08671ae9
    var sharedPreferences = await SharedPreferences.getInstance();
    var user = new UserModel(
      sharedPreferences.getString("LastUserName"),
      sharedPreferences.getString("LastToken"),
      sharedPreferences.getString("LastFirstName"),
      sharedPreferences.getString("LastEmail"),
      sharedPreferences.getString("LastUserId"),
      getStatus(sharedPreferences.getString("AuthStatus")),

      //sharedPreferences.getString("")   //preferences.setString("AuthStatus", "notSignedIn");
    );
    return user;
  }

  //  We're using jwt tokens, which is stateless, we just need to remove the
  //  stored token and clear all settings
  Future<void> signOut() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();

    await preferences.setString("LastUserName", null);
    await preferences.setString("LastToken", null);
    await preferences.setString("LastFirstName", null);
    await preferences.setString("LastEmail", null);
    await preferences.setString("LastUserId", null);
    await preferences.setString("AuthStatus", authStatusToString(AuthStatus.notSignedIn));

    print("SignOut() called!");
  }
}
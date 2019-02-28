import 'package:shared_preferences/shared_preferences.dart';
import 'package:weplayball/models/login.dart';
import 'package:weplayball/service/authenticationStatus.dart';

saveCurrentLogin(Map responseJson) async {
  SharedPreferences preferences = await SharedPreferences.getInstance();

  var token = (LoginModel.fromJson(responseJson).token != null) ? LoginModel.fromJson(responseJson).token : "";
  var email = (LoginModel.fromJson(responseJson).email != null) ? LoginModel.fromJson(responseJson).email : "";
  var userId = (LoginModel.fromJson(responseJson).userId != null) ? LoginModel.fromJson(responseJson).userId : "";
  var firstName = (LoginModel.fromJson(responseJson).firstName != null) ? LoginModel.fromJson(responseJson).firstName : "";
  var userName = (LoginModel.fromJson(responseJson).userName != null) ? LoginModel.fromJson(responseJson).userName : "";


  await preferences.setString("LastUserName", userName);
  await preferences.setString("LastToken", token);
  await preferences.setString("LastFirstName", firstName);
  await preferences.setString("LastEmail", email);
  await preferences.setString("LastUserId", userId);
  await preferences.setString("AuthStatus", authStatusToString(AuthStatus.signedIn));
}
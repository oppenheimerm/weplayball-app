//  An instance of an authenticated user
import 'package:weplayball/service/authenticationStatus.dart';

class UserModel {
  String userName;
  String token;
  String firstName;
  String email;
  String userId;
  AuthStatus authStatus;
  String errorMessage;

  UserModel(this.userName, this.token, this.firstName, this.email, this.userId, this.authStatus, {this.errorMessage});

}
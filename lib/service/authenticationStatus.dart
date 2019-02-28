enum AuthStatus {
  notDetermined,
  notSignedIn,
  signedIn,
}

AuthStatus getStatus(String authStatus)
{
  var status = AuthStatus.notDetermined;

  switch(authStatus)
  {
    case 'notDetermined':
      status = AuthStatus.notDetermined;
      break;
    case 'notSignedIn':
      status = AuthStatus.signedIn;
      break;
    case 'signedIn':
      status = AuthStatus.signedIn;
      break;
  }

  return status;
}

String authStatusToString(AuthStatus authStatus)
{
  String status = "notDetermined";

  switch(authStatus)
  {
    case AuthStatus.notDetermined:
      status = "notDetermined";
      break;
    case AuthStatus.notSignedIn:
      status = "notSignedIn";
      break;
    case AuthStatus.signedIn:
      status = "signedIn";
      break;
  }

  return status;
}
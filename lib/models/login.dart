class LoginModel {
  final String userName;
  final String token;
  final String firstName;
  final String email;
  final String userId;

  LoginModel(this.userName, this.token, this.firstName, this.email, this.userId);

  LoginModel.fromJson(Map<String, dynamic> json)
      : userName = json['username'],
        token = json['token'],
        email = json['email'],
        firstName = json['firstName'],
        userId = json['id'];

  Map<String, dynamic> toJson() =>
      {
        'name': userName,
        'token': token,
        'email': email,
        'firstName': firstName,
        'id': userId,
      };
}
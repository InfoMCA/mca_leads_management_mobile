class AuthUserModel {
  final String username;
  final String? email;

  AuthUserModel({required this.username, this.email});

  factory AuthUserModel.fromJson(dynamic json) {
    return AuthUserModel(
      username: json['username'],
      email: json['email'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'username': username,
      'email': email,
    };
  }
}
class AuthUserModel {
  final String username;
  final String? email;
  final String? dealerId;

  AuthUserModel({required this.username, this.email, this.dealerId});

  factory AuthUserModel.fromJson(dynamic json) {
    return AuthUserModel(
      username: json['username'],
      email: json['email'],
      dealerId: json['dealerId']
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'username': username,
      'email': email,
      'dealerId': dealerId
    };
  }
}
import 'package:firebase_auth/firebase_auth.dart';

class AuthModel {
  final String? name;
  final String? email;
  final String? photo;
  final String? token;

  AuthModel({this.name, this.email, this.photo, this.token});

  factory AuthModel.fromUserCredintials(UserCredential user) {
    return AuthModel(
      name: user.user!.displayName,
      email: user.user!.email,
      photo: user.user!.photoURL,
      token: user.credential!.accessToken,
    );
  }

  Map<String, dynamic> toMap() {
    return {'name': name, 'email': email, 'photo': photo, 'token': token};
  }
}

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:ecomerceapp/User/repository/firebase_auth_api.dart';

class Auth_Repository {
  final _firebaseAuthAPI = FirebaseAuthAPI();

  Future<FirebaseUser> signInGoogle() => _firebaseAuthAPI.signInGoogle();

  signOut() => _firebaseAuthAPI.sign_Out();

  void signInEmail(String email, String password, BuildContext context) =>
      _firebaseAuthAPI.signInEmail(email, password, context);

  Future<FirebaseUser> signUpWithEmailPassword(
          name, email, password, context) =>
      _firebaseAuthAPI.signUpWithEmailPassword(name, email, password, context);
}

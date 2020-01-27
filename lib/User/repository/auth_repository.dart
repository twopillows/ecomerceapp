import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:ecomerceapp/User/repository/firebase_auth_api.dart';

class Auth_Repository {
  final _firebaseAuthAPI = FirebaseAuthAPI();

  Future<FirebaseUser> signInFirebase() => _firebaseAuthAPI.signIn();

  signOut() => _firebaseAuthAPI.sign_Out();

  void handleSignInEmail(String email, String password, BuildContext context) =>
      _firebaseAuthAPI.handleSignInEmail(email, password, context);

  Future<FirebaseUser> signUpWithEmailPassword(email, password) =>
      _firebaseAuthAPI.signUpWithEmailPassword(email, password);
}

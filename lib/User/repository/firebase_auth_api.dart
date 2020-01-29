import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:ecomerceapp/tienda_principal_cupertino.dart';

class FirebaseAuthAPI {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn googleSignIn = GoogleSignIn();
  final Firestore _firestore = Firestore.instance;

  ///LOGIN, SIGNUP, SIGNOUT, UPDATE DATA
  Future<FirebaseUser> signInGoogle() async {
    GoogleSignInAccount googleSignInAccount = await googleSignIn.signIn();
    GoogleSignInAuthentication gSA = await googleSignInAccount.authentication;

    FirebaseUser user = await _auth.signInWithCredential(
        GoogleAuthProvider.getCredential(
            idToken: gSA.idToken, accessToken: gSA.accessToken));

    return user;
  }

  void signInEmail(String email, String password, BuildContext context) {
    _auth
        .signInWithEmailAndPassword(email: email, password: password)
        .then((currentUser) {
      print(currentUser.uid.toString());
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (context) => TiendaPrincipalCupertino(
                    uid: currentUser.uid,
                  )));
    });
  }

  Future<FirebaseUser> signUpWithEmailPassword(
      String name, String email, String password, BuildContext context) async {
    await _auth
        .createUserWithEmailAndPassword(
      email: email,
      password: password,
    )
        .then((result) {
      _firestore.collection('users').document(result.uid).setData({
        'email': email,
        'uid': result.uid,
        'name': name,
      });

      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (context) => TiendaPrincipalCupertino(
                    uid: result.uid,
                  )));
    });
  }

  sign_Out() async {
    await _auth.signOut().then((onValue) => print("el usuario cerro secion"));
    googleSignIn.signOut();
    print("tambien de google cerro la secion");
  }
}

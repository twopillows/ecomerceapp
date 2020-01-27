import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:ecomerceapp/tienda_principal_cupertino.dart';

class FirebaseAuthAPI {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn googleSignIn = GoogleSignIn();
  final Firestore _firestore = Firestore.instance;

  Future<FirebaseUser> signIn() async {
    GoogleSignInAccount googleSignInAccount = await googleSignIn.signIn();
    GoogleSignInAuthentication gSA = await googleSignInAccount.authentication;

    FirebaseUser user = await _auth.signInWithCredential(
        GoogleAuthProvider.getCredential(
            idToken: gSA.idToken, accessToken: gSA.accessToken));

    return user;
  }

  ///aqui tngo q hacer el login con email and password
  void handleSignInEmail(String email, String password, BuildContext context) {
    _auth
        .signInWithEmailAndPassword(email: email, password: password)
        .then((currentUser) => _firestore
            .collection("users")
            .document(currentUser.uid)
            .get()
            .then((DocumentSnapshot result) => Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                    builder: (context) => TiendaPrincipalCupertino(
                          uid: currentUser.uid,
                        ))))
            .catchError((err) => print(err)))
        .catchError((err) => print(err));
  }

  ///aqui para registrar al usuario con wemail y contrasenna
  Future<FirebaseUser> signUpWithEmailPassword(email, password) async {
    /*DocumentReference ref = _firestore.collection("users").document(user.uid);


    _auth.createUserWithEmailAndPassword(email: email, password: password)
        .then((currentUser) => {
          _firestore
      .collection("users")
      .document(currentUser.uid)
      .setData(data)
    });*/
  }

  /*try {
      FirebaseUser user = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      assert(user != null);
      assert(await user.getIdToken() != null);
      return user;
    } catch (e) {
      print(e);
      return null;
    }*/

  /*Future<FirebaseUser> handleSignUp(email, password) async {

    AuthResult result = await auth.createUserWithEmailAndPassword(email: email, password: password);
    final FirebaseUser user = result.user;

    assert (user != null);
    assert (await user.getIdToken() != null);

    return user;

  }*/

  sign_Out() async {
    await _auth.signOut().then((onValue) => print("el usuario cerro secion"));
    googleSignIn.signOut();
    print("tambien de google cerro la secion");
  }
}

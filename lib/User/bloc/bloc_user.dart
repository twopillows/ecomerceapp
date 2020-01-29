import 'dart:async';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:generic_bloc_provider/generic_bloc_provider.dart';
import 'package:ecomerceapp/Product/model/product.dart';
import 'package:ecomerceapp/Product/repository/firebase_storage_repository.dart';
import 'package:ecomerceapp/User/model/user.dart';
import 'package:ecomerceapp/User/repository/auth_repository.dart';
import 'package:ecomerceapp/User/repository/cloud_firestore_repository.dart';

class UserBloc implements Bloc {
  final _auth_repository = Auth_Repository();
  final _cloud_firestore_repository = CloudFirestoreRepository();
  final _firebase_storage_repository = FirebaseStorageRepository();

  Future<FirebaseUser> get currentUser => FirebaseAuth.instance.currentUser();

  //////////////////////////////////
  ///Firebase Streams
  Stream<FirebaseUser> get authStatusFirebase =>
      FirebaseAuth.instance.onAuthStateChanged;

  Stream<DocumentSnapshot> get currentUserStream => Firestore.instance
      .collection('users')
      .document(
          //name)
          'CP3iWB9nFFS3OaUsSbsxOZU38Hz2') // aqui va el nombre del usuario actual
      .snapshots();

  ////////////////////////////////////////
  ///LOGIN, SIGNUP, SIGNOUT, UPDATE DATA
  signInEmail(String email, String password, BuildContext context) =>
      _auth_repository.signInEmail(email, password, context);

  Future<FirebaseUser> signInGoogle() => _auth_repository.signInGoogle();

  Future<FirebaseUser> signUpWithEmailPassword(
          name, email, password, context) =>
      _auth_repository.signUpWithEmailPassword(name, email, password, context);

  signOut() => _auth_repository.signOut();

  updateUserData(User user) => _cloud_firestore_repository.updateUserData(user);

  //////////////////////////////////
  ///ADD & DELETE TO/FROM FAVORITES
  subirProductos(Product productoAgregar) =>
      _cloud_firestore_repository.subirProductosFavorito(productoAgregar);

  void eliminarDeFavoritos(var producto) =>
      _cloud_firestore_repository.eliminarDeFavoritos(producto);

  ///ADD & DELETE TO/FROM CART
  void subirProductosCarrito(Product productoAgregar) =>
      _cloud_firestore_repository.subirProductosCarrito(productoAgregar);

  void eliminarProductoCarrito(var producto) =>
      _cloud_firestore_repository.eliminarProductoCarrito(producto);

  @override
  void dispose() {}
}

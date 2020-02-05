import 'dart:async';
import 'dart:html';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:generic_bloc_provider/generic_bloc_provider.dart';
import 'package:ecomerceapp/Product/model/product.dart';
import 'package:ecomerceapp/Product/repository/firebase_storage_repository.dart';
import 'package:ecomerceapp/User/model/user.dart';
import 'package:ecomerceapp/User/repository/auth_repository.dart';
import 'package:ecomerceapp/User/repository/cloud_firestore_repository.dart';
import 'package:ecomerceapp/Payments/repository/stripe_services_repository.dart';

class UserBloc implements Bloc {
  final _auth_repository = Auth_Repository();
  final _cloud_firestore_repository = CloudFirestoreRepository();
  final stripe_services_respository = StripeServicesRepository();
  //final _firebase_storage_repository = FirebaseStorageRepository();

  ///USER DOC REF
  DocumentReference userDocRef(String uid) =>
      _cloud_firestore_repository.userDocRef(uid);

  Future<FirebaseUser> get currentUser => FirebaseAuth.instance.currentUser();

  //////////////////////////////////
  ///Firebase Streams
  Stream<FirebaseUser> get authStatusFirebase =>
      FirebaseAuth.instance.onAuthStateChanged;

  Stream<DocumentSnapshot> currentUserStream(String uid) {
    return Firestore.instance
        .collection('users')
        .document(uid) // aqui va el nombre del usuario actual
        .snapshots();
  }

  ////////////////////////////////////////
  ///LOGIN, SIGNUP, SIGNOUT, UPDATE DATA
  Future<FirebaseUser> signInEmail(
          String email, String password, BuildContext context) =>
      _auth_repository.signInEmail(email, password, context);

  Future<FirebaseUser> signInGoogle() => _auth_repository.signInGoogle();

  Future<FirebaseUser> signUpWithEmailPassword(
          name, email, password, context) =>
      _auth_repository.signUpWithEmailPassword(name, email, password, context);

  signOut() => _auth_repository.signOut();

  updateUserData(User user, bool exists) =>
      _cloud_firestore_repository.updateUserData(user, exists);

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

  ///PAYMENTS SECTION
  ///CREATE STRIPE CUSTOMER
  Future<void> createStripeCustomer({String email, String userId}) =>
      stripe_services_respository.createStripeCustomer(
          userId: userId, email: email);

  ///ADD CARD
  Future<void> addCard(
          {int cardNumber, int month, int year, int cvc, String stripeId}) =>
      stripe_services_respository.addCard(
          stripeId: stripeId,
          year: year,
          month: month,
          cvc: cvc,
          cardNumber: cardNumber);

  ///CREATE CHARGE TO CUSTOMER
  Future<void> charge(
          {int amount,
          String currency,
          String sourceToken,
          String descripcion,
          String customerID}) =>
      stripe_services_respository.charge(
          sourceToken: sourceToken,
          customerID: customerID,
          currency: currency,
          descripcion: descripcion,
          amount: amount);

  @override
  void dispose() {}
}

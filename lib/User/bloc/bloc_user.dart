import 'dart:async';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:generic_bloc_provider/generic_bloc_provider.dart';
import 'package:ecomerceapp/Product/model/product.dart';
import 'package:ecomerceapp/Product/repository/firebase_storage_repository.dart';
import 'package:ecomerceapp/User/model/user.dart';
import 'package:ecomerceapp/User/repository/auth_repository.dart';
import 'package:ecomerceapp/User/repository/cloud_firestore_api.dart';
import 'package:ecomerceapp/User/repository/cloud_firestore_repository.dart';

class UserBloc implements Bloc {
  final _auth_repository = Auth_Repository();
  final _cloud_firestore_repository = CloudFirestoreRepository();
  final _firebase_storage_repository = FirebaseStorageRepository();
  final _auth = FirebaseAuth.instance;
  String name = FirebaseAuth.instance.currentUser().toString();

  //User user = User.fromJson(json);
  Future<String> userId =
      FirebaseAuth.instance.currentUser().then((FirebaseUser user) => user.uid);

  //aqui se manejan los flujos de datos

  //streams de firebase
  Stream<FirebaseUser> streamFirebase =
      FirebaseAuth.instance.onAuthStateChanged;

  Stream<FirebaseUser> get authStatus => streamFirebase;

  Future<FirebaseUser> get currentUser => FirebaseAuth.instance.currentUser();

  ///stream de datos del usuario actual
  Stream<DocumentSnapshot> get courseDocStream => Firestore.instance
      .collection('users')
      .document(
          //name)
          'CP3iWB9nFFS3OaUsSbsxOZU38Hz2') // aqui va el nombre del usuario actual
      .snapshots();

  ///trying to make a stream from the actual user

  //FIREBASE STORAGE MANEJO DE ALMACENAMIENTO EN LA NUBE
  Future<StorageUploadTask> uploadFile(String path, File image) =>
      _firebase_storage_repository.uploadFile(path, image);

  ///prueba de stream q devuelva el snapshot del usuario actual
  /*Stream<DocumentSnapshot> getcurrentUser() async*{
    //var user = await _auth.currentUser();
    //final User user = FirebaseAuth.instance.currentUser() as User;
    var user = _auth.currentUser();
    User temp = user as User;
    String userId = await temp.uid;

    yield* Firestore.instance
      .collection('users')
      .document(
      //name)
  'uG82RMmS7xd5kezrNESLjcOHl1E2') // aqui va el nombre del usuario actual
      .snapshots();

  }*/

  ///este strem lo q va a hacer es estar atento a cambios en los datos del usuario
  ///en este caso en la lista de favorito
  //Stream<QuerySnapshot> placesListStream =
  //   Firestore.instance.collection(CloudFirestoreAPI().USERS).snapshots();
  //Stream<QuerySnapshot> get placesStream => placesListStream;

  ///termina aqui el stream para los lugares favoritos

  //Stream<QuerySnapshot> usersListStream =
  // Firestore.instance.collection(CloudFirestoreAPI().USERS).snapshots();
  //userListStream = Firestore.instance.collection("users").document("users/${currentUser.uid}");
  // userListStream = Firestore.instance.collection("users").document("users/$uG82RMmS7xd5kezrNESLjcOHl1E2");
  //Stream<QuerySnapshot> get usersStream => usersListStream;

  ///
  //Aqui van los casos de uso   "${USERS}/${user.uid}"

  // 1 signin con Google
  Future<FirebaseUser> signIn() => _auth_repository.signInFirebase();

  //2 signout de google
  signOut() => _auth_repository.signOut();

  //3 registrar usuario en la base de datos
  updateData(User user) => _cloud_firestore_repository.updateUserData(user);

  ///aqui va hacer login con email and password
  void handleSignInEmail(String email, String password, BuildContext context) =>
      _auth_repository.handleSignInEmail(email, password, context);

  /// qui va registrar usuario con email and pssword
  Future<FirebaseUser> signUpWithEmailPassword(email, password) =>
      _auth_repository.signUpWithEmailPassword(email, password);

  ///este es para agregar un producto a favoritos
  subirProductos(Product productoAgregar) =>
      _cloud_firestore_repository.subirProductos(productoAgregar);

  ///este es para agregar un producto a el carrito
  void subirProductosCarrito(Product productoAgregar) =>
      _cloud_firestore_repository.subirProductosCarrito(productoAgregar);

  ///este es para eliminar un producto de favoritos
  void eliminarDeFavoritos(var producto) =>
      _cloud_firestore_repository.eliminarDeFavoritos(producto);

  ///eliminar del carrito un producto
  void eliminarProductoCarrito(var producto) =>
      _cloud_firestore_repository.eliminarProductoCarrito(producto);

  ///este es el de contruir l listview de losn rpodcutos desde q recibe los usuarios
  //void buildPlaces(List<DocumentSnapshot> usersListSnapshot) =>
  //  _cloud_firestore_repository.buildPlaces(usersListSnapshot);

  @override
  void dispose() {}
}

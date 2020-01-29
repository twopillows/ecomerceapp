import 'dart:core';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:ecomerceapp/Product/model/product.dart';
import 'package:ecomerceapp/User/model/user.dart';

class CloudFirestoreAPI {
  final String USERS = "users";
  final String PRODUCTS = "product_list";
  final String FAVORITES = "favorites";
  Firestore _db = Firestore.instance;
  FirebaseAuth _auth = FirebaseAuth.instance;

  ///UPDATE USER DATA
  void updateUserDataFirestore(User user) async {
    DocumentReference ref = _db.collection(USERS).document(user.uid);
    return ref.setData({
      'uid': user.uid,
      'name': user.name,
      'email': user.email,
      'photoURL': user.photoURL,
      'myOrders': user.myOrders,
      //'myFavoriteProducts8': user.myFavoriteProducts,
      //'myCart': user.myCart,
      'lastSignIn': DateTime.now()
    }, merge: true);
  }

  ///ADD FAVORITE
  void subirProductosFavorito(Product productoAgregar) async {
    var user = await _auth.currentUser();
    List<Map<String, dynamic>> productosSerializados;
    final productoJSON =
        productoAgregar.toJson(); // este prod esta listo para ser subido

    productosSerializados = [productoJSON];
    print("alla");
    _db.collection(USERS).document(user.uid).updateData(
        {'myFavoriteProducts': FieldValue.arrayUnion(productosSerializados)});
  }

  ///ADD TO CART
  void subirProductosCarrito(Product productoAgregar) async {
    var user = await _auth.currentUser();
    List<Map<String, dynamic>> productosSerializados;
    final productoJSON =
        productoAgregar.toJson(); // este prod esta listo para ser subido

    productosSerializados = [productoJSON];
    print("SE ANNADIO AL CARRITO");
    _db
        .collection(USERS)
        .document(user.uid)
        .updateData({'myCart': FieldValue.arrayUnion(productosSerializados)});
  }

  ///REMOVE FROM FAVORITES
  void eliminarDeFavoritos(var producto) async {
    // me dan el producto en json
    var user = await _auth.currentUser();
//tengo q ver cual es la diferencia entre List<Map<String, dynamic>> y List<dynamic>
    List<dynamic> prodAELiminar = [producto];
    _db.collection(USERS).document(user.uid).updateData(
        {'myFavoriteProducts': FieldValue.arrayRemove(prodAELiminar)});
  }

  ///REMOVE FROM CART
  void eliminarProductoCarrito(var producto) async {
    var user = await _auth.currentUser();
    List<dynamic> prodAELiminar = [producto];

    _db
        .collection(USERS)
        .document(user.uid)
        .updateData({'myCart': FieldValue.arrayRemove(prodAELiminar)});
  }
}

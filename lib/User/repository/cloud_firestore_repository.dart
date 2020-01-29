import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:ecomerceapp/Product/model/product.dart';
import 'package:ecomerceapp/User/model/user.dart';
import 'package:ecomerceapp/User/repository/cloud_firestore_api.dart';
import 'dart:async';

class CloudFirestoreRepository {
  final _cloud_firestore_api = CloudFirestoreAPI();

  void updateUserData(User user) =>
      _cloud_firestore_api.updateUserDataFirestore(user);

  ///ADD & DELETE TO/FROM FAVORITES
  void subirProductosFavorito(Product productoAgregar) =>
      _cloud_firestore_api.subirProductosFavorito(productoAgregar);

  void eliminarDeFavoritos(var producto) =>
      _cloud_firestore_api.eliminarDeFavoritos(producto);

  ///ADD & DELETE TO/FROM CART
  void subirProductosCarrito(Product productoAgregar) =>
      _cloud_firestore_api.subirProductosCarrito(productoAgregar);

  void eliminarProductoCarrito(var producto) =>
      _cloud_firestore_api.eliminarProductoCarrito(producto);
}

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

  //Future<void> updateFavoritesProductData(Product product)async=>
  //  _cloud_firestore_api.updateFavoritesProductData(product);

  //Future<void> updateFavoritesData(Product product)async => _cloud_firestore_api.updateFavoritesData(product);

  ///test
  void obtenerListaProductosActual() =>
      _cloud_firestore_api.obtenerListaProductosActual();

  ///
  //este es para agregar el producto a favorito
  void subirProductos(Product productoAgregar) =>
      _cloud_firestore_api.subirProductos(productoAgregar);

  //este es para subir los productos ual carrito
  void subirProductosCarrito(Product productoAgregar) =>
      _cloud_firestore_api.subirProductosCarrito(productoAgregar);

  //este va a eliminar un favorito
  void eliminarDeFavoritos(var producto) =>
      _cloud_firestore_api.eliminarDeFavoritos(producto);

  //este va a eliminar del carrito
  void eliminarProductoCarrito(var producto) =>
      _cloud_firestore_api.eliminarProductoCarrito(producto);

  ///este es el q va a construir los products a partir de todos los usuarios

  //void buildPlaces(List<DocumentSnapshot> usersListSnapshot) => _cloud_firestore_api.buildPlaces(usersListSnapshot);

}

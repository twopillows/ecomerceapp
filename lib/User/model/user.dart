import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:ecomerceapp/Product/model/product.dart';
//import 'package:json_annotation/json_annotation.dart';

class User {
  String uid;
  String name;
  String email;
  String photoURL;
  List<Product> myOrders;
  List<Product> myFavoriteProducts;
  List<Product> myCart;
  String stripeId;

  //factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  //Map<String, dynamic> toJson() => _$UserToJson(this);

  User(
      {Key key,
      @required this.uid,
      @required this.name,
      @required this.email,
      @required this.photoURL,
      @required this.myOrders,
      @required this.myFavoriteProducts,
      @required this.myCart});

  factory User.fromJson(Map<String, dynamic> json) => _itemFromJson(json);

  UserParse(Map<String, dynamic> data) {
    name = data['name'];
    //alias = data['alias'];
  }

  User.fromSnapshot(DocumentSnapshot snap) {
    email = snap.data['email'];
    name = snap.data['name'];
    uid = snap.data['uid'];
    stripeId = snap['stripeId'] ?? null;
  }
}

User _itemFromJson(Map<String, dynamic> json) {
  return User(
    uid: json['uid'] as String,
    name: json['name'] as String,
    email: json['email'] as String,
    //photoURL: json['photoURL'] as String,
    //myOrders: json['myOrders'] as List<Product>,
    myFavoriteProducts: json['myFavoriteProducts'] as List<Product>,
    myCart: json['myCart'] as List<Product>,
  );
}

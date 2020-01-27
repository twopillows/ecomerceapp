import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:convert';


class Product {
  String id;
  String name;
  int numero;
  String old_price;
  String picture;
  double price;

  Product({Key key,@required this.name, @required this.numero, @required this.old_price,
      @required this.picture, @required this.price});

  //factory Product.fromJson(Map<String, dynamic> json) => _itemFromJson(json);


  Map<String, dynamic> toJson() => {
    'name': name,
    'numero': numero,
    'old_price': old_price,
    'picture': picture,
    'price': price,
  };
}

/*
Product _itemFromJson(Map<String, dynamic> json) {
  return Product(
    //id: json['id'] as String,
    name: json['name'] as String,
    price: json['price'] as double,
    numero: json['numero'] as int,
    old_price: json['old_price'] as String,
    picture: json['picture'] as String,
  );
}*/

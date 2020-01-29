import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Product {
  String id;
  String name;
  int numero;
  String old_price;
  String picture;
  double price;

  Product(
      {Key key,
      @required this.name,
      @required this.numero,
      @required this.old_price,
      @required this.picture,
      @required this.price});

  Map<String, dynamic> toJson() => {
        'name': name,
        'numero': numero,
        'old_price': old_price,
        'picture': picture,
        'price': price,
      };
}

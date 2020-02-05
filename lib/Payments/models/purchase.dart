import 'package:cloud_firestore/cloud_firestore.dart';

class PurchaseModel {
  static const ID = 'id';
  static const PRODUCT_NAME = 'productName';
  static const AMOUNT = 'amount';
  static const CUSTOMER_ID = 'customerId';
  static const DATE = 'date';
  static const CARD_ID = 'card_id';

  String _id;
  String _productName;
  int _amount;
  String _customerId;
  String _date;
  String _creditCard;

  String get id => _id;
  String get productName => _productName;
  int get amount => _amount;
  String get customerId => _customerId;
  String get date => _date;
  String get creditCard => _customerId;

  PurchaseModel.fromSnapshot(DocumentSnapshot documentSnapshot) {
    _id = documentSnapshot.data[ID];
    _productName = documentSnapshot.data[PRODUCT_NAME];
    _amount = documentSnapshot.data[AMOUNT];
    _customerId = documentSnapshot.data[CUSTOMER_ID];
    _date = documentSnapshot.data[DATE];
    _creditCard = documentSnapshot.data[CARD_ID];
  }

  PurchaseModel.fromMap(Map map) {
    _id = map[ID];
    _productName = map[PRODUCT_NAME];
    _amount = map[AMOUNT];
    _customerId = map[CUSTOMER_ID];
    _date = map[DATE];
    _creditCard = map[CARD_ID];
  }

  Map<String, dynamic> toMap() {
    return {
      ID: _id,
      PRODUCT_NAME: _productName,
      AMOUNT: _amount,
      CUSTOMER_ID: _customerId,
      DATE: _date,
      CARD_ID: _creditCard
    };
  }
}

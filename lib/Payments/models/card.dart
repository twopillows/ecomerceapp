import 'package:cloud_firestore/cloud_firestore.dart';

class CardModel {
  static const ID = 'id';
  static const CUSTOMER_ID = 'customerId';
  static const MONTH = 'month';
  static const YEAR = 'year';
  static const LAST_FOUR = 'last4';

  String _id;
  String _customerId;
  int _month;
  int _year;
  int _last4;

  String get id => _id;
  String get customerId => _customerId;
  int get month => _month;
  int get year => _year;
  int get last4 => _last4;

  CardModel.fromSnapshot(DocumentSnapshot documentSnapshot) {
    _id = documentSnapshot.data[ID];
    _customerId = documentSnapshot.data[CUSTOMER_ID];
    _month = documentSnapshot.data[MONTH];
    _year = documentSnapshot.data[YEAR];
    _last4 = documentSnapshot.data[LAST_FOUR];
  }

  CardModel.fromMap(Map map) {
    _id = map[ID];
    _customerId = map[CUSTOMER_ID];
    _month = map[MONTH];
    _year = map[YEAR];
    _last4 = map[LAST_FOUR];
  }

  Map<String, dynamic> toMap() {
    return {
      ID: _id,
      CUSTOMER_ID: _customerId,
      MONTH: _month,
      YEAR: _year,
      LAST_FOUR: _last4,
    };
  }
}

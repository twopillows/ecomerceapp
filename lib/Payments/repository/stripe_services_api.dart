import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:ecomerceapp/Payments/models/card.dart';
import 'package:ecomerceapp/Payments/models/purchase.dart';
import 'package:stripe_payment/stripe_payment.dart';
import 'package:http/http.dart' as http;

class StripeServicesAPI {
  static const PUBLISHABLE_KEY = "pk_test_ZbTnVP36Xm2jew9rbA0Tz47q00vFv9ThSp";
  static const SECRET_KEY = "sk_test_eRXU9VIyysiak1utlHXFqgEO00uBDjtk12";
  static const PAYMENT_METHOD = 'https://api.stripe.com/v1/payment_methods';
  static const CUSTOMER_URL = 'https://api.stripe.com/v1/customers';
  static const CHARGE_URL = 'https://api.stripe.com/v1/charges';
  String cardCollection = 'cards';
  String purchaseCollection = 'purchases';
  final _firestore = Firestore.instance;

  Map<String, String> headers = {
    'Authorization': 'Bearer $SECRET_KEY',
    'Content-Type': 'application/x-www-form-urlencoded'
  };

  Future<void> createStripeCustomer({String email, String userId}) async {
    Map<String, String> body = {'email': email};

    http.post(CUSTOMER_URL, body: body, headers: headers).then((response) {
      String stripeId = jsonDecode(response.body)['id'];
      print('Stripe ID is $stripeId');
      _firestore.collection('users').document(userId).updateData({
        'stripeId': stripeId,
      });
    }).catchError((err) {
      print('ERROR CREATING STRPE CUSTOMER: ${err}');
    });
  }

  Future<void> addCard(
      {int cardNumber, int month, int year, int cvc, String stripeId}) async {
    Map<String, dynamic> body = {
      "type": "card",
      "card[number]": cardNumber,
      "card[exp_month]": month,
      "card[exp_year]": year,
      "card[cvc]": cvc
    };

    Dio()
        .post(PAYMENT_METHOD,
            data: body,
            options: Options(
                contentType: Headers.formUrlEncodedContentType,
                headers: headers))
        .then((response) {
      String paymentMethodID = response.data['id'];
      print('payment id is ${paymentMethodID.toString()}');
      Map<String, String> body = {'customer': stripeId};
      //Attaching paymentMethod to customer
      http
          .post(
              'https://api.stripe.com/v1/payment_methods/$paymentMethodID/attach',
              headers: headers,
              body: body)
          .catchError((err) {
        print('ERROR ATTACHING PAYMENTMETHOD TO A CUSTOMER :${err.toString()}');
      });
    }).catchError((err) {
      print('ERROR ADDING PAYMENT METHOD ${err.toString()}');
    });
  }

  Future<void> charge(
      {int amount,
      String currency,
      String sourceToken,
      String descripcion,
      String customerID}) async {
    Map<String, dynamic> data = {
      'amount': amount,
      'currency': 'usd',
      'description': descripcion,
      'source': 'pm_1G8pgWDULLCkjkXdfupe0UP7',
      'customer': customerID
    };

    Dio()
        .post(CHARGE_URL,
            data: data,
            options: Options(
                contentType: Headers.formUrlEncodedContentType,
                headers: headers))
        .then((response) {
      String chargeID = response.data['id'];
      print('THE CHARGE ID IS ${chargeID}');
    }).catchError((err) {
      print('ERROR ADDING A CHARGE ${err.toString()}');
    });
  }

  ///CARD SERVICES
  ///CREATE CARD IN DATABASE
  void createCard(Map<String, dynamic> card) {
    _firestore.collection(cardCollection).document(card['id']).setData(card);
  }

  ///CARD LIST OF A CUSTOMER
  Future<List<CardModel>> getCardsHistory({String customerId}) async {
    _firestore
        .collection(cardCollection)
        .where('customerId', isEqualTo: customerId)
        .getDocuments()
        .then((doc) {
      List<CardModel> cardHistory = [];
      doc.documents.map((item) {
        cardHistory.add(CardModel.fromSnapshot(item));
      });
      return cardHistory;
    });
  }

  ///UPDATE CARD DETAILS IN DATABASE
  void updateCardDetails(Map<String, dynamic> card) {
    _firestore.collection(cardCollection).document(card['id']).updateData(card);
  }

  ///DELETE CARD IN DATABASE
  void deleteCard(Map<String, dynamic> card) {
    _firestore.collection(cardCollection).document(card['id']).delete();
  }

  ///GET purchase by card id
  Future<CardModel> getCardByUserID(String id) {
    _firestore.collection(cardCollection).document(id).get().then((doc) {
      CardModel card = CardModel.fromSnapshot(doc);
      return card;
    });
  }

  ///get all cards????
  void getAllCards(String customerId) {
    _firestore.collection(customerId).document(customerId).delete();
  }

  ///PURCHASE SERVICES
  ///CREATE PURCHASE IN DATABASE
  void createPurchase(Map<String, dynamic> purchase) {
    _firestore
        .collection(purchaseCollection)
        .document(purchase['id'])
        .setData(purchase);
  }

  Future<List<PurchaseModel>> getPurchaseHistory({String customerId}) async {
    _firestore
        .collection(purchaseCollection)
        .where('customerId', isEqualTo: customerId)
        .getDocuments()
        .then((doc) {
      List<PurchaseModel> purchasesHistory = [];
      doc.documents.map((item) {
        purchasesHistory.add(PurchaseModel.fromSnapshot(item));
      });
      return purchasesHistory;
    });
  }

  ///GET PURCHASE by card id
  Future<PurchaseModel> getPurchaseByUserID(String id) {
    _firestore.collection(purchaseCollection).document(id).get().then((doc) {
      PurchaseModel purchase = PurchaseModel.fromSnapshot(doc);
      return purchase;
    });
  }
  /*///UPDATE PURCHASE DETAILS IN DATABASE
  void updatePurchaseDetails(Map<String, dynamic> purchase) {
    _firestore
        .collection(purchaseCollection)
        .document(purchase['id'])
        .updateData(purchase);
  }

  ///DELETE PURCHASE IN DATABASE
  void deletePurchase(Map<String, dynamic> purchase) {
    _firestore.collection(purchaseCollection).document(purchase['id']).delete();
  }*/

}

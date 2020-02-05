import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:stripe_payment/stripe_payment.dart';
import 'package:http/http.dart' as http;

class StripeServices {
  static const PUBLISHABLE_KEY = "pk_test_ZbTnVP36Xm2jew9rbA0Tz47q00vFv9ThSp";
  static const SECRET_KEY = "sk_test_eRXU9VIyysiak1utlHXFqgEO00uBDjtk12";
  static const PAYMENT_METHOD = 'https://api.stripe.com/v1/payment_methods';
  static const CUSTOMER_URL = 'https://api.stripe.com/v1/customers';
  static const CHARGE_URL = 'https://api.stripe.com/v1/charges';

  Map<String, String> headers = {
    'Authorization': 'Bearer $SECRET_KEY',
    'Content-Type': 'application/x-www-form-urlencoded'
  };

  Future<void> createStripeCustomer({String email, String userId}) async {
    Map<String, String> body = {'email': email};

    http.post(CUSTOMER_URL, body: body, headers: headers).then((response) {
      String stripeId = jsonDecode(response.body)['id'];
      print('Stripe ID is $stripeId');
      Firestore.instance.collection('users').document(userId).updateData({
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
}

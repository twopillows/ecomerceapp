import 'package:flutter/material.dart';
//import 'package:platzi_trips_app/services/payment_service.dart';
//import 'package:stripe_payment/stripe_payment.dart';

class PaymentScreen extends StatefulWidget {
  @override
  _PaymentScreenState createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {

  @override
  void initState(){
    super.initState();
    //StripeSource.setPublishableKey('pk_test_ZbTnVP36Xm2jew9rbA0Tz47q00vFv9ThSp');
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.green,
      child: Column(
        children: <Widget>[
          Container(
            height: 200,
            width: 200,
            child: IconButton(
              icon: Icon(
                Icons.keyboard_arrow_left,
                color: Colors.black,
                size: 25,
              ),
              onPressed: () {
                Navigator.pop(context);
              }, //alignment: Alignment.centerLeft,
            ),
          ),
          RaisedButton(
              child: Text("Add Card"),
              color: Colors.black,
              textColor: Colors.white,
              onPressed: () {
                ///aqui esta la salsa

                //StripeSource.addSource().then((token) {
                  //PaymentService().addCard(token);
                //});

              }),
        ],
      ),
    );
  }
}

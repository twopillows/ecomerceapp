import 'dart:io';

import 'package:flutter/material.dart';
import 'package:ecomerceapp/widgets/custom_appbar_text.dart';
import 'package:ecomerceapp/widgets/gradient_back.dart';
import 'package:ecomerceapp/widgets/text_input.dart';

class CheckOutScreen extends StatefulWidget {
  @override
  State createState() {
    return _CheckOutScreen();
  }
}

class _CheckOutScreen extends State<CheckOutScreen> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: Stack(
        children: <Widget>[
          GradientBack(
            title: "",
            height: null,
          ),
          Row(
            children: <Widget>[
              Container(
                padding: EdgeInsets.only(top: 25.0, left: 5.0),
                child: SizedBox(
                  height: 45.0,
                  width: 45.0,
                  child: IconButton(
                      icon: Icon(
                        Icons.keyboard_arrow_left,
                        color: Colors.white,
                        size: 45,
                      ),
                      onPressed: () {
                        Navigator.pop(context);
                      }),
                ),
              ),
              Flexible(
                  child: Container(
                padding: EdgeInsets.only(top: 45.0, left: 20.0, right: 10.0),
                child: TitleHeader(title: "Check Out Page"),
              ))
              /*Container(
                padding: EdgeInsets.only(top: 25.0, left: 5.0),
                child: SizedBox(

                  height: 45.0,
                  width: 45.0,
                  child: Text("Swap Trendy"),
                ),
              ),*/
            ],
          ),
          //TextInput(controller: ,),
        ],
      ),
    );
  }
}

// aqui tngo q pone

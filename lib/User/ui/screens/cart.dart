import 'dart:io';

import 'package:badges/badges.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:generic_bloc_provider/generic_bloc_provider.dart';
import 'package:ecomerceapp/Product/ui/screens/add_place_screen.dart';
import 'package:ecomerceapp/User/ui/screens/check_out_screen.dart';
import 'package:ecomerceapp/User/bloc/bloc_user.dart';
import 'package:ecomerceapp/main.dart';
import 'package:ecomerceapp/Product/ui/widgets/cart_products.dart';
import 'package:ecomerceapp/widgets/custom_appbar_text.dart';
import 'package:ecomerceapp/widgets/general_button.dart';
import 'package:ecomerceapp/widgets/size_config.dart';
//import 'package:platzi_trips_app/pages/app.dart';

class Cart extends StatefulWidget {
  final String uid;
  double total = 0;

  Cart({Key key, this.uid});

  @override
  _CartState createState() => _CartState();
}

class _CartState extends State<Cart> {
  UserBloc userBloc;
  @override
  Widget build(BuildContext context) {
    userBloc = BlocProvider.of<UserBloc>(context);
    SizeConfig().init(context);

    return SafeArea(
      child: Scaffold(
        body: Column(
          children: <Widget>[
            //aqui va el header
            _headerProductDetails(context),

            Cart_Products(),
            Row(
              children: <Widget>[
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                    child: Container(
                      width: 100,
                      //he: SizeConfig.safeBlockVertical * 10,
                      height: 45,
                      child: RaisedButton(
                        elevation: 5,
                        onPressed: () => Navigator.of(context).push(
                            //aqui va product details cdo se da clicks ProductDetails()
                            MaterialPageRoute(
                                //==========================AQUIIIII VA PORODCUT LIST==============
                                builder: (context) => CheckOutScreen())),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20)),
                        color: Color(0xFF108CED),
                        child: Text(
                          "Place Order",
                          style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                              color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                ),
                Container(
                  height: SizeConfig.safeBlockVertical * 7,
                  //height: 60,
                  //width: 100,
                  width: SizeConfig.safeBlockHorizontal * 30,
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(5, 0, 5, 0),
                    child: StreamBuilder(
                      //stream: userBloc.courseDocStream,
                      stream: Firestore.instance
                          .collection('users')
                          .document(
                              //name)
                              widget
                                  .uid) // aqui va el nombre del usuario actual
                          .snapshots(),
                      builder:
                          (context, AsyncSnapshot<DocumentSnapshot> snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.active) {
                          var courseDocument = snapshot.data.data;
                          var sections = courseDocument['myCart'];

                          double temp = 0;
                          if (sections != null) {
                            for (int x = 0; x < sections.length; x++) {
                              temp += sections[x]['price'];
                            }
                          }
                          return Center(
                            child: Text(
                              "\$" + temp.toStringAsFixed(2),
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold),
                            ),
                          );
                        } else {
                          return Text("no info");
                        }
                      },
                    ),
                  ),
                ),
              ],
            )
            /*Container(
              height: 150,
              child: FloatingActionButton(
                backgroundColor: Colors.blue,
                mini: true,
                onPressed: () {
                  File image;
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (BuildContext context) => AddPlaceScreen(image: image,)));
                },
                child: Icon(
                  Icons.shopping_cart,
                  size: 30,
                  color: Colors.red,
                ),
                heroTag: null,

              ),
            ),*/
          ],
        ),
/*
        bottomNavigationBar: Container(
          //color: Color(0xFF108CED)
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: <Widget>[
                Expanded(child: Text("Total:",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),)),
                Expanded(child: Text("\$100",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold))),
                Expanded(
                    child: MaterialButton(
                      //aqui debe ir a la pantalla de check out order

                      onPressed: () {},
                      child: Text("Check Out"),
                      color: Color(0xFF108CED),
                    )),


              ],
            ),
          ),
        ),
*/
      ),
    );
  }

  Widget _headerProductDetails(BuildContext context) {
    return Stack(
      overflow: Overflow.visible,
      children: <Widget>[
        Container(
          //height: 80, //120
          height: SizeConfig.safeBlockVertical * 11,

          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                //Color(0xff1e2a54),
                //Color(0xff1773b3),
                Color(0xFF0060FF),
                Color(0xFF00A1FF),
              ],
            ),
          ),
        ),
        Padding(
          /*padding: EdgeInsets.fromLTRB(
              16, MediaQuery.of(context).padding.top + 16, 16, 16),*/
          padding: EdgeInsets.fromLTRB(
              16, MediaQuery.of(context).padding.top + 28, 16, 0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              ///aqui va el bottom pa atras
              IconButton(
                icon: Icon(
                  Icons.keyboard_arrow_left,
                  color: Colors.white,
                  size: 25,
                ),
                onPressed: () {
                  Navigator.pop(context);
                }, //alignment: Alignment.centerLeft,
              ),
              TitleHeader(
                title: 'Swap Trendy',
                //style: TextStyle(color: Colors.white, fontSize: 25),
              ),
              StreamBuilder<DocumentSnapshot>(
                  stream: userBloc.courseDocStream,
                  builder: (context, AsyncSnapshot<DocumentSnapshot> snapshot) {
                    if (snapshot.connectionState == ConnectionState.active) {
                      var courseDocument = snapshot.data.data;
                      var sections = courseDocument['myCart'];

                      return BadgeIconButton(
                        //itemCount: 3,
                        //badgeColor: Colors.black,
                        //badgeTextColor: Colors.green,
                        itemCount: sections != null ? sections.length : 0,
                        icon: Icon(
                          Icons.shopping_cart,
                          color: Colors.white,
                          size: 25,
                        ),
                        onPressed: () {},
                      );
                    } else {
                      return Container(
                        child: Text(""),
                      );
                    }
                  }),

              /*Container(
                height: 25,
                width: 45,
              ),*/
            ],
          ),
        ),
        /*Container(
          padding: EdgeInsets.all(16),
          margin: EdgeInsets.only(top: MediaQuery.of(context).padding.top + 46),
          child: Center(child: Text("🚚FREE SHIPPING🚚"),),
        ),*/
      ],
    );
  }
}

import 'package:flutter/material.dart';
import 'package:ecomerceapp/Product/ui/widgets/header.dart';
import 'package:ecomerceapp/Product/ui/screens/product_list.dart';
import 'package:ecomerceapp/widgets/image_carousel.dart';
import 'package:ecomerceapp/widgets/size_config.dart';

class HomeScreen extends StatefulWidget {
  final String uid;

  HomeScreen({Key key, this.uid});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return SafeArea(
      child: Scaffold(
        //resizeToAvoidBottomInset: false,
        body: SingleChildScrollView(
          child: Container(
            color: Colors.white,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                Header(uid: widget.uid),

                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: ImageCarousel(),
                    ),
                    Padding(
                      //padding: EdgeInsets.all(8.0),
                      padding: EdgeInsets.only(top: 4),
                      child: Text(' Pet Products',
                          style: TextStyle(
                              fontSize: 35, fontWeight: FontWeight.bold)),
                    ),
                    Row(
                      children: <Widget>[
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              height: SizeConfig.safeBlockVertical * 26,
                              //height: 180,
                              width: SizeConfig.safeBlockHorizontal * 26,
                              //width: 180,
                              //color: Colors.yellow,
                              child: Card(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(15.0),
                                  ),
                                  child: Material(
                                    //elevation: 0.0,
                                    //borderRadius: BorderRadius.all(Radius.circular(100.0)),
                                    child: InkWell(
                                      //borderRadius: BorderRadius.all(Radius.circular(30.0)),
                                      onTap: () => Navigator.of(context).push(
                                          //aqui va product details cdo se da clicks ProductDetails()
                                          MaterialPageRoute(
                                              //==========================AQUIIIII VA PORODCUT LIST==============
                                              builder: (context) =>
                                                  ProductList())),
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(15.0)),
                                        child: Stack(
                                          children: <Widget>[
                                            Container(
                                              height: 200.0,
                                              width: 200.0,
                                              decoration: BoxDecoration(
                                                  image: DecorationImage(
                                                      fit: BoxFit.cover,
                                                      image: NetworkImage(
                                                          "https://firebasestorage.googleapis.com/v0/b/swaptrendymac.appspot.com/o/dogs.jpg?alt=media&token=11d5a44f-e6a5-4e55-a3e0-25a649b14526")),
                                                  borderRadius: BorderRadius.all(Radius.circular(10.0)),
                                                  shape: BoxShape.rectangle,
                                                  boxShadow: <BoxShadow>[
                                                    BoxShadow(
                                                        color: Colors.black38,
                                                        blurRadius: 15.0,
                                                        offset:
                                                            Offset(0.0, 7.0))
                                                  ]),
                                              /*child: Image.asset(
                                            "images/images/icon/perros.png",
                                            fit: BoxFit.cover),*/
                                            ),
                                            Positioned(
                                              left: 10.0,
                                              bottom: 10.0,
                                              child: Row(
                                                children: <Widget>[
                                                  Column(
                                                    children: <Widget>[
                                                      Text(
                                                        "Dogs",
                                                        style: TextStyle(
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            color: Colors.black,
                                                            fontSize: 27.0),
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                  )),
                            ),
                          ),
                        ),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              //height: 180,
                              //width: 180,
                              height: SizeConfig.safeBlockVertical * 26,
                              //height: 180,
                              width: SizeConfig.safeBlockHorizontal * 26,
                              //color: Colors.yellow,
                              child: Card(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15.0),
                                ),
                                child: Material(
                                  //elevation: 0.0,
                                  //borderRadius: BorderRadius.all(Radius.circular(100.0)),
                                  child: InkWell(
                                    //borderRadius: BorderRadius.all(Radius.circular(30.0)),
                                    onTap: () => Navigator.of(context).push(
                                        //aqui va product details cdo se da clicks ProductDetails()
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                ProductList())),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(15.0)),
                                      child: Stack(
                                        children: <Widget>[
                                          Container(
                                            height: 200.0,
                                            width: 200.0,
                                            decoration: BoxDecoration(
                                                image: DecorationImage(
                                                    fit: BoxFit.cover,
                                                    image: NetworkImage(
                                                        "https://firebasestorage.googleapis.com/v0/b/swaptrendymac.appspot.com/o/cats.jpg?alt=media&token=7615ad79-381a-4691-9621-16703a40f49f")),
                                                borderRadius: BorderRadius.all(Radius.circular(10.0)),
                                                shape: BoxShape.rectangle,
                                                boxShadow: <BoxShadow>[
                                                  BoxShadow(
                                                      color: Colors.black38,
                                                      blurRadius: 15.0,
                                                      offset: Offset(0.0, 7.0))
                                                ]),
                                            /*child: Image.asset(
                                            "images/images/icon/perros.png",
                                            fit: BoxFit.cover),*/
                                          ),
                                          Positioned(
                                            left: 10.0,
                                            bottom: 10.0,
                                            child: Row(
                                              children: <Widget>[
                                                Column(
                                                  children: <Widget>[
                                                    Text(
                                                      "Cats",
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          color: Colors.black,
                                                          fontSize: 27.0),
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                      child: Container(
                        height: SizeConfig.safeBlockVertical * 15,
                        //height: 180,
                        //width: SizeConfig.blockSizeHorizontal * 26,
                        //height: 90.0,
                        child: Card(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15.0)),
                          child: InkWell(
                            onTap: () => Navigator.of(context).push(
                                MaterialPageRoute(
                                    builder: (context) => ProductList())),
                            child: ClipRRect(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(15.0)),
                              child: Stack(
                                children: <Widget>[
                                  Container(
                                    height: SizeConfig.safeBlockVertical * 15,
                                    //height: 110.0,
                                    width: SizeConfig.safeBlockHorizontal * 95,

                                    //width: 390.0,
                                    decoration: BoxDecoration(
                                        image: DecorationImage(
                                            fit: BoxFit.cover,
                                            image: NetworkImage(
                                                "https://firebasestorage.googleapis.com/v0/b/swaptrendymac.appspot.com/o/shopall.jpg?alt=media&token=5a952f87-7cbd-45b4-be5d-dcc2e672c883")),
                                        borderRadius: BorderRadius.all(Radius.circular(10.0)),
                                        shape: BoxShape.rectangle,
                                        boxShadow: <BoxShadow>[
                                          BoxShadow(
                                              color: Colors.black38,
                                              blurRadius: 15.0,
                                              offset: Offset(0.0, 7.0))
                                        ]),
                                    /*child: Image.asset(
                                            "images/images/icon/perros.png",
                                            fit: BoxFit.cover),*/
                                  ),
                                  Positioned(
                                    left: 140.0,
                                    bottom: 75.0,
                                    child: Row(
                                      children: <Widget>[
                                        Column(
                                          children: <Widget>[
                                            Text(
                                              "Shop All",
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.black,
                                                  fontSize: 30.0),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
                //aqui va el home como tal
              ],
            ),
          ),
        ),
      ),
    );
  }
}

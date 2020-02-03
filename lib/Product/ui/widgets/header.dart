import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:generic_bloc_provider/generic_bloc_provider.dart';
import 'package:ecomerceapp/User/bloc/bloc_user.dart';
import 'package:ecomerceapp/User/ui/screens/cart.dart';
import 'package:ecomerceapp/widgets/custom_appbar_text.dart';
import 'package:ecomerceapp/widgets/size_config.dart';
import 'package:badges/badges.dart';

class Header extends StatefulWidget {
  final String uid;

  Header({Key key, this.uid}) : super(key: key);

  @override
  _HeaderState createState() => _HeaderState();
}

class _HeaderState extends State<Header> {
  UserBloc userBloc;

  @override
  Widget build(BuildContext context) {
    userBloc = BlocProvider.of<UserBloc>(context);
    SizeConfig().init(context);
    return SafeArea(
      child: Stack(
        overflow: Overflow.visible,
        children: <Widget>[
          Container(
            //height: 120,
            height: SizeConfig.safeBlockVertical * 10, //15
            //120
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

          ///padding: EdgeInsets.fromLTRB(16, SizeConfig.safeBlockVertical + 12, 16, 0),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Container(
                height: 30,
                width: 30,
              ),
              /*Image.asset(
                'assets/images/amazon_logo.png',
                fit: BoxFit.fill,
                width: 80,
              ),*/
              Container(
                margin:
                    EdgeInsets.only(top: SizeConfig.safeBlockVertical * 3), //15
                child: TitleHeader(
                  title: ' Swap Trendy',
                  //style: TextStyle(color: Colors.white, fontSize: 25),
                ),
              ),
              StreamBuilder<DocumentSnapshot>(
                  stream: userBloc.currentUserStream(widget.uid),
                  builder: (context, AsyncSnapshot<DocumentSnapshot> snapshot) {
                    if (snapshot.connectionState == ConnectionState.active) {
                      var courseDocument = snapshot.data.data;
                      var sections = courseDocument['myCart'];

                      return Container(
                        margin: EdgeInsets.only(
                            top: SizeConfig.safeBlockVertical * 3.5), //15
                        child: BadgeIconButton(
                          //itemCount: 3,
                          itemCount: sections != null ? sections.length : 0,
                          icon: Icon(
                            Icons.shopping_cart,
                            color: Colors.white,
                            size: 25,
                          ),
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        Cart(uid: widget.uid)));
                          },
                        ),
                      );
                    } else {
                      return Container(
                        child: Text(""),
                      );
                    }
                  }),
              /*BadgeIconButton(
                icon: Icon(
                  Icons.,
                  color: Colors.white,
                  size: 25,
                ),
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => Cart()));
                },
              ),*/

              /*IconButton(
                icon: Icon(
                  Icons.shopping_cart,
                  color: Colors.white,
                  size: 25,
                ),
                onPressed: () {
                  Navigator.of(context)
                      .push(MaterialPageRoute(builder: (context) => Cart()));
                },
              ),*/
            ],
          ),
          /*Container(
            margin: EdgeInsets.only(top: SizeConfig.blockSizeVertical * 7),//60
            padding: EdgeInsets.symmetric(vertical: SizeConfig.safeBlockHorizontal * 4, horizontal: SizeConfig.safeBlockHorizontal * 4),
            //padding: EdgeInsets.only(top: SizeConfig.safeBlockHorizontal + 10),
            //margin: EdgeInsets.only(top: SizeConfig.safeBlockVertical + 48),//+ 48
            child: Theme(
              data: ThemeData(
                hintColor: Colors.transparent,
              ),
              child: TextField(
                //focusNode: FocusNode(canRequestFocus: true),
                autofocus: false,
                decoration: InputDecoration(
                  hintText: 'What are you looking for?',
                  hintStyle: TextStyle(
                    color: Color(0xffb4c2d3),
                    fontSize: 14,
                    //fontFamily: 'Medium',
                  ),
                  fillColor: Colors.white,
                  filled: true,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(50),
                    borderSide: BorderSide(
                      color: Colors.transparent,
                      width: 0,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(50),
                    borderSide: BorderSide(
                      color: Colors.transparent,
                      width: 0,
                    ),
                  ),
                  contentPadding: EdgeInsets.all(12),
                  suffixIcon: Icon(
                    Icons.search,
                    color: Color(0xffb4c2d3),
                    size: 15,
                  ),
                ),
              ),
            ),
          ),*/
        ],
      ),
    );
  }
}

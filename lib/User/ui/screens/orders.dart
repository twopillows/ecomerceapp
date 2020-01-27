import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:generic_bloc_provider/generic_bloc_provider.dart';
import 'package:ecomerceapp/User/bloc/bloc_user.dart';
import 'package:ecomerceapp/widgets/custom_appbar_text.dart';
import 'package:ecomerceapp/widgets/size_config.dart';

class Orders extends StatelessWidget {
  UserBloc userBloc;
  Widget build(BuildContext context) {
    userBloc = BlocProvider.of<UserBloc>(context);
    return Stack(
      children: <Widget>[
        _ordersList(context),
      ],
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
                title: 'Your Past Orders',
                //style: TextStyle(color: Colors.white, fontSize: 25),
              ),
              Container(
                height: 25,
                width: 45,
              ),
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

  Widget _ordersList(BuildContext context) {
    return StreamBuilder(
      stream: userBloc.courseDocStream,
      builder: (context, AsyncSnapshot<DocumentSnapshot> snapshot) {
        if (snapshot.connectionState == ConnectionState.active) {
          var userData = snapshot.data.data;
          var myOrders = userData['myCart'];

          return Scaffold(
            body: SafeArea(
              child: Column(
                children: <Widget>[
                  _headerProductDetails(context),
                  Expanded(
                    child: SizedBox(
                      child: ListView.builder(
                        scrollDirection: Axis.vertical,
                        itemExtent: 300,
                        itemCount: (myOrders != null) ? myOrders.length : 0,
                        itemBuilder: (_, int index) {
                          return Slidable(
                            actionPane: SlidableScrollActionPane(),
                            actionExtentRatio: 0.25,
                            child: _buildProductCard(myOrders, index),
                            secondaryActions: <Widget>[
                              /*IconSlideAction(
                                caption: 'Delete',
                                color: Colors.red,
                                icon: Icons.delete,
                                onTap: () {
                                  userBloc
                                      .eliminarDeFavoritos(sections[index]);
                                  print("delete from favorites");
                                },
                              ),*/
                            ],
                          );
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        } else {
          return Stack(
            children: <Widget>[
              _headerProductDetails(context),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 40, 0, 0),
                child: Container(),
              ),
            ],
          );
        }
      },
    );
  }

  Widget _buildProductCard(var sections, int index) {
    return Container();
  }
}

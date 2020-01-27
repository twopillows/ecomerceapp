import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:generic_bloc_provider/generic_bloc_provider.dart';
import 'package:ecomerceapp/User/model/user.dart';
import 'package:ecomerceapp/temp/LocalAuth/local_authentication_service.dart';
import 'package:ecomerceapp/temp/LocalAuth/service_locator.dart';
import 'package:ecomerceapp/widgets/button_green.dart';
import 'package:ecomerceapp/widgets/general_button.dart';
import 'package:ecomerceapp/widgets/gradient_back.dart';
import 'package:ecomerceapp/User/bloc/bloc_user.dart';
import 'package:ecomerceapp/tienda_principal_cupertino.dart';

class SignInScreen extends StatefulWidget {
  @override
  State createState() {
    return _SignInScreen();
  }
}

class _SignInScreen extends State<SignInScreen> {
  final LocalAuthenticationService _localAuth =
      locator<LocalAuthenticationService>();
  UserBloc userBloc;
  double width;

  @override
  Widget build(BuildContext context) {
    userBloc = BlocProvider.of<UserBloc>(context);
    width = MediaQuery.of(context).size.width;

    return _handleCurrentSession();
  }

  Widget _handleCurrentSession() {
    return StreamBuilder(
      stream: userBloc.authStatus,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (!snapshot.hasData || snapshot.hasError) {
          return signInGoogleUI();
        } else {
          //return signInGoogleUI();
          return TiendaPrincipalCupertino();
        }
      },
    );
  }

  Widget signInGoogleUI() {
    return Scaffold(
      body: Stack(
        alignment: Alignment.center,
        children: <Widget>[
          Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
                image: DecorationImage(
                    fit: BoxFit.cover,
                    image: CachedNetworkImageProvider(
                        "https://firebasestorage.googleapis.com/v0/b/swaptrendymac.appspot.com/o/fondo_splash.jpg?alt=media&token=884be468-704c-41f0-a3a9-656934cda851")),
                borderRadius: BorderRadius.all(Radius.circular(10.0)),
                shape: BoxShape.rectangle,
                boxShadow: <BoxShadow>[
                  BoxShadow(
                      color: Colors.black38,
                      blurRadius: 15.0,
                      offset: Offset(0.0, 7.0))
                ]),
          ),
          //NetworkImage("https://firebasestorage.googleapis.com/v0/b/swaptrendymac.appspot.com/o/fondo_splash.jpg?alt=media&token=884be468-704c-41f0-a3a9-656934cda851"),
          //GradientBack(height: null, title: "",width: 0,),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Flexible(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    width: width,
                    child: Text(
                      "Swap Trendy App",
                      style: TextStyle(
                          fontSize: 47.0,
                          fontFamily: "Lato",
                          color: Colors.black,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ),
              //probando si el genreal button da palo
              GeneralButton(
                  "images/iconos/google.jpg", 50, 300, "Sign In With Google",
                  () {
                userBloc.signOut();
                userBloc.signIn().then((FirebaseUser user) {
                  userBloc.updateData(User(
                    uid: user.uid,
                    name: user.displayName,
                    email: user.email,
                    photoURL: user.photoUrl,
                    myOrders: null,
                    //myFavoriteProducts: null,
                    //myCart: null
                  ));
                });
                //_localAuth.authenticate;
              }),
            ],
          )
        ],
      ),
    );
  }
}

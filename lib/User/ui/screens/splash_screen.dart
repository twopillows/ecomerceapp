import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:generic_bloc_provider/generic_bloc_provider.dart';
import 'package:ecomerceapp/User/bloc/bloc_user.dart';
import 'package:ecomerceapp/tienda_principal_cupertino.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  UserBloc userBloc;

  @override
  void initState() {
    Future.delayed(Duration(seconds: 3), () {
      userBloc.currentUser
          .then((currentUser) => {
                if (currentUser == null)
                  {Navigator.pushReplacementNamed(context, "/login")}
                else
                  {
                    Firestore.instance
                        .collection("users")
                        .document(currentUser.uid)
                        .get()
                        .then((DocumentSnapshot result) =>
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        TiendaPrincipalCupertino(
                                          uid: currentUser.uid,
                                        ))))
                        .catchError((err) => print(err))
                  }
              })
          .catchError((err) => print(err));
      super.initState();
    });
  }

  @override
  Widget build(BuildContext context) {
    userBloc = BlocProvider.of<UserBloc>(context);
    return Container(
      color: Colors.red,
    );
  }
}

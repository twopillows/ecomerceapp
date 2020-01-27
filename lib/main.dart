import 'dart:async';
import 'package:flutter/material.dart';
import 'package:ecomerceapp/User/bloc/bloc_user.dart';
import 'package:ecomerceapp/User/ui/screens/account.dart';
import 'package:ecomerceapp/User/ui/screens/sign_in_screen.dart';
import 'package:ecomerceapp/User/ui/screens/splash_screen.dart';
import 'package:ecomerceapp/temp/LocalAuth/service_locator.dart';
import 'package:ecomerceapp/temp/login_screen.dart';
import 'package:ecomerceapp/temp/registrer_screen.dart';
import 'platzi_trips.dart';
import 'tienda_principal_cupertino.dart';
import 'package:generic_bloc_provider/generic_bloc_provider.dart';

//void main() => runApp(MyApp());

void main() {
  setupLocator();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      child: MaterialApp(
        routes: {
          '/register': (BuildContext context) => RegistrerScreen(),
          '/login': (BuildContext context) => LoginScreen(),
          '/splash': (BuildContext context) => SplashScreen(),
          '/account': (BuildContext context) => Account(),
          '/home': (BuildContext context) => TiendaPrincipalCupertino(),
        },
        debugShowCheckedModeBanner: false,
        theme: ThemeData(backgroundColor: Colors.transparent),
        title: 'Flutter Demo',
        home: SplashScreen(),
      ),
      bloc: UserBloc(),
    );
  }
}

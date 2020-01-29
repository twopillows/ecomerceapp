import 'package:flutter/material.dart';
import 'package:ecomerceapp/User/bloc/bloc_user.dart';
import 'package:ecomerceapp/User/ui/screens/account.dart';
import 'package:ecomerceapp/User/ui/screens/splash_screen.dart';
import 'package:ecomerceapp/User/ui/screens/login_screen.dart';
import 'package:ecomerceapp/User/ui/screens/registrer_screen.dart';
import 'tienda_principal_cupertino.dart';
import 'package:generic_bloc_provider/generic_bloc_provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
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

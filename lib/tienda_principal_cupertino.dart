import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:generic_bloc_provider/generic_bloc_provider.dart';
import 'package:ecomerceapp/User/ui/screens/favorites.dart';
import 'package:ecomerceapp/User/bloc/bloc_user.dart';
import 'package:ecomerceapp/User/ui/screens/account.dart';
import 'package:ecomerceapp/Product/ui/screens/home_screen.dart';

class TiendaPrincipalCupertino extends StatefulWidget {
  final String uid;

  TiendaPrincipalCupertino({Key key, this.uid}) : super(key: key);

  @override
  _TiendaPrincipalCupertinoState createState() =>
      _TiendaPrincipalCupertinoState();
}

class _TiendaPrincipalCupertinoState extends State<TiendaPrincipalCupertino> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      bottomNavigationBar: CupertinoTabScaffold(
        tabBar: CupertinoTabBar(
          items: [
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.home,
                  color: Colors.blue,
                ),
                title: Text("Home")),
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.favorite,
                  color: Colors.blue,
                ),
                title: Text("Favorites")),
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.account_circle,
                  color: Colors.blue,
                ),
                title: Text("Account"))
          ],
        ),
        tabBuilder: ((BuildContext context, int index) {
          switch (index) {
            case 0:
              return CupertinoTabView(
                builder: (BuildContext context) => BlocProvider(
                  bloc: UserBloc(),
                  //child: HomePage(),
                  child: HomeScreen(uid: widget.uid),
                ),
              );
            case 1:
              return CupertinoTabView(
                builder: (BuildContext context) => BlocProvider(
                  child: Favorites(),
                  bloc: UserBloc(),
                ),
              );
            case 2:
              return CupertinoTabView(
                builder: (BuildContext context) => BlocProvider(
                  bloc: UserBloc(),
                  child: Account(),
                ),
              );
          }
        }),
      ),
    );
  }
}

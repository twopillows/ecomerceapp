import 'package:flutter/material.dart';
import 'package:ecomerceapp/User/ui/screens/cart.dart';
import 'package:ecomerceapp/widgets/gradient_back.dart';

class GradientAppBar extends StatelessWidget {
  final String title;
  final double barHeight = 30.0;

  GradientAppBar(this.title);

  @override
  Widget build(BuildContext context) {
    final double statusBarHeight = MediaQuery.of(context).padding.top;
    return SafeArea(
      child: Container(
        color: Color(0xFF108CED),
        padding: EdgeInsets.only(top: statusBarHeight + 10),
        child: AppBar(
          elevation: 0.1,
          backgroundColor: Color(0xFF108CED),
          centerTitle: true,
          title: InkWell(
            /*onTap: () {
                      Navigator.push(
                          context, MaterialPageRoute(builder: (context) => App()));
                    },*/
            child: Text(
              'Swap Trendy',
              style: TextStyle(color: Colors.black),
            ),
          ),
          actions: <Widget>[
            IconButton(
                icon: Icon(
                  Icons.search,
                  color: Colors.black,
                ),
                onPressed: null),
            IconButton(
              icon: Icon(
                Icons.shopping_cart,
                color: Colors.black,
              ),
              onPressed: () {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (context) => Cart()));
              },
            )
            //Aqui esta l icono de busqueda q quiero pone abajo en una barra
            //pa eso tngo q aumentar el height del appbar
          ],
          iconTheme: IconThemeData(color: Colors.black),
          // el color de los botones puede ponersse en cada iconButton como
          // //atributo del icon o con icontheme pa  sea pa todos
        ),
      ),
    );
    /*return Container(
      padding: EdgeInsets.only(top: statusBarHeight),
      height: statusBarHeight + barHeight,
      child: Row(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: BackButton(),
          ),
          Expanded(
            child: Center(
              child: Text(
                title,
                style: TextStyle(
                    fontSize: 20.0,
                    color: Colors.white,
                    fontWeight: FontWeight.bold),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: BackButton(),
          ),
        ],
      ),
      decoration: BoxDecoration(
        gradient: LinearGradient(
            colors: [
              Color(0xFF0060FF),
              Color(0xFF00A1FF),
              //Colors.red, Colors.blue
            ],
            begin: const FractionalOffset(0.0, 0.0),
            end: const FractionalOffset(0.5, 0.0),
            stops: [0.0, 1.0],
            tileMode: TileMode.clamp),
      ),
    );*/
  }
}

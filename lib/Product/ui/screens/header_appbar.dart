import 'package:flutter/material.dart';

class HeaderAppBarr extends StatefulWidget {
  @override
  State createState() {
    return _HeaderAppBar();
  }
}

class _HeaderAppBar extends State<HeaderAppBarr> {
  @override
  Widget build(BuildContext context) {
    return AppBar();
  }
}

/*
class HeaderAppBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Stack(
      children: <Widget>[
        GradientBack(60, 0, ""),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: <Widget>[
              Expanded(child: BackButtonWidget()),
              Expanded(
                  child: Text(
                "Swap Trendy",
                style: TextStyle(fontSize: 25),
              )),
              Expanded(child: Icon(Icons.arrow_back_ios))
            ],
          ),
        ),

        //CardImageList()
      ],
    );
  }
}
*/

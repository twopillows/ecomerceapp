import 'package:flutter/material.dart';

class GeneralButton extends StatefulWidget {
  double width = 0.0;
  double height = 0.0;
  final String text;
  final VoidCallback onPressed;
  String iconPath;


  @override
  State createState() => _GeneralButton();

  GeneralButton( @required this.iconPath, @required this.height, @required this.width,
      @required this.text, @required this.onPressed);

}

class _GeneralButton extends State<GeneralButton> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: widget.onPressed,
      child: Container(
        margin: EdgeInsets.only(top: 10.0, left: 20.0, right: 20.0),
        width: widget.width,
        height: widget.height,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.0),
            gradient: LinearGradient(
                colors: [
                  Colors.white,
                  Colors.white
                  //Color(0xFFa7ff84), //arriba
                  //Color(0xFF1cbb78) //bajo
                ],
                begin: FractionalOffset(0.2, 0.0),
                end: FractionalOffset(1.0, 0.6),
                stops: [0.0, 0.6],
                tileMode: TileMode.clamp)),
        child: Row(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.fromLTRB(18.0,0,0,0),
              child: IconButton(
                icon: new Image.asset(widget.iconPath),
                //tooltip: 'Closes application',
                onPressed: () {},
              ),
            ),
            Expanded(
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(0,8,8,8),
                  child: Text(
                    widget.text,
                    style: TextStyle(
                        fontSize: 18.0,
                        fontFamily: "Lato",
                        color: Colors.black,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}


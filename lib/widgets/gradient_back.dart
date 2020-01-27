import 'package:flutter/material.dart';

class GradientBack extends StatelessWidget {

  double height;
  double width;
  final String title;

  GradientBack({Key key,@required this.height, this.width, @required this.title});


  @override
  Widget build(BuildContext context) {

    if(height == null){
      height = MediaQuery.of(context).size.height;
    }
    // TODO: implement build
    return Container(
      height: height,
      decoration: BoxDecoration(
        gradient: LinearGradient(
            colors: [
              Color(0xFF0060FF),
              Color(0xFF00A1FF),
              //Color(0xFF4268D3),
              //Color(0xFF584CD1)
            ],
          begin: FractionalOffset(0.2, 0.0),
          end: FractionalOffset(1.0, 0.6),
            stops: [0.0, 0.6],
            tileMode: TileMode.clamp
        ),
      ),


      child: Padding(
        padding: EdgeInsets.fromLTRB(
            16, MediaQuery.of(context).padding.top + 28, 16, 0),
        child: Center(
          child: Text(
            title,
            style: TextStyle(
              color: Colors.white,
              fontSize: 30.0,
              fontFamily: "Lato",
              fontWeight: FontWeight.bold
            ),
          ),
        ),
      ),

      alignment: Alignment(-0.9, -0.6),

    );
  }

}
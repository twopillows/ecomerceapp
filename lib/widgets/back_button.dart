import 'package:flutter/material.dart';

class BackButtonWidget extends StatelessWidget{

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 20,
      height: 20,
      child: InkWell(
        onTap: (){},
        child: Icon(
          Icons.arrow_back_ios,
        ),
      ),
    );
  }
}
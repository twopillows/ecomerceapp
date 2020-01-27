import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:ecomerceapp/widgets/size_config.dart';

class ImageCarousel extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return CarouselSlider(
      autoPlay: false,
      autoPlayAnimationDuration: Duration(seconds: 3),
      items: imagesPath.map((it) {
        return ClipRRect(
          borderRadius: BorderRadius.all(Radius.circular(20.0)),
          child: Stack(
            children: <Widget>[
              Container(
                height: SizeConfig.safeBlockVertical * 27,
                //height: 170.0,
                width: SizeConfig.safeBlockHorizontal * 72,
                //width: 290,
                child: Image.asset(
                  it,
                  //fit: BoxFit.,
                  fit: BoxFit.cover,
                ),
              )
            ],
          ),
        );
      }).toList(),
      height: SizeConfig.safeBlockVertical * 27,
      //height: 170.0,
    );
  }

  List<String> imagesPath = [
    "images/images/banner/perrobanner1.png",
    "images/images/banner/banner2.jpg",
    "images/images/banner/banner3.jpeg",
  ];
}

/*    "images/chewy/1.jpg",
    "images/chewy/2.jpg",
    "images/chewy/3.jpg",
    "images/chewy/4.jpg",
    "images/chewy/5.jpg",*/

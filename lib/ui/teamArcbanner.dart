import 'package:flutter/material.dart';
import 'package:weplayball/ui/arcClipper.dart';

class ArcBannerImage extends StatelessWidget {
  // if team has banner
  //ArcBannerImage(this.imageUrl);
  //final String imageUrl;
  ArcBannerImage();

  @override
  Widget build(BuildContext context) {

    var screenWidth = MediaQuery.of(context).size.width;

    return ClipPath(
      //AssetImage('graphics/profile.png'),
      clipper: ArcClipper(),
      child: Image.asset(
        'graphics/weplayball-loading-screen.jpg',
        width: screenWidth,
        height: 230.0,
        fit: BoxFit.cover,

      ),
    );
  }

}
import 'package:flutter/material.dart';
import 'package:weplayball/models/fixture.dart';
import 'package:weplayball/ui/colors.dart';
import 'package:weplayball/ui/fixtureBoard.dart';
import 'package:weplayball/ui/layout.dart';

class TeamNextFixture extends StatelessWidget{

  final FixtureModel fixtureModel;
  final String assetBaseUrl;

  TeamNextFixture(
      this.fixtureModel,
      this.assetBaseUrl
      );

  @override
  Widget build(BuildContext context) {
    return _buildView();
  }

  Column _buildView()
  {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        SizedBox(
          height: 24,
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.0),
          child: Text(
            "Next Match",
            textAlign: TextAlign.left,
            style: TextStyle(
              fontWeight: FontWeight.w900,
              fontFamily: 'Poppins',
              color: Color(getColourHexFromString(primaryBlack)),
              fontSize: fontSizeH4,
            ),
          ),
        ),
        SizedBox(
          height: 8.0,
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.0),
          child: Container(
            alignment: Alignment.center,
            //padding: new EdgeInsets.all(8.0),
            height: 150.0,
            decoration: new BoxDecoration(
              color: Colors.white,
              image: DecorationImage(
                image:  AssetImage("graphics/stat-result-card-bg.png"),
                fit: BoxFit.cover,
              ),
              borderRadius: new BorderRadius.all(new Radius.circular(10.0)),
              boxShadow: [
                new BoxShadow(color: Color(getColourHexFromString(primaryMediumGrey)),
                    offset: new Offset(2.0, 5.0),
                    blurRadius: 7.0)
              ]
            ),
            child: FixtureBoard(
                fixtureModel,
                assetBaseUrl,
                true
            ),
          ),
          /*Material(
            elevation: 0.25,
            borderRadius: BorderRadius.all(Radius.circular(stdBorderRadius)),
            color: Colors.white,
            child: Container(
              padding: const EdgeInsets.all(8.0),
              child: FixtureBoard(
                  fixtureModel,
                  assetBaseUrl,
                  true
              ),
            ),
          ),*/
        ),
      ],
    );

  }
}
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
          height: 4,
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.0),
          child: Material(
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
          ),
        ),
      ],
    );

  }
}
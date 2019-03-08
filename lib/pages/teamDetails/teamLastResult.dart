import 'package:flutter/material.dart';
import 'package:weplayball/models/result.dart';
import 'package:weplayball/ui/colors.dart';
import 'package:weplayball/ui/layout.dart';
import 'package:weplayball/ui/resultBoard.dart';

class TeamLastResult extends StatelessWidget{

  final ResultModel lastResult;
  final String assetBaseUrl;

  TeamLastResult(
      this.lastResult,
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
            "Last Result",
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
            height: 160.0,
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
            child: ResultBoard(
                lastResult,
                assetBaseUrl,
                true
            ),
          ),
        ),
      ],
    );

  }
}
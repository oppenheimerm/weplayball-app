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
          child: Material(
            elevation: 0.25,
            borderRadius: BorderRadius.all(Radius.circular(stdBorderRadius)),
            color: Colors.white,
            child: Container(
              padding: const EdgeInsets.all(8.0),
              child: ResultBoard(
                  lastResult,
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
import 'package:flutter/material.dart';
import 'package:weplayball/models/result.dart';
import 'package:weplayball/pages/teamDetails/teamResultsAll.dart';
import 'package:weplayball/ui/colors.dart';
import 'package:weplayball/ui/layout.dart';
import 'package:weplayball/ui/resultBoard.dart';

class TeamLastResult extends StatelessWidget{

  final ResultModel lastResult;
  final String assetBaseUrl;
  final String homeTeamCode;

  TeamLastResult(
      this.lastResult,
      this.homeTeamCode,
      this.assetBaseUrl,
      );

  void _handleTap(BuildContext context, String teamCode){
    print("fetching upcomming matches for: $teamCode") ;
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => TeamResultsAll(teamCode, assetBaseUrl)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return _buildView(context);
  }

  Column _buildView(BuildContext context)
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
        SizedBox(
          height: 8.0,
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.0),
          child: InkWell(
            onTap: () => _handleTap(context, homeTeamCode),
            child: Align(
              alignment: Alignment.centerRight,
              child: Text(
                "View All",
                textAlign: TextAlign.end,
                style: TextStyle(
                  fontWeight: FontWeight.w900,
                  color: Color(getColourHexFromString(primaryBlue)),
                  fontSize: fontSizeH4,
                ),
              ),
            ),
          ),
        )
      ],
    );

  }
}
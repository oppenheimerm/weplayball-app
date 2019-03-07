import 'package:flutter/material.dart';
import 'package:flutter_advanced_networkimage/flutter_advanced_networkimage.dart';
import 'package:weplayball/models/teamDetails.dart';
import 'package:weplayball/ui/arcClipper.dart';
import 'package:weplayball/ui/colors.dart';
import 'package:weplayball/ui/layout.dart';
import 'package:weplayball/ui/sharedHeader.dart';


class HeadToHeadView extends StatelessWidget{

  const HeadToHeadView(this.homeTeamData, this.awayTeamData, this.assetBaseUrl,{ Key key}) : super(key: key);

  final TeamDetailsModel homeTeamData;
  final TeamDetailsModel awayTeamData;
  final String assetBaseUrl;

  @override
  Widget build(BuildContext context) {
    // Rendered in order added to array

    //  Add some top padding
    var widgetList = <Widget>[];

    widgetList.add(_buildHead());

    widgetList.add(
      SizedBox(
        height: 24,
      ),
    );
    widgetList.add(
        _buildTitleRow(
          homeTeamData,
          awayTeamData
        )
    );

    widgetList.add(
        buildStatRow(homeTeamData, awayTeamData, "Stat Title")
    );



    return Container(
      decoration: BoxDecoration(
        gradient: new LinearGradient(colors: [gradientStart, gradientEnd],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          stops: [0.0,1.0],
        ),
      ),
      child: MainHeader(widgetList, context),
    );
  }

  Container _buildHead(){
    return Container(
      child: Stack(
        children: <Widget>[
          ClipPath(
            clipper: ArcClipper(),
            child: Container(
              color: Color(getColourHexFromString(primaryDarkGrey)),
              height: 300,
            ),
          ),
          Column(
            children: <Widget>[
              SizedBox(
                height: 28.0,
              ),
              Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(8.0))
                ),
                margin: EdgeInsets.symmetric(horizontal: 16.0),
                elevation: 3.0,
                color: Colors.white,
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 30.0, vertical: 22.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    children: <Widget>[
                      SizedBox(
                        height: 24,
                      ),
                      Center(
                        child:_getLogo(
                            homeTeamData,
                            assetBaseUrl
                        ),
                      ),
                      SizedBox(
                        height: 4.0,
                      ),
                      Text(
                        homeTeamData.teamName.toUpperCase(),
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontWeight: FontWeight.w900,
                          color: Color(getColourHexFromString(primaryBlack)),
                          fontSize: fontSizeH4,
                        ),
                      ),
                      SizedBox(
                        height: 4.0,
                      ),
                      Text(
                        homeTeamData.teamCode.toUpperCase(),
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontWeight: FontWeight.w300,
                          color: Color(getColourHexFromString(primaryBlack)),
                          fontSize: fontSizeH5,
                        ),
                      ),
                      SizedBox(
                        height: 4.0,
                      ),
                      Text(
                        "Rank: ${homeTeamData.rank.toString()}",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontWeight: FontWeight.w900,
                          color: Color(getColourHexFromString(primaryBlack)),
                          fontSize: fontSizeH4,
                        ),
                      ),
                      SizedBox(
                        height: 24.0,
                      ),
                      Text(
                        "Vs",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontWeight: FontWeight.w300,
                          fontFamily: 'Poppins',
                          color: Color(getColourHexFromString(primaryBlack)),
                          fontSize: fontSizeH2,
                        ),
                      ),
                      SizedBox(
                        height: 24.0,
                      ),
                      Center(
                        child:_getLogo(
                            awayTeamData,
                            assetBaseUrl
                        ),
                      ),
                      SizedBox(
                        height: 4.0,
                      ),
                      Text(
                        awayTeamData.teamName.toUpperCase(),
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontWeight: FontWeight.w900,
                          color: Color(getColourHexFromString(primaryBlack)),
                          fontSize: fontSizeH4,
                        ),
                      ),
                      SizedBox(
                        height: 4.0,
                      ),
                      Text(
                        awayTeamData.teamCode.toUpperCase(),
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontWeight: FontWeight.w300,
                          fontFamily: 'Poppins',
                          color: Color(getColourHexFromString(primaryBlack)),
                          fontSize: fontSizeH5,
                        ),
                      ),
                      SizedBox(
                        height: 4.0,
                      ),
                      Text(
                        "Rank: ${awayTeamData.rank.toString()}",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontWeight: FontWeight.w900,
                          color: Color(getColourHexFromString(primaryBlack)),
                          fontSize: fontSizeH4,
                        ),
                      ),
                      SizedBox(
                        height: 28.0,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }


  _getLogo(TeamDetailsModel teamDetails, String assetBaseUrl)
  {

    var hasLogo = teamDetails.hasLogo;
    if(hasLogo)
    {
      return Material(
          elevation: 0.0,
          child: Image(
            image: AdvancedNetworkImage(
              assetBaseUrl + teamDetails.logo,
            ),
            fit: BoxFit.contain,
            width: 100.0,
          )
      );
    }
    else{
      return Material(
        borderRadius: BorderRadius.circular(4.0),
        elevation: 0.0,
        child: Container(
          width: 100.0,
          color: Colors.transparent,
          child: Container(
            padding: EdgeInsets.fromLTRB(10.0, 20.0, 10.0, 20.0),
            decoration: BoxDecoration(
              color: Color(getColourHexFromString(primaryBlack)),
              borderRadius: BorderRadius.all(
                  Radius.circular(100.0)
              ),
            ),
            child: Center(
              child: Text(
                teamDetails.teamCode,
                style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ),
      );
    }
  }


  Padding _buildTitleRow(TeamDetailsModel homeTeam, TeamDetailsModel awayTeam)
  {

    return Padding(
      padding: EdgeInsets.all(8.0),
      child: Material(
        elevation: 0.25,
        borderRadius: BorderRadius.all(Radius.circular(stdBorderRadius)),
        color: Colors.white,
        child: Row(
          children: <Widget>[
            Expanded(
              child: buildTeamCell(
                  CrossAxisAlignment.start,
                  homeTeam.teamCode,
              ),
            ),
            /*Expanded(
              child: buildDetailCell(
                homeTeam.teamName,
                awayTeam.teamName,
              ),
            ),*/
            Expanded(
              child:
              buildTeamCell(
                  CrossAxisAlignment.end,
                  awayTeam.teamCode,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Column buildTeamCell(CrossAxisAlignment alignment,
      String teamCode)
  {
    Widget team;

    team = teamDetails(teamCode);

    return new Column(
      crossAxisAlignment: alignment,
      children: <Widget>[
        team
      ],
    );
  }

  teamDetails(String teamCode)
  {
    return Container(
      width: 100.0,
      padding: const EdgeInsets.all(12.0),
      child: Column(
        children: <Widget>[
          addSizedBoxPadding(20.0, 0),
          Center(
            child: Text(
                teamCode,
                style: TextStyle(
                  fontSize: fontSizeH3,
                  fontWeight: FontWeight.bold,
                  color: Color(getColourHexFromString(primaryBlack)),
                )
            ),
          ),
          //  add some padding
          addSizedBoxPadding(20.0, 0),
        ],
      ),
    );
  }

  //  just testing design here
  Container buildStatRow(TeamDetailsModel teamHome, TeamDetailsModel teamAway, String statTitle){
    return Container(
      alignment: Alignment.centerLeft,
      margin: new EdgeInsets.all(8.0),
      padding: new EdgeInsets.all(8.0),
      height: 150.0,
      decoration: new BoxDecoration(
          color: Colors.white,
          image: DecorationImage(
            image:  AssetImage("graphics/stat-result-card-bg.png"),
            fit: BoxFit.cover,
          ),
          borderRadius: new BorderRadius.all(new Radius.circular(10.0)),
          boxShadow: [
            new BoxShadow(color: Color(getColourHexFromString(primaryGrey)),
                offset: new Offset(2.0, 5.0),
              blurRadius: 7.0)
          ]
      ),
      child: Row(
        children: <Widget>[
          Expanded(
            child: buildStatCell(
              CrossAxisAlignment.start,
              teamHome.wPyth,
            ),
          ),
          Expanded(
              child: buildStatDetailCell(
                "wPyth"
              ),
          ),
          Expanded(
            child: buildStatCell(
              CrossAxisAlignment.start,
              teamAway.wPyth,
            ),
          ),
        ],
      ),
    );

    //Material
  }

  statValue(String statValue)
  {
    return Container(
      width: 100.0,
      padding: const EdgeInsets.all(12.0),
      child: Column(
        children: <Widget>[
          addSizedBoxPadding(20.0, 0),
          Center(
            child: Text(
                statValue,
                style: TextStyle(
                  fontSize: fontSizeH3,
                  fontWeight: FontWeight.bold,
                  color: Color(getColourHexFromString(primaryBlack)),
                )
            ),
          ),
          //  add some padding
          addSizedBoxPadding(20.0, 0),
        ],
      ),
    );
  }

  Column buildStatCell(CrossAxisAlignment alignment,
      String statVal)
  {
    Widget team;

    team = statValue(statVal);

    return new Column(
      crossAxisAlignment: alignment,
      children: <Widget>[
        team
      ],
    );
  }

  Column buildStatDetailCell(String statTitle)
  {
    return new Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Center(
          child: Text(
              statTitle,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: fontSizeH4,
                fontWeight: FontWeight.bold,
                color: Color(getColourHexFromString(primaryBlack)),
              )
          ),
        ),
      ],
    );
  }


}





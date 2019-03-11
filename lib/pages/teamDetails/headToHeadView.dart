import 'package:flutter/material.dart';
import 'package:flutter_advanced_networkimage/flutter_advanced_networkimage.dart';
import 'package:weplayball/models/teamDetails.dart';
import 'package:weplayball/ui/arcClipper.dart';
import 'package:weplayball/ui/colors.dart';
import 'package:weplayball/ui/layout.dart';
import 'package:weplayball/ui/sharedHeader.dart';


class HeadToHeadView extends StatelessWidget{

  HeadToHeadView(this.homeTeamData, this.awayTeamData, this.assetBaseUrl,{ Key key}) : super(key: key);

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

    //  _buildStatListView
    //  our head to head stat data
    var statData = _buildHeadToHeadStats().toList();

    statData.forEach((item) => {
      widgetList.add(
        buildStatRow(item.homeTeamStatValue,item.awayTeamStatValue, item.statTitle)
      )
    });



    return Container(
      decoration: BoxDecoration(
        gradient: new LinearGradient(colors: [gradientStart, gradientEnd],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          stops: [0.0,1.0],
        ),
      ),
      child: MainHeader(widgetList, context, false, null),
    );

  }

  Container _buildHead(){
    return Container(
      child: Stack(
        children: <Widget>[
          ClipPath(
            clipper: ArcClipper(),
            child: Container(
              color: Color(getColourHexFromString(primaryLightGrey)),
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

  //  Should be able to remove
  Container buildStatRow(String homeTeamValue, String awayTeamValue, String statTitle){
    return Container(
      alignment: Alignment.centerLeft,
      margin: new EdgeInsets.all(8.0),
      padding: new EdgeInsets.all(8.0),
      height: 120.0,
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
      child: Row(
        children: <Widget>[
          Expanded(
            child: buildStatCell(
              CrossAxisAlignment.start,
                homeTeamValue
            ),
          ),
          Expanded(
              child: buildStatDetailCell(
                  statTitle
              ),
          ),
          Expanded(
            child: buildStatCell(
              CrossAxisAlignment.start,
              awayTeamValue,
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
          child: Padding(
            padding: const EdgeInsets.only(top:32.0),
            child: Text(
                statTitle,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: fontSizeH4,
                  fontWeight: FontWeight.w300,
                  color: Color(getColourHexFromString(primaryBlack)),
                )
            ),
          ),
        ),
      ],
    );
  }


  List<StatDataRow> _buildHeadToHeadStats()
  {
    List<StatDataRow> headToHeadStats = new List();

    //  W%
    StatDataRow _buildTeamWinPercent()
    {
      var teamStatModel = new StatDataRow(
          homeTeamData.winPercentage,
          awayTeamData.winPercentage,
          "Win Percent"
      );
      return teamStatModel;
    }
    var winPercent = _buildTeamWinPercent();
    headToHeadStats.add(winPercent);

    StatDataRow _buildTeamLossPercent()
    {
      var teamStatModel = new StatDataRow(
          homeTeamData.lossPercentage,
          awayTeamData.lossPercentage,
          "Loss Percent"
      );
      return teamStatModel;
    }
    var lossPercent = _buildTeamLossPercent();
    headToHeadStats.add(lossPercent);

    StatDataRow _buildTeamBasketsPerGame()
    {
      var teamStatModel = new StatDataRow(
          homeTeamData.basketsPerGame,
          awayTeamData.basketsPerGame,
          "Baskets Per Game"
      );
      return teamStatModel;
    }
    var bpg = _buildTeamBasketsPerGame();
    headToHeadStats.add(bpg);

    StatDataRow _buildTeamWinLossPercent()
    {
        var teamStatModel = new StatDataRow(
          homeTeamData.winLossPercent,
          awayTeamData.winLossPercent,
          "Win / Loss Percent"
        );
        return teamStatModel;
    }
    var winlosspercent = _buildTeamWinLossPercent();
    headToHeadStats.add(winlosspercent);

    StatDataRow _buildWinOver500()
    {
      var teamStatModel = new StatDataRow(
        homeTeamData.winsOver500,
        awayTeamData.winsOver500,
        "Wins over .500"
      );
      return teamStatModel;
    }
    var winsOver500 = _buildWinOver500();
    headToHeadStats.add(winsOver500);

    StatDataRow _buildTeamWPyth()
    {
      var teamStaModel = new StatDataRow(
          homeTeamData.wPyth,
          awayTeamData.wPyth,
          "Pythagorean Wins"
      );
      return teamStaModel;
    }
    var wypth = _buildTeamWPyth();
    headToHeadStats.add(wypth);

    StatDataRow _buildTeamBasketsFor(){
      var teamStatModel = new StatDataRow(
        homeTeamData.basketsFor.toString(),
        awayTeamData.basketsFor.toString(),
        "Baskers For"
      );
      return teamStatModel;
    }
    var bf = _buildTeamBasketsFor();
    headToHeadStats.add(bf);

    StatDataRow _buildTeamBasketsAganist(){
      var teamStatModel = new StatDataRow(
        homeTeamData.basketsAgainst.toString(),
        awayTeamData.basketsAgainst.toString(),
        "Basktes Aganist"
      );

      return teamStatModel;
    }
    var ba = _buildTeamBasketsAganist();
    headToHeadStats.add(ba);

    StatDataRow _buildTeamGameWon(){
      var teamStatModel = new StatDataRow(
        homeTeamData.gamesWon.toString(),
        awayTeamData.gamesWon.toString(),
        "Games Won"
      );
      return teamStatModel;
    }
    var gw = _buildTeamGameWon();
    headToHeadStats.add(gw);

    StatDataRow _gamesLost(){
      var teamStatModel = new StatDataRow(
        homeTeamData.gamesLost.toString(),
        awayTeamData.gamesLost.toString(),
        "Games Lost"
      );
      return teamStatModel;
    }
    var gl = _gamesLost();
    headToHeadStats.add(gl);

    StatDataRow _buildTeamGamesPlayed(){
      var teamStatModel = new StatDataRow(
        homeTeamData.gamesPlayed.toString(),
        awayTeamData.gamesPlayed.toString(),
        "Games Plaed"
      );
      return teamStatModel;
    }
    var gp = _buildTeamGamesPlayed();
    headToHeadStats.add(gp);



    //  return list
    return headToHeadStats;
  }


}



class StatDataRow{
  final String homeTeamStatValue;
  final String awayTeamStatValue;
  final String statTitle;

  StatDataRow(
      this.homeTeamStatValue,
      this.awayTeamStatValue,
      this.statTitle);
}





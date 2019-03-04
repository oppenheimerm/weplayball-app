import 'package:flutter/material.dart';
import 'package:weplayball/models/teamDetails.dart';
import 'package:weplayball/pages/teamDetails/teamDetailsHeader.dart';
import 'package:weplayball/pages/teamDetails/teamLastResult.dart';
import 'package:weplayball/pages/teamDetails/teamNextFixture.dart';
import 'package:weplayball/ui/colors.dart';
import 'package:weplayball/ui/sharedHeader.dart';
import 'package:weplayball/pages/teamDetails/teamAbout.dart';
import 'package:weplayball/pages/teamDetails/teamDetailsStats.dart';


class TeamView extends StatelessWidget{
  const TeamView({ Key key, this.teamData, this.assetBaseUrl}) : super(key: key);

  final TeamDetailsModel teamData;
  final String assetBaseUrl;

  @override
  Widget build(BuildContext context) {

    // Rendered in order added to array
    var widgetList = <Widget>[];

    //  1. Header
    widgetList.add(TeamDetailsHeader(teamData, assetBaseUrl));

    //  2. About
    var showAbout = hasAbout(teamData.about);
    if(showAbout)
    {
      widgetList.add(TeamAbout(teamData.about));
    }


    //  3. Next fixture
    widgetList.add(TeamNextFixture(teamData.nextMatch, assetBaseUrl));

    //  4. Last result
    widgetList.add(TeamLastResult(teamData.lastResult, assetBaseUrl));

    widgetList.add(TeamStats(teamData:teamData));

    return Container(
      decoration: BoxDecoration(
        gradient: new LinearGradient(colors: [gradientStart, gradientEnd],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          stops: [0.0,1.0],
        ),
      ),
      child: MainHeader(widgetList),
    );

    // Rendered in order added to array
    /*var widgetList = <Widget>[];
    widgetList.add(TeamDetailsHeader(teamData, assetBaseUrl));
    widgetList.add(TeamStats(teamData:teamData));
    widgetList.add(TeamAbout(about));

    //  build main layout with our standard shared main header widget
    return MainHeader(widgetList);*/
  }

  bool hasAbout(String about)
  {
    print("Team About value: ${about}");
    var result = (about == null) ? false : true;
    return result;
  }

/*Widget createView(BuildContext context, TeamDetailsModel data)
  {
    return Scaffold(
      body:SingleChildScrollView(
        child: Column(
          children: <Widget>[
            TeamDetailsHeader(teamData, assetBaseUrl),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: TeamAbout(about),
            ),
          ],
        ),
      ),
    );
  }*/

//  Go back
//  https://github.com/sergiandreplace/flutter_planets_tutorial/tree/Lesson_6_Planets_Flutter_Planet_detail
/*Container _getToolbar(BuildContext context) {
    return new Container(
      margin: new EdgeInsets.only(
          top: MediaQuery
              .of(context)
              .padding
              .top),
      child: new BackButton(color: Colors.white),
    );
  }*/

}
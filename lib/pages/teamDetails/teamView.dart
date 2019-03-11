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
  TeamView(this.teamData, this.assetBaseUrl, {Key key}) : super(key: key);

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
    widgetList.add(TeamNextFixture(teamData.nextMatch, teamData.teamCode, assetBaseUrl));

    //  4. Last result
    widgetList.add(
        TeamLastResult(teamData.lastResult, teamData.teamCode, assetBaseUrl)
    );

    widgetList.add(TeamStats(teamData));

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

  bool hasAbout(String about)
  {
    var result = (about == null) ? false : true;
    return result;
  }


}
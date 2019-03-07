import 'package:flutter/material.dart';
import 'package:flutter_advanced_networkimage/flutter_advanced_networkimage.dart';
import 'package:intl/intl.dart';
import 'package:weplayball/models/fixture.dart';
import 'package:weplayball/pages/teamDetails/teamDetails.dart';
import 'package:weplayball/ui/colors.dart';
import 'package:weplayball/ui/layout.dart';

//  Represents an instance of a team fixture
class FixtureBoard extends StatelessWidget
{
  final String assetBaseUrl;
  final FixtureModel fixtureModel;
  final bool disabledClickEvent;

  FixtureBoard(this.fixtureModel, this.assetBaseUrl, this.disabledClickEvent, { Key key }) : super(key: key);

  _handleTap(BuildContext context,String teamCode){
    print("fetching datat for team: ${teamCode}") ;
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => TeamDetailsPage(teamCode, assetBaseUrl)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return buildView(context, fixtureModel);
  }

  Row buildView(BuildContext context, FixtureModel fixtureModel)
  {
    return Row(
      children: <Widget>[
        Expanded(
          child: buildTeamCell(
              fixtureModel.homeTeamHasLogo,
              CrossAxisAlignment.start,
              fixtureModel.homeTeamName,
              fixtureModel.homeTeamCode,
              fixtureModel.homeTeamLogo,
              context
          ),
        ),
        Expanded(
          child: buildDetailCell(
              fixtureModel.fixtureDate,
              fixtureModel.division
          ),
        ),
        Expanded(
          child: buildTeamCell(
              fixtureModel.awayTeamHasLogo,
              CrossAxisAlignment.end,
              fixtureModel.awayTeamName,
              fixtureModel.awayTeamCode,
              fixtureModel.awayTeamLogo,
              context
          ),
        ),
      ],
    );

  }


  Column buildTeamCell(bool teamHasLogo, CrossAxisAlignment alignment,
      String teamName, String teamCode, String teamLogoUrl, BuildContext context)
  {
    Widget team;

    if (teamHasLogo == true) {
      team = buildTeamWithLogo(teamLogoUrl, teamName, teamCode, context);
    } else {
      team = teamNoLogo(teamName, teamCode, context);
    }

    return new Column(
      crossAxisAlignment: alignment,
      children: <Widget>[
        team
      ],
    );
  }

  Column buildDetailCell(DateTime time, String division)
  {
    return new Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        addSizedBoxPadding(40.0, 0),
        Center(
          child: Text(
              formatTime(time),
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: fontSizeH4,
                fontWeight: FontWeight.bold,
                color: Color(getColourHexFromString(primaryBlack)),
              )
          ),
        ),
        //  add some padding
        addSizedBoxPadding(4.0, 0),
        Text(
            division,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: fontSizeH5,
              color: Color(getColourHexFromString(primaryBlack)),
            )
        ),
      ],
    );
  }


  buildTeamWithLogo(String teamLogoUrl, String teamName, String teamCode, BuildContext context)
  {
    if(disabledClickEvent)
      {
        return Container(
          width: 110.0,
          padding: const EdgeInsets.all(4.0),
          child: Row(
            //  Putting a Column inside an Expanded widget stretches the
            //  column to use all remaining free space in the row.
            //  Setting the crossAxisAlignment property to CrossAxisAlignment.start
            //  positions the column at the start of the row.
            children: [
              Container(
                width: 100.0,
                padding: const EdgeInsets.all(18.0),
                child: Column(
                  children: <Widget>[
                    //Center(child: CircularProgressIndicator()),
                    Center(
                      //  flutter_advanced_networkimage 0.3.13
                      //  https://pub.dartlang.org/packages/flutter_advanced_networkimage#-readme-tab-
                      child: Image(
                        image: AdvancedNetworkImage(
                          assetBaseUrl + teamLogoUrl,
                        ),
                        width: 50.0,
                        height: 50.0,
                        fit: BoxFit.contain,
                      ),
                    ),
                    //  add some padding
                    addSizedBoxPadding(8.0, 0),
                    Center(
                      child:Text(
                        teamName,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: fontSizeH5,
                          fontWeight: FontWeight.bold,
                          color: Color(getColourHexFromString(primaryBlack)),
                        ),
                        softWrap: false,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      }
      else{
      return GestureDetector(
          onDoubleTap: () => _handleTap(context, teamCode),
          child: Container(
            width: 110.0,
            padding: const EdgeInsets.all(4.0),
            child: Row(
              //  Putting a Column inside an Expanded widget stretches the
              //  column to use all remaining free space in the row.
              //  Setting the crossAxisAlignment property to CrossAxisAlignment.start
              //  positions the column at the start of the row.
              children: [
                Container(
                  width: 100.0,
                  padding: const EdgeInsets.all(18.0),
                  child: Column(
                    children: <Widget>[
                      //Center(child: CircularProgressIndicator()),
                      Center(
                        //  flutter_advanced_networkimage 0.3.13
                        //  https://pub.dartlang.org/packages/flutter_advanced_networkimage#-readme-tab-
                        child: Image(
                          image: AdvancedNetworkImage(
                            assetBaseUrl + teamLogoUrl,
                          ),
                          width: 50.0,
                          height: 50.0,
                          fit: BoxFit.contain,
                        ),
                      ),
                      //  add some padding
                      addSizedBoxPadding(8.0, 0),
                      Center(
                        child:Text(
                          teamName,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: fontSizeH5,
                            fontWeight: FontWeight.bold,
                            color: Color(getColourHexFromString(primaryBlack)),
                          ),
                          softWrap: false,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          )
      );
    }
  }

  teamNoLogo(String teamName, String teamCode, BuildContext context)
  {
    if(disabledClickEvent)
      {
        return Container(
          width: 100.0,
          padding: const EdgeInsets.all(12.0),
          child: Column(
            children: <Widget>[
              SizedBox(
                height: 24,
              ),
              Center(
                child: Text(
                    teamCode,
                    style: TextStyle(
                      fontSize: fontSizeH2,
                      fontWeight: FontWeight.bold,
                      color: Color(getColourHexFromString(primaryBlack)),
                    )
                ),
              ),
              //  add some padding
              addSizedBoxPadding(15.0, 0),
              Center(
                child:Text(
                  teamName,
                  style: TextStyle(
                    fontSize: fontSizeH5,
                    fontWeight: FontWeight.bold,
                    color: Color(getColourHexFromString(primaryBlack)),
                  ),
                  //  Truncate String and add Ellipsis after character number
                  softWrap: false,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        );
      }
      else
        {
          return GestureDetector(
              onDoubleTap: () => _handleTap(context, teamCode),/* note () => _handleTap(teamCode) vs _handleTap(teamCode) !! */
              child:Container(
                width: 100.0,
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  children: <Widget>[
                    SizedBox(
                      height: 24,
                    ),
                    Center(
                      child: Text(
                          teamCode,
                          style: TextStyle(
                            fontSize: fontSizeH2,
                            fontWeight: FontWeight.bold,
                            color: Color(getColourHexFromString(primaryBlack)),
                          )
                      ),
                    ),
                    //  add some padding
                    addSizedBoxPadding(15.0, 0),
                    Center(
                      child:Text(
                        teamName,
                        style: TextStyle(
                          fontSize: fontSizeH5,
                          fontWeight: FontWeight.bold,
                          color: Color(getColourHexFromString(primaryBlack)),
                        ),
                        //  Truncate String and add Ellipsis after character number
                        softWrap: false,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              )
          );
        }
  }


  /*Expanded buildMiddle(DateTime time, String division)
  {
    var middleCell = new Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Center(
            child: Text(
                formatTime(time),
                style: TextStyle(
                  fontSize: fontSizeH3,
                  fontWeight: FontWeight.bold,
                  color: Color(getColourHexFromString(primaryBlack)),
                )
            ),
          ),
          //  add some padding
          addSizedBoxPadding(4.0, 0),
          Text(division),
        ],
      ),
    );

    return middleCell;

  }*/

  String formatTime(DateTime time){
    var timeText;
    //return DateFormat("EEE, MMM d, ''yy", "en_GB").format(time);
    return DateFormat("EEE, MMM d").format(time);
  }
}
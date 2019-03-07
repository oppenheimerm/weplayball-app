import 'package:flutter/material.dart';
import 'package:weplayball/models/teamDetails.dart';
import 'package:weplayball/pages/teamDetails/headToHeadView.dart';
import 'package:weplayball/service/request/apiRequest.dart';
import 'package:weplayball/service/response/parsedResponse.dart';
import 'package:weplayball/ui/colors.dart';
import 'package:weplayball/ui/layout.dart';

//  FixturesTab is a multi tab view page
class HeadToHead extends StatefulWidget  {

  final String _assetBaseUrl;
  final TeamDetailsModel homeTeamData;
  final String awayTeamCode;
  HeadToHead(this.homeTeamData, this.awayTeamCode, this._assetBaseUrl, { Key key }) : super(key: key);

  @override
  _HeadToHeadState createState() => _HeadToHeadState();
}

class _HeadToHeadState extends State<HeadToHead>
{
  var _apiRequest = new ApiRequest();
  //  The team we are comparing the home team to.
  static ParsedResponse<TeamDetailsModel> _awayTeamData;
  Widget _screen;

  Future updateAndGetData() async {
    var data = await _apiRequest.getTeamDetails(widget.awayTeamCode);
    return data;
  }

  Widget loadingView(){
    return new Center(
      child: new CircularProgressIndicator(),
    );
  }

  Widget updateDataState()
  {
    var view = (_awayTeamData.body == null)?
    Center(child:
    Text(
        'Could not retreview data',
        style: TextStyle(
          fontSize: 30.0,
          fontWeight: FontWeight.bold,
          color: Color(getColourHexFromString(primaryBlack)),
        )
    ),
    ) :
    new HeadToHeadView(widget.homeTeamData, _awayTeamData.body, widget._assetBaseUrl);

    return view;
  }

  @override
  Widget build(BuildContext context){
    _screen = Center(child: new CircularProgressIndicator());

    return new Container(
      padding: EdgeInsets.all(8.0),
      alignment: Alignment.center,
      child: FutureBuilder(
        future: updateAndGetData(),
        builder: (BuildContext context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.none:
              return new Text('Input a URL to start');
            case ConnectionState.waiting:
              return new Center(child: new CircularProgressIndicator());
            case ConnectionState.active:
              return new Center(child: new CircularProgressIndicator());
            case ConnectionState.done:
              if (snapshot.hasError) {
                //  DEBUG
                print("Error: ${snapshot.error}");
                return Center(
                  child: Text(
                      'Could not retreview data',
                      style: TextStyle(
                        fontSize: fontSizeInformational,
                        fontWeight: FontWeight.bold,
                        color: informationTextColour,
                      )
                  ),
                );

              } else {
                _awayTeamData = snapshot.data;
                //return Center(child: Text('team: ${_teamData.body.teamName}'));
                return buildView(context, snapshot );
              }
          }
        },
      ),
    );
  }

  Widget buildView(BuildContext context, AsyncSnapshot snapshot){
    var page = updateDataState();

    return page;
  }
}
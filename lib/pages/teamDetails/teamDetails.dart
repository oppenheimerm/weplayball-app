import 'dart:async';
import 'package:flutter/material.dart';
import 'package:weplayball/service/request/apiRequest.dart';
import 'package:weplayball/models/teamDetails.dart';
import 'package:weplayball/service/response/parsedResponse.dart';
import 'package:weplayball/ui/colors.dart';
import 'package:weplayball/ui/layout.dart';
import 'package:weplayball/ui/teamView.dart';

class TeamDetailsPage extends StatefulWidget {
  final String teamCode;
  final String assetBaseUrl;
  const TeamDetailsPage(this.teamCode, this.assetBaseUrl,{ Key key }) : super(key: key);
  @override
  _TeamDetailsPageState createState() => _TeamDetailsPageState();
}

class _TeamDetailsPageState extends State<TeamDetailsPage>
{
  var _apiRequest = new ApiRequest();
  static ParsedResponse<TeamDetailsModel> _teamData;
  Widget _screen;


  Future updateAndGetData() async {
    var data = await _apiRequest.getTeamDetails(widget.teamCode);
    return data;
  }

  Widget loadingView(){
    return new Center(
      child: new CircularProgressIndicator(),
    );
  }



  Widget updateDataState()
  {
    var view = (_teamData.body == null)?
    Center(child:
    Text(
        'Could not retreview data for team',
        style: TextStyle(
          fontSize: 30.0,
          fontWeight: FontWeight.bold,
          color: Color(getColourHexFromString(primaryBlack)),
        )
    ),
    ) :
    new TeamView(teamData: _teamData.body, assetBaseUrl: widget.assetBaseUrl);

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
                      'Could not retreview data for team',
                      style: TextStyle(
                        fontSize: fontSizeInformational,
                        fontWeight: FontWeight.bold,
                        color: informationTextColour,
                      )
                  ),
                );

              } else {
                _teamData = snapshot.data;
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
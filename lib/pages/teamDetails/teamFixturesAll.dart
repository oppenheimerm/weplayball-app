import 'dart:async';

import 'package:flutter/material.dart';
import 'package:weplayball/models/fixture.dart';
import 'package:weplayball/pages/teamDetails/teamFixturesAllView.dart';
import 'package:weplayball/service/request/apiRequest.dart';
import 'package:weplayball/service/response/parsedResponse.dart';
import 'package:weplayball/ui/colors.dart';
import 'package:weplayball/ui/layout.dart';

class TeamFixturesAll extends StatefulWidget{

  final String _homeTeamCode;
  final String _assetBaseUrl;

  TeamFixturesAll(this._homeTeamCode, this._assetBaseUrl,{ Key key }) : super(key: key);

  @override
  _TeamFixturesAllState createState() => _TeamFixturesAllState();
}

class _TeamFixturesAllState extends State<TeamFixturesAll>{

  var _apiRequest = new ApiRequest();
  static ParsedResponse<List<FixtureModel>> fixtureData;
  Widget _screen;

  Future updateAndGetData() async {
    var data = await _apiRequest.getTeamFixtures(widget._homeTeamCode);
    return data;
  }

  Widget loadingView(){
    return new Center(
      child: new CircularProgressIndicator(),
    );
  }

  updateDataState(){
    var view =
    (fixtureData.body.length == 0)?
    Center(child:
    Text(
        'No upcomming matches',
        style: TextStyle(
          fontSize: 30.0,
          fontWeight: FontWeight.bold,
          color: Color(getColourHexFromString(primaryBlack)),
        )
    ),
    ) :
    new TeamFixturesAllView(fixtureData.body, widget._assetBaseUrl);

    return view;
  }

  @override
  Widget build(BuildContext context) {
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
                fixtureData = snapshot.data;
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
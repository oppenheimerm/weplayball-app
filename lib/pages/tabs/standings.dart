import 'package:flutter/material.dart';
import 'package:weplayball/service/request/apiRequest.dart';
import 'package:weplayball/models/standings.dart';
import 'package:weplayball/pages/tabs/defaultTabController.dart';
import 'package:weplayball/service/response/parsedResponse.dart';
import 'package:weplayball/ui/colors.dart';
import 'package:weplayball/ui/standingView.dart';

//  FixturesTab is a multi tab view page
class StandingsTab extends StatefulWidget  {

  final String _assetBaseUrl;
  const StandingsTab(this._assetBaseUrl, { Key key }) : super(key: key);
  @override
  _StandingsTabState createState() => _StandingsTabState();
}

class _StandingsTabState extends State<StandingsTab> with SingleTickerProviderStateMixin {

  TabController _tabController;
  var _apiRequest = new ApiRequest();
  //var _assetBaseUrl = "https://weplayball.azurewebsites.net";
  static ParsedResponse<List<StandingsModel>> resultData;
  List<Widget> _screens;

  Future updateAndGetData() async {
    var data = await _apiRequest.getTeamStandings();
    return data;
  }

  @override
  void initState() {
    super.initState();
    _tabController = new TabController(vsync: this, length: 3/* for some reason I'm having to hard code*/);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  updateDataState()
  {
    var tab1 =
    (resultData.body.length == 0)?
    Center(child:
    Text(
        'Team standings data not found',
        style: TextStyle(
          fontSize: 30.0,
          fontWeight: FontWeight.bold,
          color: Color(getColourHexFromString(primaryBlack)),
        )
    ),
    ) :
    new StandingsView(resultData.body.where((i) => i.division == 1).toList(), widget._assetBaseUrl);

    var tab2 =
    (resultData.body.length == 0)?
    Center(child:
    Text(
        'Team standings data not found',
        style: TextStyle(
          fontSize: 30.0,
          fontWeight: FontWeight.bold,
          color: Color(getColourHexFromString(primaryBlack)),
        )
    ),
    ) :
    new StandingsView(resultData.body.where((i) => i.division == 2).toList(), widget._assetBaseUrl);;

    var tab3=
    (resultData.body.length == 0)?
    Center(child:
    Text(
        'Team standings data not found',
        style: TextStyle(
          fontSize: 30.0,
          fontWeight: FontWeight.bold,
          color: Color(getColourHexFromString(primaryBlack)),
        )
    ),
    ) :
    new StandingsView(resultData.body.where((i) => i.division == 3).toList(), widget._assetBaseUrl);

    _screens = [
      tab1,
      tab2,
      tab3
    ];
  }

  @override
  Widget build(BuildContext context) {
    _screens = [
      Center(child: new CircularProgressIndicator()),
      Center(child: new CircularProgressIndicator()),
      Center(child: new CircularProgressIndicator())
      //  screen will eventually take an instance
    ];

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
              return new Text('Hello');
            case ConnectionState.done:
              if (snapshot.hasError) {
                return new Text(
                  '${snapshot.error}',
                  style: TextStyle(color: Colors.red),
                );
              } else {
                resultData = snapshot.data;
                return buildTabsView(context, snapshot);
              }
          }
        },
      ),
    );
  }

  Widget buildTabsView(BuildContext context, AsyncSnapshot snapshot) {
    //print("buildTabsView() called");
    updateDataState();

    var tabs = [
      new Tab(text: "DIV 1"),
      new Tab(text: "DIV 2"),
      new Tab(text: "DIV 3")
    ];

    return SharedTabController(tabs,_tabController, _screens);

  }

}
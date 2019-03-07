import 'package:flutter/material.dart';
import 'package:weplayball/pages/tabs/defaultTabController.dart';
import 'package:weplayball/service/authenticationStatus.dart';
import 'package:weplayball/service/request/apiRequest.dart';
import 'package:weplayball/service/response/parsedResponse.dart';
import 'package:weplayball/ui/colors.dart';
import 'package:weplayball/ui/fixturesList.dart';
import 'package:weplayball/models/fixtureCollection.dart';

//  FixturesTab is a multi tab view page
class FixturesTab extends StatefulWidget  {

  final String _assetBaseUrl;
  final AuthStatus _authStatus;
  const FixturesTab(this._authStatus, this._assetBaseUrl,{ Key key }) : super(key: key);

  @override
  _FixturesTabState createState() => _FixturesTabState();
}

class  _FixturesTabState  extends State<FixturesTab> with SingleTickerProviderStateMixin
{
  TabController _tabController;
  var _apiRequest = new ApiRequest();
  //static var _assetBaseUrl = "https://weplayball.azurewebsites.net";
  static ParsedResponse<FixtureCollection> fixtureData;
  List<Widget> _screens;


  @override
  void initState() {
    super.initState();
    _tabController = new TabController(vsync: this, length: 3);
  }


  Future updateAndGetData() async {
    var data = await _apiRequest.getFixtures();
    return data;
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  //  Called when a dependency of this State object changes
  //  see: https://docs.flutter.io/flutter/widgets/SingleTickerProviderStateMixin/didChangeDependencies.html
  /*@override
  void didChangeDependencies() async {
    super.didChangeDependencies();
    var auth = AuthProvider.of(context).auth;
    auth.currentUser().then((user) {
      print("didChangeDependencies() called");
      setState(() {
        authStatus = (user.userId.toString().isEmpty) ? AuthStatus.notSignedIn : AuthStatus.signedIn;
      });
    });
  }*/


  updateDataState()
  {
    var tab1 =
    (fixtureData.body.firstDivision.length == 0)?
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
    new FixturesList(fixtureData:fixtureData.body.firstDivision, assetBaseUrl:widget._assetBaseUrl);

    var tab2 =
    (fixtureData.body.secondDivision.length == 0)?
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
    new FixturesList(fixtureData:fixtureData.body.secondDivision, assetBaseUrl:widget._assetBaseUrl);

    var tab3 =
    (fixtureData.body.thirdDivision.length == 0)?
    Center(child:
    Text(
        'No upcomming matches',
        style: TextStyle(
          fontSize: 30.0,
          fontWeight: FontWeight.bold,
          color: Color(getColourHexFromString(primaryBlack)),
        )
    )
    ) :
    new FixturesList(fixtureData:fixtureData.body.thirdDivision, assetBaseUrl:widget._assetBaseUrl);

    _screens = [
      tab1,tab2,tab3
    ];
  }

  Widget _buildView(){
    _screens = [
      Center(child: new CircularProgressIndicator()),
      Center(child: new CircularProgressIndicator()),
      Center(child: new CircularProgressIndicator())
      //  screen will eventually take an instance
      //  of ParsedResponse<FixtureCollection> fixtureData
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
                fixtureData = snapshot.data;
                return buildTabsView(context, snapshot);
              }
          }
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context){

    //print("authStatus: ${widget._authStatus.toString()}");
    return _buildView();
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

    //  https://github.com/flutter/flutter/issues/17459
    /*return new DefaultTabController(
      length: _screens.length,
      child: new Scaffold(
        appBar: new AppBar(
          //  https://github.com/flutter/flutter/issues/17459
          flexibleSpace: new Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              new TabBar(
                tabs: [
                  new Tab(text: "DIV 1"),
                  new Tab(text: "DIV 2"),
                  new Tab(text: "DIV 3")
                ],
                indicatorColor: Color(getColourHexFromString(primaryBlue)),
                isScrollable: true,
                controller: _tabController,
                labelColor: Color(getColourHexFromString(primaryBlack)),
              ),
            ],
          ),
          iconTheme: new IconThemeData(
              color: Color(getColourHexFromString(primaryBlack))),
          centerTitle: true,
          elevation: 0.025,
          backgroundColor: Color(getColourHexFromString(primaryWhiteGrey)),

        ),
        body: TabBarView(
          controller: _tabController,
          children: _screens,
        ),
      ),
    );*/
  }

}
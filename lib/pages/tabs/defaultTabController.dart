import 'package:flutter/material.dart';
import 'package:weplayball/ui/colors.dart';


//  Shared TabController widget
class SharedTabController extends StatelessWidget  {

  const SharedTabController(this._tabs, this._tabController, this._screens, { Key key }) : super(key: key);

  final TabController _tabController;
  final List<Tab> _tabs;
  final List<Widget> _screens;

  @override
  Widget build(BuildContext context) {

    //return new DefaultTabController(length: null, child: null);

    //  https://github.com/flutter/flutter/issues/17459
    return new DefaultTabController(
      length: _tabs.length,
      child: Scaffold(
        appBar: new AppBar(
          //  https://github.com/flutter/flutter/issues/17459
          flexibleSpace: new Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              new TabBar(
                tabs: _tabs,
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
          backgroundColor: Color(getColourHexFromString(primaryBlue)),

        ),
        body: TabBarView(
          controller: _tabController,
          children: _screens,
        ),
      ),
    );



  }
}
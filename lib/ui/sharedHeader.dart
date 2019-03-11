import 'package:flutter/material.dart';
import 'package:weplayball/ui/colors.dart';

//  Set up a standard top navigation bar and pass in an arry
//  of body widgets (viewWidgets)
class MainHeader extends StatelessWidget{
  const MainHeader(this.viewWidgets, this.context, this.isListView, this.container, { Key key}) : super(key: key);

  final List<Widget> viewWidgets;
  final BuildContext context;
  final bool isListView;
  final Container container;


  @override
  Widget build(BuildContext context) {

    if(isListView)
    {
      return Scaffold(
        appBar: AppBar(
          // KEEP SAME as main_page.dart
          title: Text(
            'WEPLAYBALL',
            style: TextStyle(
              fontFamily: 'Poppins',
              fontWeight: FontWeight.w700,
              letterSpacing: 0.8,
              fontSize: 15.0,
              color: Color(getColourHexFromString(primaryBlack)),
            ),
          ),
          iconTheme: new IconThemeData(
              color: Color(getColourHexFromString(primaryBlack))),
          centerTitle: true,
          elevation: 0.025,
          backgroundColor: Colors.white,
        ),
        body: container,
      );
    }else{
      return Scaffold(
        appBar: AppBar(
          // KEEP SAME as main_page.dart
          title: Text(
            'WEPLAYBALL',
            style: TextStyle(
              fontFamily: 'Poppins',
              fontWeight: FontWeight.w700,
              letterSpacing: 0.8,
              fontSize: 15.0,
              color: Color(getColourHexFromString(primaryBlack)),
            ),
          ),
          iconTheme: new IconThemeData(
              color: Color(getColourHexFromString(primaryBlack))),
          centerTitle: true,
          elevation: 0.025,
          backgroundColor: Colors.white,
        ),
        body: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Padding(
              padding: const EdgeInsets.only(bottom: 50.0),
              child: Column(
                children: viewWidgets,
              )
          ),
        ),
      );
    }

  }


}
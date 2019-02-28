import 'package:flutter/material.dart';
import 'package:weplayball/ui/colors.dart';
import 'package:weplayball/ui/layout.dart';


class GamesTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          DivisionSelector()
        ],
      ),
    );
  }
}
//  MOVE TO OWN FILE

// Stateful as we need to be able to change state
//  This represents the top part of tabs:
//
class DivisionSelector extends StatefulWidget {
  @override
  _DivisionSelectorState createState() => _DivisionSelectorState();
}

class _DivisionSelectorState extends State<DivisionSelector> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Container(
          height: 250.0,
          width: double.infinity,
          color: Color(getColourHexFromString(primaryOrange)),
        ),
        //  Create our bubble effect
        //  Control where the child of a stack is created
        Positioned(
          // bottom margin
          bottom: 50.0,
          //  right margin
          right: 100.0,
          child: Container(
            height: 400.0,
            width: 400.0,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(200.0),
              color: Color(getColourHexFromString("#FFFFFF")).withOpacity(0.1),
            ),
          ),
        ),
        Positioned(
          // bottom margin
          bottom: 100.0,
          //  right margin
          left: 150.0,
          child: Container(
            height: 300.0,
            width: 300.0,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(200.0),
              color: Color(getColourHexFromString("#FFFFFF")).withOpacity(0.1),

            ),
          ),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            //  add some top padding
            addSizedBoxPadding(16.0, 0),
            //  Align our text with Align widget
            Align(
              alignment: Alignment.center,
              child: Container(
                child: Text('Latest Results',
                  style: TextStyle(
                    fontSize: 24.0,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
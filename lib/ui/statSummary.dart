import 'package:flutter/material.dart';
import 'package:weplayball/models/teamStat.dart';
import 'package:weplayball/ui/colors.dart';

//  Represents an instance of a stat card
class StatSummary extends StatelessWidget {

  final TeamStatModel teamStat;

  StatSummary({Key key, this.teamStat}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final statIcon = new Container(
      margin: new EdgeInsets.symmetric(
          vertical: 16.0
      ),
      alignment: FractionalOffset.centerLeft,
      child: new Hero(
        tag:"icon-hero-${teamStat.statIcon}",
        child: new Image(
          image: new AssetImage(teamStat.statIcon),
          height: 92.0,
          width: 92.0,
        ),
      ),
    );

    /*Widget _statValue({String value, String image}) {
      return new Container(
        child: new Row(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              new Image.asset(image, height: 12.0),
              new Container(width: 8.0),
            ]
        ),
      );
    }*/

    final statCardContent = new Container(
      margin: new EdgeInsets.fromLTRB(76.0, 16.0, 16.0, 16.0),
      constraints: new BoxConstraints.expand(),
      child: new Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          new Container(height: 4.0),
          Flexible(
            child: Center(
              child: new Text(teamStat.statName/*, style: Style.titleTextStyle*/),
            ),
          ),
          Flexible(
            child: Center(
              child: new Text(teamStat.statValue/*, style: Style.titleTextStyle*/),
            ),
          ),
          new Container(height: 10.0),
          Flexible(
            child: Center(
              child: new Text(teamStat.statDescription/*, style: Style.commonTextStyle*/),
            ),
          ),

        ],
      ),
    );

    final statCard = new Container(
      width: MediaQuery.of(context).size.width - 100,
      child: statCardContent,
      height: 198.0,
      margin: new EdgeInsets.only(left: 46.0),
      decoration: new BoxDecoration(
        color: Color(getColourHexFromString(primaryBlue)),
        shape: BoxShape.rectangle,
        borderRadius: new BorderRadius.circular(8.0),
        boxShadow: <BoxShadow>[
          new BoxShadow(
            color: Colors.black12,
            blurRadius: 10.0,
            offset: new Offset(0.0, 10.0),
          ),
        ],
      ),
    );

    return Container(
      margin: const EdgeInsets.symmetric(
        vertical: 16.0,
        horizontal: 24.0,
      ),
      child: new Stack(
        children: <Widget>[
          statCard,
          statIcon,
        ],
      ),
    );


  }

}
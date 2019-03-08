import 'package:flutter/material.dart';
import 'package:weplayball/ui/colors.dart';
import 'package:weplayball/ui/layout.dart';

class TeamAbout extends StatefulWidget {
  TeamAbout(this.about);

  final String about;

  @override
  _TeamAboutState createState() => new _TeamAboutState();
}


class _TeamAboutState extends State<TeamAbout> with TickerProviderStateMixin<TeamAbout>{


  @override
  Widget build(BuildContext context) {

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        SizedBox(
          height: 24,
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.0),
          child: Text(
            "About",
            textAlign: TextAlign.left,
            style: TextStyle(
              fontWeight: FontWeight.w900,
              color: Color(getColourHexFromString(primaryBlack)),
              fontSize: fontSizeH4,
            ),
          ),
        ),

        SizedBox(
          height: 4,
        ),
        ConstrainedBox(
          constraints: BoxConstraints(maxHeight: 100.0),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.0),
            child: Text(
              widget.about,
              softWrap: true,
              overflow: TextOverflow.fade,
              style:  TextStyle(
                fontWeight: FontWeight.w400,
                color: Color(getColourHexFromString(primaryBlack)),
                fontSize: fontSizeH4,
              ),
            ),
          ),/*new Text(
              widget.about,
              softWrap: true,
              overflow: TextOverflow.fade,
            ),*/
        ),
        SizedBox(
          height: 24,
        ),
      ],
    );
  }

}
import 'package:flutter/material.dart';
import 'package:weplayball/models/teamDetails.dart';
import 'package:weplayball/ui/colors.dart';

class RankInformation extends StatelessWidget{
  RankInformation(this.teamDetails);
  final TeamDetailsModel teamDetails;

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    var textTheme = theme.textTheme;
    var rankCaptionStyle = textTheme.caption.copyWith(color: Color(getColourHexFromString(primaryBlack)));

    var rankColumn = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Text(
          teamDetails.rank.toString(),
          style: textTheme.title.copyWith(
            fontWeight: FontWeight.w400,
            color: theme.accentColor,
          ),
        ),
        SizedBox(height: 4.0),
        Text(
          'Rank',
          style: rankCaptionStyle,
        ),
      ],
    );

    var teamsCountColumn = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Text(
          "7",
          style: textTheme.title.copyWith(
            fontWeight: FontWeight.w400,
            color: Color(getColourHexFromString(primaryBlue)),
          ),
        ),
        SizedBox(height: 4.0,),
        Text(
          "Subdivision count",
          style: rankCaptionStyle,
        ),
      ],
    );

    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: <Widget>[
        rankColumn,
        SizedBox(width: 16.0),
        teamsCountColumn
      ],
    );

  }

}
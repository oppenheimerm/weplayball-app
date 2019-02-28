import 'package:flutter/material.dart';
import 'package:flutter_advanced_networkimage/flutter_advanced_networkimage.dart';
import 'package:weplayball/models/teamDetails.dart';
import 'package:weplayball/ui/colors.dart';
import 'package:weplayball/ui/layout.dart';


class TeamDetailsHeader extends StatelessWidget{

  TeamDetailsHeader(this.teamDetails, this.assetBaseUrl);
  final TeamDetailsModel teamDetails;
  final String assetBaseUrl;



  @override
  Widget build(BuildContext context) {
    return Container(
      child: Stack(
        children: <Widget>[
          /*ClipPath(
            clipper: ArcClipper(),
            child: Container(
              color: Color(getColourHexFromString(primaryBlue)),
              height: 300,
            ),
          ),*/
          Column(
            children: <Widget>[
              SizedBox(
                height: 30,
              ),
              Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(8.0))
                ),
                margin: EdgeInsets.symmetric(horizontal: 16.0),
                elevation: 3.0,
                color: Colors.white,
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 30.0, vertical: 22.0),
                  //color: Colors.white,
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    children: <Widget>[
                      SizedBox(
                        height: 24,
                      ),
                      Center(
                        child: _getLogo(
                            teamDetails,
                            assetBaseUrl
                        ),
                      ),
                      SizedBox(
                        height: 24,
                      ),
                      Text(
                        teamDetails.teamName.toUpperCase(),
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontWeight: FontWeight.w900,
                          fontFamily: 'Poppins',
                          color: Color(getColourHexFromString(primaryBlack)),
                          fontSize: fontSizeH4,
                        ),
                      ),
                      SizedBox(
                        height: 4,
                      ),
                      Text(
                        teamDetails.teamCode.toUpperCase(),
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontWeight: FontWeight.w400,
                          fontFamily: 'Poppins',
                          color: Color(getColourHexFromString(primaryBlack)),
                          fontSize: fontSizeH5,
                        ),
                      ),
                      SizedBox(
                        height: 24,
                      ),

                      Text(
                        teamDetails.division,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontWeight: FontWeight.w900,
                          fontFamily: 'Poppins',
                          color: Color(getColourHexFromString(primaryBlack)),
                          fontSize: fontSizeH4,
                        ),
                      ),
                      SizedBox(
                        height: 4,
                      ),
                      Text(
                        "DIVISION",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontWeight: FontWeight.w400,
                          fontFamily: 'Poppins',
                          color: Color(getColourHexFromString(primaryBlack)),
                          fontSize: fontSizeH5,
                        ),
                      ),
                      SizedBox(
                        height: 24,
                      ),
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: <Widget>[
                          _getRankColumn(teamDetails)
                        ],
                      ),
                      SizedBox(
                        height: 4,
                      ),
                      Text(
                        "RANK",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontWeight: FontWeight.w400,
                          fontFamily: 'Poppins',
                          color: Color(getColourHexFromString(primaryBlack)),
                          fontSize: fontSizeH5,
                        ),
                      ),
                      SizedBox(
                        height: 6,
                      ),

                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  _getLogo(TeamDetailsModel details, String assetBaseUrl)
  {

    var hasLogo = details.hasLogo;
    if(hasLogo)
    {
      return Material(
          elevation: 0.0,
          child: Image(
            image: AdvancedNetworkImage(
              assetBaseUrl + details.logo,
            ),
            fit: BoxFit.contain,
            width: 100.0,
          )
      );
    }
    else{
      return Material(
        borderRadius: BorderRadius.circular(4.0),
        elevation: 0.0,
        child: Container(
          width: 100.0,
          color: Colors.transparent,
          child: Container(
            padding: EdgeInsets.fromLTRB(10.0, 20.0, 10.0, 20.0),
            decoration: BoxDecoration(
              color: Color(getColourHexFromString(primaryBlack)),
              borderRadius: BorderRadius.all(
                  Radius.circular(100.0)
              ),
            ),
            child: Center(
              child: Text(
                details.teamCode,
                style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ),
      );
    }
  }



  /*_getDivisionColumn(TeamDetailsModel teamDetails)
  {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Center(
              child: Text(
                teamDetails.divisionCode.toUpperCase(),
                style: itemTitle,
              ),
            ),
          ],
        ),
        Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(top: 10),
              child: Center(
                child: Text("Division", style: subTitle),
              ),
            ),
          ],
        )
      ],
    );
  }*/

  _getRankColumn(TeamDetailsModel teamDetails){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              teamDetails.rank.toString(),
              style: TextStyle(
              fontWeight: FontWeight.w900,
              fontFamily: 'Poppins',
              color: Color(getColourHexFromString(primaryBlack)),
              fontSize: fontSizeH1,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10, top: 10),
              child: Text("of ${teamDetails.subDivisionCount.toString()}",
                  style: TextStyle(
                    fontWeight: FontWeight.w400,
                    fontFamily: 'Poppins',
                    color: Color(getColourHexFromString(primaryBlack)),
                    fontSize: fontSizeH5,
                  )
              ),
            )
          ],
        ),
      ],
    );
  }


}
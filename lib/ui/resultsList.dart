import 'package:flutter/material.dart';
import 'package:flutter_advanced_networkimage/flutter_advanced_networkimage.dart';
import 'package:intl/intl.dart';
import 'package:weplayball/models/result.dart';
import 'package:weplayball/pages/teamDetails/teamDetails.dart';
import 'package:weplayball/ui/colors.dart';
import 'package:weplayball/ui/layout.dart';
import 'package:weplayball/ui/resultBoard.dart';

//  Responsible for building the results view

class ResultsList extends StatelessWidget {

  const ResultsList({
    Key key,
    this.resultData,
    this.assetBaseUrl
  }) : super(key: key);

  final List<ResultModel> resultData;
  final String assetBaseUrl;

  _handleTap(BuildContext context,String teamCode){
    print("fetching datat for team: ${teamCode}") ;
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => TeamDetailsPage(teamCode, assetBaseUrl)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return createListView(context, resultData );
  }

  Widget createListView(BuildContext context, List<ResultModel> resultData) {

    return Container(
      decoration: BoxDecoration(
        gradient: new LinearGradient(colors: [gradientStart, gradientEnd],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          stops: [0.0,1.0],
        ),
      ),
      child: ListView.separated(
        padding: EdgeInsets.all(8.0),
        itemBuilder: (BuildContext context, int index) {
          return new Column(
            children: <Widget>[
              //  OLD
              /*Material(
                elevation: 0.25,
                borderRadius: BorderRadius.all(Radius.circular(stdBorderRadius)),
                color: Colors.white,
                child: Container(
                  padding: const EdgeInsets.all(8.0),
                  child: ResultBoard(resultData[index], assetBaseUrl, false)
                ),
              ),*/
              SizedBox(
                height: 12,
              ),
              Container(
                alignment: Alignment.center,
                padding: new EdgeInsets.all(8.0),
                height: 150.0,
                decoration: new BoxDecoration(
                  color: Colors.white,
                  image: DecorationImage(
                    image:  AssetImage("graphics/stat-result-card-bg.png"),
                    fit: BoxFit.cover,
                  ),
                  borderRadius: new BorderRadius.all(new Radius.circular(10.0)),
                  boxShadow: [
                    new BoxShadow(color: Color(getColourHexFromString(primaryGrey)),
                        offset: new Offset(2.0, 5.0),
                        blurRadius: 7.0)
                  ]
                ),
                child: ResultBoard(resultData[index], assetBaseUrl, false),
              ),
              //  add some padding
              addSizedBoxPadding(8.0, 0),
            ],
          );
        },
        separatorBuilder: (context, index) => Divider(
          height: 1.0,
          color: Colors.white,
        ),
        itemCount: resultData.length,
      ),
    );

  }
}
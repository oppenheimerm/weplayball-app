import 'package:flutter/material.dart';
import 'package:weplayball/models/result.dart';
import 'package:weplayball/ui/colors.dart';
import 'package:weplayball/ui/layout.dart';
import 'package:weplayball/ui/resultBoard.dart';
import 'package:weplayball/ui/sharedHeader.dart';


class TeamResultsAllView extends StatelessWidget{
  TeamResultsAllView(this.results, this.assetBaseUrl, {Key key}) : super(key: key);

  final List<ResultModel> results;
  final String assetBaseUrl;

  @override
  Widget build(BuildContext context) {

    var container = buildListView(context, results);


    return Container(
      decoration: BoxDecoration(
        gradient: new LinearGradient(colors: [gradientStart, gradientEnd],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          stops: [0.0,1.0],
        ),
      ),
      child: MainHeader(null, context, true, container),
    );

  }

  Container buildListView(BuildContext context, List<ResultModel> results)
  {
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
        itemBuilder: (BuildContext context, int index){
          return new Column(
            children: <Widget>[
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
                      new BoxShadow(color: Color(getColourHexFromString(primaryMediumGrey)),
                          offset: new Offset(2.0, 5.0),
                          blurRadius: 7.0)
                    ]
                ),
                child: ResultBoard(
                    results[index],
                    assetBaseUrl,
                    false
                ),
              ),
              //  add some padding
              addSizedBoxPadding(8.0, 0),
            ],
          );
        },
        separatorBuilder: (context, index) => Divider(
          height: 1.0,
          color: Color(getColourHexFromString(primaryWhiteGrey)),
        ),
        itemCount: results.length,
      ),
    );

  }


}
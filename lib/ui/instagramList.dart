import 'package:flutter/material.dart';
import 'package:flutter_advanced_networkimage/flutter_advanced_networkimage.dart';
import 'package:weplayball/models/instaFav.dart';
import 'package:weplayball/ui/colors.dart';
import 'package:weplayball/ui/layout.dart';

class InstagramList extends StatelessWidget{

  final List<InstaFavoriteModel> listData;
  final String assetBaseUrl;

  const InstagramList({
    Key key,
    this.listData,
    this.assetBaseUrl
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
        padding: EdgeInsets.all(8.0),
        itemBuilder: (context, index) {
          return Column(

            children: <Widget>[
              Container(
                //  Width: entire with of device
                width: MediaQuery.of(context).size.width,
                height: 400.0,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AdvancedNetworkImage(
                      assetBaseUrl + listData[index].instagramUrl,
                    ),//AssetImage(listData[index].instagramUrl),
                    fit: BoxFit.cover,
                  ),
                    gradient: new LinearGradient(colors: [gradientStart, gradientEnd],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      stops: [0.0,1.0],
                    )
                ),
              ),
              //  Add some padding
              Material(
                elevation: 0.75,
                child: ListTile(
                  //  we user multiples of 4 as per material design
                  contentPadding: const EdgeInsets.all(8.0),
                  // automatically adjust the text size for us
                  dense: true,
                  title: Padding(
                    padding: const EdgeInsets.only(bottom: 4.0),
                    child: Text(
                      listData[index].insagramUserId,
                      style: TextStyle(
                        color: Color(getColourHexFromString(primaryBlack)),
                      ),
                    ),
                  ),
                  subtitle: Text(
                    listData[index].date.toString(),
                  ),
                  trailing: Icon(Icons.more_vert),
                ),
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
        itemCount: listData.length
    );
  }

}
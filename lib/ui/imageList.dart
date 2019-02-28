import 'package:flutter/material.dart';
import 'package:weplayball/ui/colors.dart';
import 'package:weplayball/ui/layout.dart';

class ImageList extends StatelessWidget {

  final listData;

  const ImageList({Key key, this.listData}) : super(key: key);

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
                    image: AssetImage(listData[index].imageUrl),
                    fit: BoxFit.cover,
                  ),
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
                      listData[index].username,
                      style: TextStyle(
                        color: Color(getColourHexFromString(primaryBlack)),
                      ),
                    ),
                  ),
                  subtitle: Text(
                    listData[index].date,
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
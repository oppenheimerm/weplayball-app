import 'package:flutter/material.dart';
import 'package:weplayball/service/authenticationStatus.dart';
import 'package:weplayball/service/request/apiRequest.dart';
import 'package:weplayball/models/instaFav.dart';
import 'package:weplayball/service/response/parsedResponse.dart';
import 'package:weplayball/ui/colors.dart';
import 'package:weplayball/ui/instagramList.dart';


class InstFavsTabTab extends StatefulWidget  {

  final String _assetBaseUrl;
  final AuthStatus _authStatus;
  const InstFavsTabTab(this._authStatus, this._assetBaseUrl, { Key key }) : super(key: key);
  @override
  _InstaFavsTabState createState() => _InstaFavsTabState();
}

class _InstaFavsTabState extends State<InstFavsTabTab> {
  var _apiRequest = new ApiRequest();
  static ParsedResponse<List<InstaFavoriteModel>> instaData;
  Widget _screen;

  Future updateAndGetData() async {
    var data = await _apiRequest.getInstaFavs();
    return data;
  }

  buildLoadingView(){
    return Container(
      child: Center(child: new CircularProgressIndicator()),
    );
  }

  updateDataState()
  {
    var view =
    (instaData.body.length == 0)?
    Center(child:
    Text(
        'Instagram favorites not found',
        style: TextStyle(
          fontSize: 30.0,
          fontWeight: FontWeight.bold,
          color: Color(getColourHexFromString(primaryBlack)),
        )
    ),
    ) :
    new InstagramList(listData: instaData.body, assetBaseUrl: widget._assetBaseUrl);

    _screen = view;
  }

  @override
  Widget build(BuildContext context) {
    _screen = buildLoadingView();

    return Container(
      padding: EdgeInsets.all(8.0),
      alignment: Alignment.center,
      child: FutureBuilder(
          future: updateAndGetData(),
          builder: (BuildContext context, snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.none:
                return new Text('Input a URL to start');
              case ConnectionState.waiting:
                return new Center(child: new CircularProgressIndicator());
              case ConnectionState.active:
                return new Text('Hello');
              case ConnectionState.done:
                if (snapshot.hasError) {
                  return new Text(
                    '${snapshot.error}',
                    style: TextStyle(color: Colors.red),
                  );
                } else {
                  instaData = snapshot.data;
                  return buildView(context, snapshot);
                }
            }
          }
      ),
    );

  }

  Widget buildView(BuildContext context, AsyncSnapshot snapshot) {

    updateDataState();
    return _screen;
  }
}
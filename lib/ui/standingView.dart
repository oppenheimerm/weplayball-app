import 'package:flutter/material.dart';
import 'package:weplayball/models/standings.dart';
//import 'package:weplayball/models/standingsDataSource.dart';
import 'package:weplayball/models/standingsTeam.dart';
import 'package:weplayball/ui/colors.dart';

class StandingsView extends StatefulWidget {

  final List<StandingsModel> standingsData;
  final String assetBaseUrl;

  StandingsView(this.standingsData, this.assetBaseUrl, {Key key}) : super(key: key);

  @override
  _StandingsViewState createState() => _StandingsViewState();
}


class _StandingsViewState extends State<StandingsView> {
  List<StandingsModel> _dataSource;

  @override
  void initState() {
    buildDataTablesSources();
    super.initState();
  }


  buildDataTablesSources() {
    //  extract tables
    _dataSource = new List<StandingsModel>();
    widget.standingsData.asMap().forEach((i, value) {
      //  value => get the array of List<StandingsTeamModel>
      _dataSource.add(value);
    });
  }


  DataTable _initTable(List<StandingsTeamModel> source) {
    return new DataTable(
      //sortAscending: sort,
      sortColumnIndex: null,
      sortAscending: false,
      columns: [
        DataColumn(
          label: Text("Rank"),
          numeric: true,
          tooltip: "Subdivision rank",
          onSort: null,
        ),
        DataColumn(
          label: Text("Team"),
          numeric: false,
          tooltip: "Team name",
          onSort: null,
        ),

      ],
      rows: source.map((teamRow) =>
          DataRow(
              onSelectChanged: null,
              cells: [
                DataCell(
                  Text(teamRow.position.toString()),
                  onTap: () {},
                ),
                DataCell(
                  Text(teamRow.teamName),
                  onTap: () {},
                ),
              ])
      ).toList(),
      onSelectAll: null,
    );
  }

  List<Widget> buildTables() {
    //   _dataSource = new List<StandingsModel>();
    List<Widget> tables = new List<Widget>();
    _dataSource.asMap().forEach((i, value) {
      //  Title for this table
      tables.add(
          new Text(value.subDivisionTitle,)
      );

      //  Add some padding
      tables.add(
        SizedBox(height: 4.0),
      );

      //  Add the table
      var newTable = _initTable(value.subDivisionStats);
      tables.add(newTable);

      //  Add some bottom padding
      tables.add(
        SizedBox(height: 8.0),
      );
    });

    return tables;
  }

  @override
  Widget build(BuildContext context) {

    return Container(
      //color: Colors.blue,//Color(getColourHexFromString(primaryWhiteGrey)),
      decoration: new BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(10.0)),
        color: Color(getColourHexFromString(primaryWhiteGrey)),
        gradient: new LinearGradient(colors: [gradientStart, gradientEnd],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          stops: [0.0,1.0],
        ),
      ),
      child: ListView(
        padding: const EdgeInsets.all(8.0),
        children: <Widget>[
          SingleChildScrollView(
            child: Column(
              children: <Widget>[
                Material(
                  elevation: 0.75,
                  borderRadius: BorderRadius.all(Radius.circular(10.0)),
                  color: Colors.white,//Color(getColourHexFromString(primaryWhiteGrey)),
                  child: Container(
                    //color: Color(getColourHexFromString(primaryWhiteGrey)),
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: buildTables(),
                    ),
                  ),
                ),
              ],
            ),
            /*Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: buildTables(),
          ),*/
          ),
        ],
      ),
    );
  }

}
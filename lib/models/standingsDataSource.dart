import 'package:flutter/material.dart';
import 'package:weplayball/models/standings.dart';
import 'package:weplayball/models/standingsTeam.dart';

//  See: https://github.com/flutter/flutter/blob/master/examples/flutter_gallery/lib/demo/material/data_table_demo.dart

class StandingsDataSource extends DataTableSource{

  final List<StandingsTeamModel> _standingsData;

  StandingsDataSource(this._standingsData);

  List<StandingsTeamModel> GetDataSource(){
    return _standingsData;
  }

  String GetSubdivisionTitle(){
    return _standingsData[0].subDivisionName;
  }

    /*void _sort<T>(Comparable<T> getField(StandingsModel d), bool ascending) {
      _standingsData.sort((StandingsTeamModel a, StandingsTeamModel b) {
        if (!ascending) {
          final StandingsTeamModel c = a;
          a = b;
          b = c;
        }
        final Comparable<T> aValue = getField(a);
        final Comparable<T> bValue = getField(b);
        return Comparable.compare(aValue, bValue);
      });
      notifyListeners();
    }*/



  int _selectedCount = 0;

  @override
  DataRow getRow(int index) {
    assert(index >= 0);
    if (index >= _standingsData.length)
      return null;
    final StandingsTeamModel standingsTeamModel = _standingsData[index];
    return DataRow.byIndex(
        index: index,
        selected: standingsTeamModel.selected,
        onSelectChanged: (bool value) {
          if (standingsTeamModel.selected != value) {
            _selectedCount += value ? 1 : -1;
            assert(_selectedCount >= 0);
            standingsTeamModel.selected = value;
            notifyListeners();
          }
        },
        cells: <DataCell>[
          DataCell(Text('${standingsTeamModel.position}')),
          DataCell(Text('${standingsTeamModel.teamName}')),
          DataCell(Text('${standingsTeamModel.gamesPlayed}')),
          DataCell(Text('${standingsTeamModel.gamesWon}')),
          DataCell(Text('${standingsTeamModel.gamesLost}')),
          DataCell(Text('${standingsTeamModel.basketsFor}')),
          DataCell(Text('${standingsTeamModel.basketsAgainst}')),
          DataCell(Text('${standingsTeamModel.wPyth}')),
          DataCell(Text('${standingsTeamModel.winsOver500}')),
          DataCell(Text('${standingsTeamModel.winLossPercent}')),
          DataCell(Text('${standingsTeamModel.basketsPerGame}')),
          DataCell(Text('${standingsTeamModel.lossPercentage}')),
          DataCell(Text('${standingsTeamModel.winPercentage}')),
        ]
    );
  }

  @override
  int get rowCount => _standingsData.length;

  @override
  bool get isRowCountApproximate => false;

  @override
  int get selectedRowCount => _selectedCount;

  void SelectAll(bool checked) {
    for (StandingsTeamModel standingsTeamModel in _standingsData)
      standingsTeamModel.selected = checked;
    _selectedCount = checked ? _standingsData.length : 0;
    notifyListeners();
  }


}
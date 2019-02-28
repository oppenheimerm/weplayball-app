import 'package:weplayball/models/standingsTeam.dart';


//  https://medium.com/flutter-community/parsing-complex-json-in-flutter-747c46655f51
class StandingsModel {
  final String subDivisionTitle;
  final String subDivisionCode;
  final String divisionName;
  final String divisionCode;
  final int division;
  final List<StandingsTeamModel> subDivisionStats;

  StandingsModel({
    this.subDivisionTitle,
    this.subDivisionCode,
    this.divisionName,
    this.divisionCode,
    this.division,
    this.subDivisionStats
  });

  factory StandingsModel.fromJson(Map<String, dynamic> json){

    var list = json['subDivisionStats'] as List;
    List<StandingsTeamModel> standingsList = list.map((i) => StandingsTeamModel.fromJson(i)).toList();


    return StandingsModel(

        subDivisionTitle: json['subDivisionTitle'],
        subDivisionCode: json['subDivisionCode'],
        divisionName: json['divisionName'],
        divisionCode: json['divisionCode'],
        division: json['division'],
        //subDivisionStats = json['subDivisionStats'];
        subDivisionStats: standingsList
    );
  }
}
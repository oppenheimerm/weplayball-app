import 'package:weplayball/models/fixture.dart';
import 'package:weplayball/models/result.dart';

class TeamDetailsModel {
  final String teamName;
  final String teamCode;
  final String subDivisionTitle;
  final String subDivisionCode;
  final String division;
  final String divisionCode;
  final String website;
  final String address;
  final String postCode;
  final bool hasLogo;
  final String logo;
  final int rank;
  final int gamesPlayed;
  final int gamesWon;
  final int gamesLost;
  final int basketsFor;
  final int basketsAgainst;
  final int pointsDifference;
  final int points;
  final String wPyth;
  final String winsOver500;
  final String winLossPercent;
  final String basketsPerGame;
  final String lossPercentage;
  final String winPercentage;
  final int subDivisionCount;
  final FixtureModel nextMatch;
  final ResultModel lastResult;
  final String about;

  TeamDetailsModel({
    this.teamName,
    this.teamCode,
    this.subDivisionTitle,
    this.subDivisionCode,
    this.division,
    this.divisionCode,
    this.website,
    this.address,
    this.postCode,
    this.hasLogo,
    this.logo,
    this.rank,
    this.gamesPlayed,
    this.gamesWon,
    this.gamesLost,
    this.basketsFor,
    this.basketsAgainst,
    this.pointsDifference,
    this.points,
    this.wPyth,
    this.winsOver500,
    this.winLossPercent,
    this.basketsPerGame,
    this.lossPercentage,
    this.winPercentage,
    this.subDivisionCount,
    this.nextMatch,
    this.lastResult,
    this.about
  });

  factory TeamDetailsModel.fromJson(Map<String, dynamic> json){
    return TeamDetailsModel(
        teamName: json['teamName'],
        teamCode: json['teamCode'],
        subDivisionTitle: json['subDivisionTitle'],
        subDivisionCode: json['subDivisionCode'],
        division: json['divisionName'],
        divisionCode: json['divisionCode'],
        website: json['website'],
        address: json['address'],
        postCode: json['postCode'],
        hasLogo: json['hasLogo'],
        logo: json['logo'],
        rank: json['position'],
        gamesPlayed: json['gamesPlayed'],
        gamesWon: json['gamesWon'],
        gamesLost: json['gamesLost'],
        basketsFor: json['basketsFor'],
        basketsAgainst: json['basketsAganist'],
        pointsDifference: json['pointsDifference'],
        points: json['points'],
        wPyth: json['wPyth'],
        winsOver500: json['winsOver500'],
        winLossPercent: json['winLossPercent'],
        basketsPerGame: json['basketsPerGame'],
        lossPercentage: json['lossPercentage'],
        winPercentage: json['winPercentage'],
        subDivisionCount: json['subDivisionCount'],
        nextMatch: FixtureModel.fromJson(json['teamNextMatch']),
        lastResult: ResultModel.fromJson(json['teamLastResult']),
        about: json['about'],
    );
  }

}
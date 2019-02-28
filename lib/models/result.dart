class ResultModel {
  final DateTime matchDate;
  final String homeTeamName;
  final String homeTeamCode;
  final bool homeTeamHasLogo;
  final String homeTeamLogo;
  final String awayTeamName;
  final String awayTeamCode;
  final bool awayTeamHasLogo;
  final String awayTeamLogo;
  final String division;
  final String divisionCode;
  final String subDivision;
  final String subDivisionCode;
  final String score;
  final String winnerTeamName;
  final String winnerTeamCode;

  ResultModel(
      this.matchDate,
      this.homeTeamName,
      this.homeTeamCode,
      this.homeTeamHasLogo,
      this.homeTeamLogo,
      this.awayTeamName,
      this.awayTeamCode,
      this.awayTeamHasLogo,
      this.awayTeamLogo,
      this.division,
      this.divisionCode,
      this.subDivision,
      this.subDivisionCode,
      this.score,
      this.winnerTeamName,
      this.winnerTeamCode
      );

  ResultModel.fromJson(Map<String, dynamic> json)
  //  DateTime.parse("1969-07-20 20:18:04Z");
      : matchDate = DateTime.parse(json['timeStamp']),
        homeTeamName = json['homeTeamName'],
        homeTeamCode = json['homeTeamCode'],
        homeTeamHasLogo = json['homeTeamHasLogo'],
        homeTeamLogo = json['homeTeamLogo'],
        awayTeamName = json['awayTeamName'],
        awayTeamCode = json['awayTeamCode'],
        awayTeamHasLogo = json['awayTeamHasLogo'],
        awayTeamLogo = json['awayTeamLogo'],
        division = json['division'],
        divisionCode = json['divisionCode'],
        subDivision = json['subDivision'],
        subDivisionCode = json['subDivisionCode'],
        score = json['score'],
        winnerTeamName = json['winnerTeamName'],
        winnerTeamCode = json['winnerTeamCode'];

  Map<String, dynamic> toJson() =>
      {
        'timeStamp': matchDate,
        'homeTeamName': homeTeamName,
        'homeTeamCode': homeTeamCode,
        'homeTeamHasLogo': homeTeamHasLogo,
        'homeTeamLogo': homeTeamLogo,
        'awayTeamName': awayTeamName,
        'awayTeamCode': awayTeamCode,
        'awayTeamHasLogo': awayTeamHasLogo,
        'awayTeamLogo': awayTeamLogo,
        'division': division,
        'divisionCode': divisionCode,
        'subDivision' : subDivision,
        'subDivisionCode' : subDivisionCode,
        'score':score,
        'winnerTeamName':winnerTeamName,
        'winnerTeamCode':winnerTeamCode,
      };
}
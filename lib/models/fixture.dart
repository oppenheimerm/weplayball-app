class FixtureModel {
  final DateTime fixtureDate;
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

  FixtureModel(
      this.fixtureDate,
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
      this.subDivisionCode
      );

  FixtureModel.fromJson(Map<String, dynamic> json)
  //  DateTime.parse("1969-07-20 20:18:04Z");
      : fixtureDate = DateTime.parse(json['fixtureDate']),
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
        subDivisionCode = json['subDivisionCode'];

  Map<String, dynamic> toJson() =>
      {
        'fixtureDate': fixtureDate,
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
        'subDivisionCode' : subDivisionCode
      };
}
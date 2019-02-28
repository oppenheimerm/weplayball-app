class StandingsTeamModel {
  final String teamName;
  final int teamId;
  final String teamCode;
  final int subDivisionId;
  final String subDivisionName;
  final int position;
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

  bool selected = false;

  StandingsTeamModel(
      this.teamName,
      this.teamId,
      this.teamCode,
      this.subDivisionId,
      this.subDivisionName,
      this.position,
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
      );

  StandingsTeamModel.fromJson(Map<String, dynamic> json)
      : teamName = json['teamName'],
        teamId = json['teamId'],
        teamCode = json['teamCode'],
        subDivisionId = json['subDivisionId'],
        subDivisionName = json['subDivisionName'],
        position = json['position'],
        gamesPlayed = json['gamesPlayed'],
        gamesWon = json['gamesWon'],
        gamesLost = json['gamesLost'],
        basketsFor = json['basketsFor'],
        basketsAgainst = json['basketsAgainst'],
        pointsDifference = json['pointsDifference'],
        points = json['points'],
        wPyth = json['wPyth'],
        winsOver500 = json['winsOver500'],
        winLossPercent = json['winLossPercent'],
        basketsPerGame = json['basketsPerGame'],
        lossPercentage = json['lossPercentage'],
        winPercentage = json['winPercentage'];

  Map<String, dynamic> toJson() =>
      {
        'teamName': teamName,
        'teamId': teamId,
        'teamCode': teamCode,
        'subDivisionId': subDivisionId,
        'subDivisionName':subDivisionName,
        'position': position,
        'gamesPlayed':gamesPlayed,
        'gamesWon':gamesWon,
        'gamesLost':gamesLost,
        'basketsFor':basketsFor,
        'basketsAgainst':basketsAgainst,
        'pointsDifference':pointsDifference,
        'points':points,
        'wPyth':wPyth,
        'winsOver500':winsOver500,
        'winLossPercent':winLossPercent,
        'basketsPerGame':basketsPerGame,
        'lossPercentage':lossPercentage,
        'winPercentage':winPercentage,
      };
}
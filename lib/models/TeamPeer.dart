class TeamPeer{
  final String teamName;
  final String teamCode;

  TeamPeer({
    this.teamName,
    this.teamCode
  });

  factory TeamPeer.fromJson(Map<String, dynamic> json){
    return TeamPeer(
      teamName: json['teamName'],
      teamCode: json['teamCode'],
    );
  }

}
class InstaFavoriteModel {
  final int id;
  final DateTime date;
  final String insagramUserId;
  final String url;
  final String filename;
  final bool isVideo;
  final String instagramUrl;

  InstaFavoriteModel(
      this.id,
      this.date,
      this.insagramUserId,
      this.url,
      this.filename,
      this.isVideo,
      this.instagramUrl
      );


  InstaFavoriteModel.fromJson(Map<String, dynamic> json)
  //  DateTime.parse("1969-07-20 20:18:04Z");
      : id = json['id'],
        date = DateTime.parse(json['date']),
        insagramUserId = json['insagramUserId'],
        url = json['url'],
        filename = json['filename'],
        isVideo = json['isVideo'],
        instagramUrl = json['instagramUrl'];

  Map<String, dynamic> toJson() =>
      {
        'id': id,
        'date': date,
        'insagramUserId': insagramUserId,
        'url': url,
        'filename': filename,
        'isVideo': isVideo,
        'instagramUrl': instagramUrl
      };
}
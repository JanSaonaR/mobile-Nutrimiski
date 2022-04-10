class Picture {
  final String? pictureId;
  final String? url;


  Picture({this.pictureId, this.url});

  factory Picture.fromJson(dynamic json) {
    Map<String, dynamic> pictureJson = json;
    return Picture(
        pictureId: pictureJson['pictureId'],
        url: pictureJson['url'].toString()
    );
  }
}
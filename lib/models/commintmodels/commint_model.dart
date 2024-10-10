class Commintcompany {
  int? id;
  int? reportid;
  String? commentname;
  String? clientname;
  int? ratingvalue;
  String? createAt;

  Commintcompany.fromJson(Map<String, dynamic> json) {
    id = json['id'] ?? 0;
    reportid = json['reportid'] ?? 0;
    commentname = json['commentname'] ?? "";
    clientname = json['clientname'] ?? "";
    ratingvalue = json['rating'] ?? 0;
    createAt = json['short_time_create'] ?? "";
  }
}

class Image_company {
  int? id;
  //String? imageName;
  String? date;

  Image_company.fromJson(Map<String, dynamic> json) {
    id = json['id'] ?? 0;
    //imageName = json['imageName'] ?? "";
    date = json['imageName'] ?? "";
  }
}

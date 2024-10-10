class Image_service {
  int? id;
  //String? imageName;
  String? date;

  Image_service.fromJson(Map<String, dynamic> json) {
    id = json['id'] ?? 0;
    //imageName = json['imageName'] ?? "";
    date = json['imageName'] ?? "";
  }
}

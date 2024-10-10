class FavoriteCompany {
  int? id;
  String? companyName;
  int? companyId;
  String? addressName;
  String? cityName;
  String? data;

  FavoriteCompany.fromJson(Map<String, dynamic> json) {
    id = json['id'] ?? 0;
    companyName = json['companyName'] ?? "";
    companyId = json['companyId'] ?? 0;
    addressName = json['addressName'] ?? "";
    cityName = json['cityName'] ?? "";
    data = json['imageCompany'] ?? "";
  }
}

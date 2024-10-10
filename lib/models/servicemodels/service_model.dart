class ServiceCompany {
  //المودل الخاص بعرض الخدمه كقائمة وفيها بيانات
  int? id;
  String? name;
  int? number;
  int? numberPeople;
  String? description;
  int? price;
  String? Data;

  ServiceCompany.fromJson(Map<String, dynamic> json) {
    id = json['id'] ?? 0;
    name = json['name'] ?? "";
    number = json['number'] ?? 0;
    numberPeople = json['numberPeople'] ?? 0;
    description = json['description'] ?? "";
    price = json['price'] ?? 0;
    Data = json['imageService'] ?? "";
  }
}

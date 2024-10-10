class Company_Service_List {
  int? id;
  String? name;
  int? number;
  int? price;
  String? description;
  int? companyId;
  String? company;
  //String? imageService;
  String? data;

  Company_Service_List.fromJson(Map<String, dynamic> json) {
    id = json['id'] ?? "";
    name = json['name'] ?? "";
    number = json['number'] ?? "";
    price = json['price'] ?? "";
    description = json['description'] ?? "";
    companyId = json['companyId'] ?? "";
    company = json['company'] ?? "";
    //imageService = json['imageService'] ?? "";
    data = json['imageService'] ?? "";
  }
}

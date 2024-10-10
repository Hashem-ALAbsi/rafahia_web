class Chalet_Company {
  int? id;
  String? name;
  // int? typeCompanyId;
  // String? typeCompanyName;
  // String? longtude;
  // String? latetud;
  // int? addressId;
  String? addressName;
  String? cityName;
  String? note;
  bool? rustorant;
  bool? swimmingbool;
  bool? cooffee;
  // String? imageCompany;
  String? Data;

  Chalet_Company.fromJson(Map<String, dynamic> json) {
    id = json['id'] ?? 0;
    name = json['name'] ?? "";
    // typeCompanyId = json['typeCompanyId'] ?? 0;
    // typeCompanyName = json['typeCompanyName'] ?? "";
    // longtude = json['longtude'] ?? "";
    // latetud = json['latetud'] ?? "";
    // addressId = json['addressId'] ?? 0;
    addressName = json['addressName'] ?? "";
    cityName = json['cityName'] ?? "";
    note = json['note'] ?? "";
    rustorant = json['rustorant'] ?? false;
    swimmingbool = json['swimmingbool'] ?? false;
    cooffee = json['cooffee'] ?? false;
    // imageCompany = json['imageCompany'] ?? "";
    Data = json['imageCompany'] ?? "";
  }
}

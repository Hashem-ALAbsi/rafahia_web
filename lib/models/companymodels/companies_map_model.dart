//import 'package:google_maps_flutter/google_maps_flutter.dart';

class CompanysMap {
  int? id;
  String? name;
  // int? typeCompanyId;
  // String? typeCompanyName;
  String? longtude;
  String? latetud;
  late double lom;
  late double lam;
  // int? addressId;
  String? addressName;
  String? cityName;
  // String? note;
  // bool? rustorant;
  // bool? swimmingbool;
  // bool? cooffee;
  String? imageCompany;
  String? Data;
  // LatLng? latLng;

  CompanysMap.fromJson(Map<String, dynamic> json) {
    id = json['id'] ?? 0;
    name = json['name'] ?? "";
    // typeCompanyId = json['typeCompanyId'] ?? 0;
    // typeCompanyName = json['typeCompanyName'] ?? "";
    longtude = json['longtude'] ?? "";
    latetud = json['latetud'] ?? "";
    // addressId = json['addressId'] ?? 0;
    addressName = json['addressName'] ?? "";
    cityName = json['cityName'] ?? "";
    // note = json['note'] ?? "";
    // rustorant = json['rustorant'] ?? false;
    // swimmingbool = json['swimmingbool'] ?? false;
    // cooffee = json['cooffee'] ?? false;
    imageCompany = json['imageCompany'] ?? "";
    Data = json['data'] ?? "";
    lom = double.parse(longtude.toString()) ?? 0.00;
    lam = double.parse(latetud.toString())?? 0.00;
    // latLng = LatLng(
    //     double.parse(latetud.toString()), double.parse(longtude.toString()));
  }
}

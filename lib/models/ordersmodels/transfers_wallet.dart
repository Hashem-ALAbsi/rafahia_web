class TransferWallet {
  int? idorder;
  String? clientname;
  String? companyname;
  String? servicename;
  int? price;
  String? createAt;
  TransferWallet.fromJson(Map<String, dynamic> json) {
    idorder = json['idorder'] ?? 0;
    clientname = json['clientname'] ?? "";
    companyname = json['companyname'] ?? "";
    servicename = json['servicename'] ?? "";
    price = json['price'] ?? 0;
    createAt = json['createAt'] ?? "";
  }
}

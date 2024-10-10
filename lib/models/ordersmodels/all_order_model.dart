class AllOrder {
  int? id;
  String? clientName;
  String? companyName;
  String? service;
  String? stateOrder;
  String? createAt;
  AllOrder.fromJson(Map<String, dynamic> json) {
    id = json['id'] ?? 0;
    clientName = json['clientName'] ?? "";
    companyName = json['companyName'] ?? "";
    service = json['service'] ?? "";
    stateOrder = json['stateOrder'] ?? "";
    createAt = json['short_time_create'] ?? "";
  }
}

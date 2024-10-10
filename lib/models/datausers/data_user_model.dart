class Countries {
  int? id;
  String? name;

  Countries.fromJson(Map<String, dynamic> json) {
    id = json['id'] ?? 0;
    name = json['name'] ?? "";
  }
}

class Sexually {
  int? id;
  String? name;

  Sexually.fromJson(Map<String, dynamic> json) {
    id = json['id'] ?? 0;
    name = json['name'] ?? "";
  }
}

class MaritalState {
  int? id;
  String? name;

  MaritalState.fromJson(Map<String, dynamic> json) {
    id = json['id'] ?? 0;
    name = json['name'] ?? "";
  }
}

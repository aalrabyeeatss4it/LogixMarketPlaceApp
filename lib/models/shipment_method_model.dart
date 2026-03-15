class ShipmentMethodModel {
  int code;
  String name;
  String? name2;

  ShipmentMethodModel({ required this.code, required this.name,this.name2});

  factory ShipmentMethodModel.fromJson(Map<String, dynamic> json) {
    return ShipmentMethodModel(
        code: json['code'],
        name: json['name'],
        name2: json['name2']);
  }

  static List<ShipmentMethodModel> fromJsonList(List<dynamic> jsonList) {
    return jsonList.map((item) => ShipmentMethodModel.fromJson(item)).toList();
  }

  Map<String, dynamic> toJson() {
    return {
      'code': code,
      'name': name,
      'name2': name2
    };
  }
}

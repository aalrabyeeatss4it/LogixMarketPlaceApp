import '../common/api_paths.dart';

class ShipmentCompanyModel {
  final int id;
  final int? itemId;
  final String name;
  final String? name2;
  final String? iconPath;
  final String? disclaimerMessage;
  final int? displayOrder;
  final bool? isActive;

  ShipmentCompanyModel({
    required this.id,
    required this.name,
    this.itemId,
    this.name2,
    this.iconPath,
    this.disclaimerMessage,
    this.displayOrder,
    this.isActive,
  });

  factory ShipmentCompanyModel.fromJson(Map<String, dynamic> json) {
    return ShipmentCompanyModel(
      id: json['id'] ?? 0,
      itemId: json['itemId'],
      name: json['name'],
      name2: json['name2'],
      iconPath: json['iconPath'],
      disclaimerMessage: json['disclaimerMessage'],
      displayOrder: json['displayOrder'],
      isActive: json['isActive'] ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'itemId': itemId,
      'name': name,
      'name2': name2,
      'iconPath': iconPath,
      'disclaimerMessage': disclaimerMessage,
      'displayOrder': displayOrder,
      'isActive': isActive,
    };
  }

  static List<ShipmentCompanyModel> fromJsonList(List<dynamic> jsonList) {
    return jsonList.map((item) => ShipmentCompanyModel.fromJson(item)).toList();
  }

  String getIconPath(){
    if(iconPath==null) return "";
    String path = iconPath!;
    if(path.isEmpty){
      path = "no_image.jpg";
    }
    return erpUrl()+imagesDirPath()+path;
  }
}
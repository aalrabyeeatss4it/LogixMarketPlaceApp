import '../common/api_paths.dart';
import 'delivery_address_model.dart';

class ShipmentInfoModel {
  int? methodId;
  String? methodName;
  String? methodName2;
  String? deliveryDate;
  int? feeProductId;
  String? deliveryFee;
  int? companyId;
  String? companyName;
  String? companyName2;
  String? iconPath;
  DeliveryAddressModel? deliveryAddress;

  ShipmentInfoModel({
    this.methodId,
    this.methodName,
    this.methodName2,
    this.feeProductId,
    this.companyId,
    this.companyName,
    this.companyName2,
    this.iconPath,
    this.deliveryFee,
    this.deliveryDate,
    this.deliveryAddress,
  });

  factory ShipmentInfoModel.fromJson(Map<String, dynamic> json) {
    return ShipmentInfoModel(
      methodId: json['methodId'],
      methodName: json['methodName'],
      methodName2: json['methodName2'],
      feeProductId: json['feeProductId'],
      companyId: json['companyId'],
      companyName: json['companyName'],
      companyName2: json['companyName2'],
      iconPath: json['iconPath'],
      deliveryFee: json['deliveryFee'],
      deliveryDate: json['deliveryDate'],
      deliveryAddress: DeliveryAddressModel.fromJson(json['deliveryAddress']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'methodId': methodId,
      'methodName': methodName,
      'methodName2': methodName2,
      'feeProductId': feeProductId,
      'companyId': companyId,
      'companyName': companyName,
      'companyName2': companyName2,
      'iconPath': iconPath,
    };
  }

  String getIconPath(){
    if(iconPath==null) return "";
    String path = iconPath!;
    if(path.isEmpty){
      path = "no_image.jpg";
    }
    return erpUrl()+imagesDirPath()+path;
  }
  getDeliveryFee(){
    if(deliveryFee==null) {
      return "0.0";
    } else {
      return deliveryFee;
    }
  }
}
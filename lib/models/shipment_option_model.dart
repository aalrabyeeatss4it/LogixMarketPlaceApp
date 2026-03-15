import 'package:logix_market_place/models/shipment_company_model.dart';
import 'package:logix_market_place/models/shipment_method_model.dart';

class ShipmentOptionModel {
  List<ShipmentCompanyModel> shipmentCompanies = <ShipmentCompanyModel>[];
  List<ShipmentMethodModel> shipmentMethods = <ShipmentMethodModel>[];
  ShipmentOptionModel();
  // ShipmentOptionModel({required this.shipmentMethods, required this.shipmentCompanies});
  factory ShipmentOptionModel.fromJson(Map<String, dynamic> json) {
    var shipmentOption = ShipmentOptionModel();
    shipmentOption.shipmentMethods = ShipmentMethodModel.fromJsonList(json["shipmentMethods"]);
    shipmentOption.shipmentCompanies = ShipmentCompanyModel.fromJsonList(json["shipmentCompanies"]);
    return shipmentOption;
  }
}

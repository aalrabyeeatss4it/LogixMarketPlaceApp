class DeliveryCostRequestModel{
  final String shipmentMethodId;
  final String shipmentCompanyId;

  DeliveryCostRequestModel({
    required this.shipmentMethodId,
    required this.shipmentCompanyId,
  });

  factory DeliveryCostRequestModel.fromJson(Map<String, dynamic> json) {
    return DeliveryCostRequestModel(
      shipmentMethodId: json["ShipmentMethodId"] ?? "",
      shipmentCompanyId: json["ShipmentCompanyId"] ?? "",
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "ShipmentMethodId": shipmentMethodId,
      "ShipmentCompanyId": shipmentCompanyId,
    };
  }
}
class DeliveryAddressModel {
  String? id;
  String? streetName;
  String? buildingName;
  String? buildingNo;
  String? closestPlace;
  String? zipCode;
  String? districtName;
  String? regionName;
  String? recipientName;
  String? mobileNo;

  DeliveryAddressModel({
    this.id,
    this.streetName,
    this.buildingName,
    this.buildingNo,
    this.closestPlace,
    this.zipCode,
    this.districtName,
    this.regionName,
    this.recipientName,
    this.mobileNo,
  });

  String get getRecipientName => 'التوصيل إلى '+(recipientName ??"");
  String get fullAddress {
    final parts = [
      if (streetName?.isNotEmpty ?? false) streetName,
      if (buildingName?.isNotEmpty ?? false) buildingName,
      if (buildingNo?.isNotEmpty ?? false) buildingNo,
      if (closestPlace?.isNotEmpty ?? false) closestPlace,
      if (districtName?.isNotEmpty ?? false) districtName,
      if (zipCode?.isNotEmpty ?? false) zipCode,
      if (regionName?.isNotEmpty ?? false) regionName,
      'السعودية'
    ];
    return parts.join('، ');
  }
  factory DeliveryAddressModel.fromJson(Map<String, dynamic> json){
    DeliveryAddressModel address = DeliveryAddressModel();
    address.regionName = json["regionName"];
    address.districtName = json["districtName"];
    address.streetName = json["streetName"];
    address.zipCode = json["zipCode"];
    address.buildingNo = json["buildingNo"];
    address.mobileNo = json["mobileNo"];
    return address;
  }
}

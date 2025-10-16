class DeliveryAddressModel {
  String? streetName;
  String? buildingName;
  String? floorNo;
  String? closestPlace;
  String? city;
  String? neighborhoodName;
  String? governance;
  String? recipientName;
  String? recipientMobileNo;
  DeliveryAddressModel({
    this.streetName,
    this.buildingName,
    this.floorNo,
    this.closestPlace,
    this.city,
    this.neighborhoodName,
    this.governance,
    this.recipientName,
    this.recipientMobileNo,
  });
  String get getRecipientName => 'التوصيل إلى $recipientName'??"";
  String get fullAddress {
    final parts = [
      if (streetName?.isNotEmpty ?? false) streetName,
      if (buildingName?.isNotEmpty ?? false) buildingName,
      if (floorNo?.isNotEmpty ?? false) 'طابق $floorNo',
      if (closestPlace?.isNotEmpty ?? false) closestPlace,
      if (neighborhoodName?.isNotEmpty ?? false) neighborhoodName,
      if (city?.isNotEmpty ?? false) city,
      if (governance?.isNotEmpty ?? false) governance,
      'السعودية'
    ];
    return parts.join('، ');
  }
}

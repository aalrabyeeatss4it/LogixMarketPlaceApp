class DeliveryAddressModel {
  int? id;
  String? label;
  String? shortAddress;
  String? regionName;
  String? cityName;
  String? districtName;
  String? streetName;
  String? buildingNo;
  String? zipCode;
  String? closestPlace;
  String? recipientName;
  String? mobileNo;
  double? latitude;
  double? longitude;
  bool? isDefault;

  DeliveryAddressModel({
    this.id,
    this.label,
    this.shortAddress,
    this.cityName,
    this.streetName,
    this.buildingNo,
    this.closestPlace,
    this.zipCode,
    this.districtName,
    this.regionName,
    this.recipientName,
    this.mobileNo,
    this.latitude,
    this.longitude,
    this.isDefault,
  });

  String get getRecipientName => 'التوصيل إلى '+(recipientName ??"");
  String get fullAddress {
    final parts = [
      if (streetName?.isNotEmpty ?? false) streetName,
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
    return DeliveryAddressModel(
      id: json["id"] is int ? json["id"] : int.tryParse(json["id"]?.toString() ?? ""),
      label: json["label"],
      isDefault: json["isDefault"],
      shortAddress: json["shortAddress"],
      regionName: json["regionName"],
      cityName: json["cityName"],
      districtName: json["districtName"],
      streetName: json["streetName"],
      buildingNo: json["buildingNo"],
      zipCode: json["zipCode"],
      closestPlace: json["closestPlace"],
      recipientName: json["recipientName"],
      mobileNo: json["mobileNo"],
      latitude: json["latitude"] != null ? double.tryParse(json["latitude"].toString()) : null,
      longitude: json["longitude"] != null ? double.tryParse(json["longitude"].toString()) : null,
    );
  }

  static List<DeliveryAddressModel> fromJsonList(List<dynamic> list){
    return list.map((address) => DeliveryAddressModel.fromJson(address)).toList();
  }


  Map<String, dynamic> toJson(){
    Map<String, dynamic> json = {
      'id': id,
      'label': label,
      // 'shortAddress': shortAddress,
      'cityName': cityName,
      'streetName': streetName,
      'buildingNo': buildingNo,
      'closestPlace': closestPlace,
      'zipCode': zipCode,
      'districtName': districtName,
      'regionName': regionName,
      'recipientName': recipientName,
      'mobileNo': mobileNo,
      'latitude': latitude,
      'longitude': longitude,
      'isDefault': isDefault,
    };
    return json;
  }
  DeliveryAddressModel copyWith({
    int? id,
    String? label,
    String? shortAddress,
    String? districtName,
    String? cityName,
    String? regionName,
    String? streetName,
    String? buildingNo,
    String? zipCode,
    String? closestPlace,
    String? recipientName,
    String? mobileNo,
    double? latitude,
    double? longitude,
    bool? isDefault,
  }) {
    return DeliveryAddressModel(
      id: id ?? this.id,
      label: label ?? this.label,
      shortAddress: shortAddress ?? this.shortAddress,
      districtName: districtName ?? this.districtName,
      cityName: cityName ?? this.cityName,
      regionName: regionName ?? this.regionName,
      streetName: streetName ?? this.streetName,
      buildingNo: buildingNo ?? this.buildingNo,
      zipCode: zipCode ?? this.zipCode,
      closestPlace: closestPlace ?? this.closestPlace,
      recipientName: recipientName ?? this.recipientName,
      mobileNo: mobileNo ?? this.mobileNo,
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
      isDefault: isDefault ?? this.isDefault,
    );
  }
}

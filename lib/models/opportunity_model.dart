class OpportunityModel {
  int productId;
  int unitId;
  String? productName;
  OpportunityModel({required this.productId, required this.unitId, this.productName});
  Map<String, dynamic> toJson() {
    return {
      "productId": productId,
      "unitId": unitId,
      "productName": productName
    };
  }
}

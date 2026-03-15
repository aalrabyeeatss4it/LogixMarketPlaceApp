class DeliveryInfoModel {
  final int productId;
  final double fee;
  final double vat;
  final String date;

  DeliveryInfoModel({
    required this.productId,
    required this.fee,
    required this.vat,
    required this.date,
  });

  factory DeliveryInfoModel.fromJson(Map<String, dynamic> json) {
    return DeliveryInfoModel(
      productId: json['productId'] ?? 0,
      fee: (json['fee'] ?? 0).toDouble(),
      vat: (json['vat'] ?? 0).toDouble(),
      date: json['date'] ?? '',
    );
  }

  double totalFee(){
    double totalFee = double.parse((fee + (fee * vat / 100)).toStringAsFixed(2));
    print("totalFee:"+totalFee.toString());
    return totalFee;
  }
  Map<String, dynamic> toJson() {
    return {
      'productId': productId,
      'fee': fee,
      'date': date,
    };
  }
}
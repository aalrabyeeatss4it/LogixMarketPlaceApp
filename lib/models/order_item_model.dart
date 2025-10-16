class OrderItemModel{
  int productId;
  int unitId;
  double price;
  dynamic quantity;
  String vat;

  OrderItemModel({
    required this.productId,
    required this.unitId,
    required this.price,
    required this.quantity,
    required this.vat,
  });

  factory OrderItemModel.fromJson(Map<String, dynamic> json) {
    return OrderItemModel(
      productId: json['productId'] ?? 0,
      unitId: json['unitId'] ?? 0,
      price: json['price'],
      quantity: json['quantity'],
      vat: json['vat']?.toString() ?? '0',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'productId': productId,
      'unitId': unitId,
      'price': price,
      'quantity': quantity,
      'vat': vat,
    };
  }
}
import 'package:logix_market_place/models/cart_item_model.dart';

import '../common/api_paths.dart';

class OrderItemModel{
  int productId;
  int unitId;
  double price;
  dynamic quantity;
  double vat;
  String? productName;
  String? thumbPath;

  OrderItemModel({
    required this.productId,
    required this.unitId,
    required this.price,
    required this.quantity,
    required this.vat,
    this.productName,
    this.thumbPath,
  });

  factory OrderItemModel.fromJson(Map<String, dynamic> json) {
    return OrderItemModel(
      productId: json['productId'] ?? 0,
      unitId: json['unitId'] ?? 0,
      price: json['price'],
      quantity: json['quantity'],
      vat: json['vat'] ?? 0,
      productName: json['productName'] ?? "",
      thumbPath: json['thumbPath'] ?? "",
    );
  }
  factory OrderItemModel.fromCartItem(CartItemModel item) {
    return OrderItemModel(
      productId: item.product.id,
      unitId: item.product.unitId,
      price: double.parse(item.product.getPrice()),
      quantity: item.quantity.value,
      vat: item.product.vat,
    );
  }

  String getThumbPath(){
    String path = thumbPath??"no_image.jpg";
    if(path.isEmpty){
      path = "no_image.jpg";
    }
    return erpUrl()+imagesDirPath()+path;
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
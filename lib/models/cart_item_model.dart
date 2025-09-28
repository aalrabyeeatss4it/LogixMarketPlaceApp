import 'package:logix_market_place/models/product_model.dart';

class CartItemModel {
  ProductModel product;
  int quantity;
  CartItemModel({required this.product, required this.quantity});

  factory CartItemModel.fromJson(Map<String, dynamic> json) {
    return CartItemModel(
        product: ProductModel.fromJson(json['product']),
        quantity: json['quantity']);
  }

  static List<CartItemModel> fromJsonList(List<dynamic> jsonList){
    return jsonList.map((item)=> CartItemModel.fromJson(item)).toList();
  }
}

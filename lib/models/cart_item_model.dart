import 'package:get/get.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:logix_market_place/models/product_model.dart';

class CartItemModel {
  ProductModel product;
  RxInt quantity = 1.obs;
  // RxBool selected = false.obs;

  CartItemModel({required this.product});

  factory CartItemModel.fromJson(Map<String, dynamic> json) {
    var item =  CartItemModel(product: ProductModel.fromJson(json['product']));
    item.quantity.value = json['quantity'];
    return item;
  }

  toJson() {
    var itemJson = {};
    itemJson["quantity"] = quantity.value;
    itemJson["product"] = product.toJson();
    return itemJson;
  }

  static List<CartItemModel> fromJsonList(List<dynamic> jsonList){
    return jsonList.map((item)=> CartItemModel.fromJson(item)).toList();
  }
}

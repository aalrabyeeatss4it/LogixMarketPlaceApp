import 'dart:convert';

import 'package:http/http.dart';
import 'package:logix_market_place/common/api_paths.dart';
import 'package:logix_market_place/models/cart_item_model.dart';
import 'package:logix_market_place/services/service_result.dart';

class CartService {
  Future<ServiceResult> addItem(CartItemModel item) async {
    Response response = await post(Uri.parse(baseUrl + categoryPath));
    if (response.statusCode == 200) {
      return SuccessStatus();
    }
    return FailureStatus(errorMessage: 'message');
  }

  Future<ServiceResult> removeItem(CartItemModel item) async {
    Response response = await post(Uri.parse(baseUrl + categoryPath));
    if (response.statusCode == 200) {
      return SuccessStatus();
    }
    return FailureStatus(errorMessage: 'message');
  }

  Future<ServiceResult> incrementQuantity(CartItemModel item) async {
    Response response = await post(Uri.parse(baseUrl + categoryPath));
    if (response.statusCode == 200) {
      return SuccessStatus();
    }
    return FailureStatus(errorMessage: 'message');
  }

  Future<ServiceResult> decrementQuantity(CartItemModel item) async {
    Response response = await post(Uri.parse(baseUrl + categoryPath));
    if (response.statusCode == 200) {
      return SuccessStatus();
    }
    return FailureStatus(errorMessage: 'message');
  }

  Future<List<CartItemModel>> getList() async {
    Response response = await get(Uri.parse(baseUrl + categoryPath));
    if (response.statusCode == 200) {
      var list = CartItemModel.fromJsonList(jsonDecode(response.body));
      return list;
    }
    return [];
  }
}

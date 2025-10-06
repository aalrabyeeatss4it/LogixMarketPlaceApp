import 'dart:convert';

import 'package:http/http.dart';
import 'package:logix_market_place/common/api_paths.dart';
import 'package:logix_market_place/models/cart_item_model.dart';
import 'package:logix_market_place/models/product_model.dart';
import 'package:logix_market_place/services/service_result.dart';

class FavService {
  Future<ServiceResult> addItem(ProductModel item) async {
    Response response = await post(Uri.parse(baseUrl + categoriesPath));
    if (response.statusCode == 200) {
      return SuccessStatus();
    }
    return FailureStatus(errorMessage: 'message');
  }

  Future<ServiceResult> removeItem(ProductModel item) async {
    Response response = await post(Uri.parse(baseUrl + categoriesPath));
    if (response.statusCode == 200) {
      return SuccessStatus();
    }
    return FailureStatus(errorMessage: 'message');
  }

  Future<List<ProductModel>> getList() async {
    Response response = await get(Uri.parse(baseUrl + categoriesPath));
    if (response.statusCode == 200) {
      var list = ProductModel.fromJsonList(jsonDecode(response.body));
      return list;
    }
    return [];
  }
}

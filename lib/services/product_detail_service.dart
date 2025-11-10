import 'dart:convert';

import 'package:http/http.dart';
import 'package:logix_market_place/common/api_paths.dart';
import 'package:logix_market_place/models/product_model.dart';
import 'package:logix_market_place/services/my_service.dart';

class ProductDetailService extends MyService {
  Future<ProductModel?> getProduct(int productID, int qty) async {
    Response response = await getData(productsByIdPath+"${productID}"+"?qty=${qty}");
    if (response.statusCode == 200) {
      var product = ProductModel.fromJson(jsonDecode(response.body));
      return product;
    }
    return null;
  }

  Future<List<ProductModel>> getRelatedProducts() async {
    Response response = await get(Uri.parse(baseUrl + relatedProductsByIdPath));
    if (response.statusCode == 200) {
      var list = ProductModel.fromJsonList(jsonDecode(response.body));
      return list;
    }
    return [];
  }
}

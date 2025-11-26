import 'dart:convert';

import 'package:http/http.dart';
import 'package:logix_market_place/common/api_paths.dart';
import 'package:logix_market_place/models/product_model.dart';
import 'package:logix_market_place/services/my_service.dart';
import 'package:logix_market_place/services/product_detail_service.dart';

class GuestProductDetailService extends ProductDetailService {
  @override
  Future<ProductModel?> getProduct(int productID, int qty) async {
    Response response = await getData("$guestProductsByIdPath${productID}?qty=${qty}");
    if (response.statusCode == 200) {
      var product = ProductModel.fromJson(jsonDecode(response.body));
      return product;
    }
    return null;
  }

  @override
  Future<List<ProductModel>> getRelatedProducts(int productID) async {
    Response response = await getData("$guestRelatedProductsByIdPath$productID");
    if (response.statusCode == 200) {
      var list = ProductModel.fromJsonList(jsonDecode(response.body));
      return list;
    }
    return [];
  }
}

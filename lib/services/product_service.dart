import 'dart:convert';

import 'package:http/http.dart';
import 'package:logix_market_place/common/api_paths.dart';
import 'package:logix_market_place/models/product_model.dart';

class ProductService{

  Future<List<ProductModel>> getAll() async {
    Response response  = await get(Uri.parse(baseUrl+productsPath));
    if(response.statusCode == 200){
      var list = ProductModel.fromJsonList(jsonDecode(response.body));
      return list;
    }
    return [];
  }

  Future<List<ProductModel>> getByCategory(int categoryId) async {
    Response response  = await get(Uri.parse("$baseUrl$productsByCategoryPath/$categoryId"));
    if(response.statusCode == 200){
      var list = ProductModel.fromJsonList(jsonDecode(response.body));
      return list;
    }
    return [];
  }
}
import 'dart:convert';

import 'package:http/http.dart';
import 'package:logix_market_place/common/api_paths.dart';
import 'package:logix_market_place/models/product_model.dart';

class ProductService{

  Future<List<ProductModel>> getRecentlyArrived() async {
    Response response  = await get(Uri.parse(baseUrl+recentlyArrivedPath));
    if(response.statusCode == 200){
      var list = ProductModel.fromJsonList(jsonDecode(response.body));
      return list;
    }
    return [];
  }

  Future<List<ProductModel>> getMostRequested() async {
    Response response  = await get(Uri.parse(baseUrl+mostRequestedPath));
    if(response.statusCode == 200){
      var list = ProductModel.fromJsonList(jsonDecode(response.body));
      return list;
    }
    return [];
  }

  Future<List<ProductModel>> getRelated() async {
    Response response  = await get(Uri.parse(baseUrl+mostRequestedPath));
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
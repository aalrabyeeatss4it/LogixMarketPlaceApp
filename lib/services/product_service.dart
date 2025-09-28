import 'dart:convert';

import 'package:http/http.dart';
import 'package:logix_market_place/common/api_paths.dart';
import 'package:logix_market_place/models/product_model.dart';

class ProductService{

  Future<List<ProductModel>> getList() async {
    Response response  = await get(Uri.parse(baseUrl+categoryPath));
    if(response.statusCode == 200){
      var list = ProductModel.fromJsonList(jsonDecode(response.body));
      return list;
    }
    return [];
  }
}
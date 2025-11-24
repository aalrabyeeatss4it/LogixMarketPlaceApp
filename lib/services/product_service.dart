import 'dart:convert';

import 'package:http/http.dart';
import 'package:logix_market_place/common/api_paths.dart';
import 'package:logix_market_place/models/product_model.dart';
import 'package:logix_market_place/services/my_service.dart';

import '../controllers/login_controller.dart';

class ProductService extends MyService{

  Future<List<ProductModel>> getRecentlyArrived(String filters) async {
    Response response  = await getData("$recentlyArrivedPath?$filters");
    if(response.statusCode == 200){
      var list = ProductModel.fromJsonList(jsonDecode(response.body));
      return list;
    }
    return [];
  }

  Future<List<ProductModel>> getGuestProducts(String filters) async {
    Response response  = await getData("$guestProductsPath?$filters");
    if(response.statusCode == 200){
      var list = ProductModel.fromJsonList(jsonDecode(response.body));
      return list;
    }
    return [];
  }

  Future<List<ProductModel>> getMostRequested() async {
    Response response  = await getData(mostRequestedPath);
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

  Future<List<ProductModel>> getByCategory(String filters) async {
    Response response  = await getData("$recentlyArrivedPath?$filters");
    if(response.statusCode == 200){
      var list = ProductModel.fromJsonList(jsonDecode(response.body));
      return list;
    }
    return [];
  }
}
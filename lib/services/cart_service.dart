import 'dart:convert';

import 'package:http/http.dart';
import 'package:logix_market_place/common/api_paths.dart';
import 'package:logix_market_place/models/cart_item_model.dart';

class CartService{

  Future<void> addItem(CartItemModel item) async{
    Response response = await post(Uri.parse(baseUrl+categoryPath));
    if(response.statusCode==200){

    }
  }

  Future<void> removeItem(CartItemModel item) async{
    Response response = await post(Uri.parse(baseUrl+categoryPath));
    if(response.statusCode==200){
    }
  }

  Future<void> incrementQuantity(CartItemModel item) async{
    Response response = await post(Uri.parse(baseUrl+categoryPath));
    if(response.statusCode==200){
    }
  }

  Future<void> decrementQuantity(CartItemModel item) async{
    Response response = await post(Uri.parse(baseUrl+categoryPath));
    if(response.statusCode==200){
    }
  }

  Future<List<CartItemModel>> getList() async{
    Response response = await get(Uri.parse(baseUrl+categoryPath));
    if(response.statusCode==200){
      var list = CartItemModel.fromJsonList(jsonDecode(response.body));
      return list;
    }
    return [];
  }

}
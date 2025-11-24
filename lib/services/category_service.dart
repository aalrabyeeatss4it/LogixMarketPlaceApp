import 'dart:convert';

import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart';
import 'package:logix_market_place/models/category_model.dart';

import '../common/api_paths.dart';
import '../common/storage/local_storage.dart';
import 'my_service.dart';

class CategoryService  extends MyService{
  Future<List<CategoryModel>> getAll() async {
    Response response = await getData(categoriesPath);
    if (response.statusCode == 200) {
      var catList = CategoryModel.fromJsonList(jsonDecode(response.body));
      return catList;
    }
    return [];
  }
  Future<List<CategoryModel>> getGuestCategories() async {
    Response response = await getData(guestCategoriesPath);
    if (response.statusCode == 200) {
      var catList = CategoryModel.fromJsonList(jsonDecode(response.body));
      return catList;
    }
    return [];
  }
}

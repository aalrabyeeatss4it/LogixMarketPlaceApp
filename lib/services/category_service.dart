import 'dart:convert';

import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart';
import 'package:logix_market_place/models/category_model.dart';

import '../common/api_paths.dart';

class CategoryService {
  final box = GetStorage();
  Future<List<CategoryModel>> getAll() async {
    Response response = await get(Uri.parse(baseUrl + categoriesPath),headers: {
      "Authorization":"Bearer "+ box.read("token")
    });
    if (response.statusCode == 200) {
      var catList = CategoryModel.fromJsonList(jsonDecode(response.body));
      return catList;
    }
    return [];
  }
}

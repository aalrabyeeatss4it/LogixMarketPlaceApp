import 'dart:convert';

import 'package:http/http.dart';
import 'package:logix_market_place/models/category_model.dart';

import '../common/api_paths.dart';

class CategoryService {
  Future<List<CategoryModel>> getList() async {
    Response response = await get(Uri.parse(baseUrl + categoriesPath));
    if (response.statusCode == 200) {
      var catList = CategoryModel.fromJsonList(jsonDecode(response.body));
      return catList;
    }
    return [];
  }
}

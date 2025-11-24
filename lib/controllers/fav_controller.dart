import 'dart:convert';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:logix_market_place/models/product_model.dart';

import 'login_controller.dart';

class FavController extends GetxController {
  final box = GetStorage();
  RxList<ProductModel> items = <ProductModel>[].obs;

  @override
  void onInit() {
    super.onInit();
    loadFav();
  }

  saveFav(){
    var jsonList = items.map((item)=> item.toJson()).toList();
    box.write("fav", jsonEncode(jsonList));
  }

  loadFav(){
    var jsonList = box.read("fav");
    if(jsonList != null){
      final List decoded = jsonDecode(jsonList);
      var favItems = decoded.map((json)=> ProductModel.fromJson(json)).toList();
      items.assignAll(favItems);
    }
  }

  Future<void> addItem(ProductModel item) async {
    if(!Get.put(LoginController()).checkLoggedIn()) return;
    items.add(item);
    saveFav();
  }

  Future<void> removeItem(ProductModel item) async {
    items.remove(item);
    saveFav();
  }

  Future<void> removeById(int productId) async {
    items.removeWhere((item) => item.id == productId);
    saveFav();
  }

  bool inFav(int productId) {
    return items.any((item) => item.id == productId);
  }

  void clear() {
      items.clear();
  }
}

import 'dart:convert';

import 'package:get/get.dart';
import 'package:get/get_rx/get_rx.dart';
import 'package:get_storage/get_storage.dart';
import 'package:logix_market_place/services/cart_service.dart';
import 'package:logix_market_place/services/service_result.dart';

import '../mock/mock_cart_service.dart';
import '../models/cart_item_model.dart';

class CartController extends GetxController {
  final box = GetStorage();

  RxList<CartItemModel> items = <CartItemModel>[].obs;
  CartService cartService = Get.put(MockCartService());
  RxInt selectedItemsCount = 0.obs;
  RxBool loading = true.obs;
  @override
  void onInit() {
    super.onInit();
    loadCart();
    ever(items, (_) => saveCart());
  }

  void loadCart(){
    var itemsJson = box.read("cart");
    if (itemsJson != null) {
      final List decoded = jsonDecode(itemsJson);
      items.assignAll(decoded.map((e)=> CartItemModel.fromJson(e)).toList());
    }
  }

  void saveCart(){
    var itemsJson = items.map((item) => item.toJson()).toList();
    box.write("cart", jsonEncode(itemsJson));
  }

  Future<void> addItem(CartItemModel item) async {
    items.add(item);
  }

  Future<void> removeItem(CartItemModel item) async {
    items.remove(item);
  }

  void clearCart() {
    items.clear();
  }

  Future<void> incrementQuantity(CartItemModel item) async {
    item.quantity.value = item.quantity.value+1;
    saveCart();
  }

  Future<void> decrementQuantity(CartItemModel item) async {
    if(item.quantity.value <= 1){
      items.remove(item);
    }
    else{
      item.quantity.value = item.quantity.value - 1;
    }
    saveCart();
  }

  void selectAll(){
    selectedItemsCount.value = 0;
    for (var item in items) {
      item.selected.value = true;
      selectedItemsCount.value = selectedItemsCount.value +1;
    }
  }
  void deSelectAll(){
    selectedItemsCount.value = 0;
    for (var item in items) {
      item.selected.value = false;
    }
    selectedItemsCount.value = 0;
  }
  void updateSelectedCount(bool selected){
    if(selected){
      selectedItemsCount.value = selectedItemsCount.value +1;
    }
    else{
      selectedItemsCount.value = selectedItemsCount.value -1;
    }
  }


  bool inCart(int productId) {
    return items.any((item) => item.product.id == productId);
  }

  int getQty(int productId) {
    int index = items.indexWhere((item) => item.product.id == productId);
    return items[index].quantity.value;
  }


}

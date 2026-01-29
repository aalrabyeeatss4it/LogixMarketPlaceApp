import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/get_rx.dart';
import 'package:get_storage/get_storage.dart';
import '../common/storage/local_storage.dart';
import '../models/cart_item_model.dart';
import '../services/product_detail_service.dart';
import 'login_controller.dart';

class CartController extends GetxController {
  final box = GetStorage();

  ProductDetailService productDetailService = Get.put(ProductDetailService());
  RxList<CartItemModel> items = <CartItemModel>[].obs;
  RxDouble total = 0.0.obs;
  @override
  void onInit() {
    super.onInit();
    loadCart();
    ever(items, (_) => saveCart());
  }

  void loadCart() {
    var itemsJson = box.read("cart");
    var tot = 0.0;
    if (itemsJson != null) {
      final List decoded = jsonDecode(itemsJson);
      items.assignAll(decoded.map((e) {
        var item = CartItemModel.fromJson(e);
        tot += item.product.priceIncludeVat * item.quantity.value;
        return item;
      }).toList());
      total.value = tot;
    }
  }

  void saveCart() {
    var itemsJson = items.map((item){
      return item.toJson();
    }).toList();
    box.write("cart", jsonEncode(itemsJson));
    calcTotal();
  }
  void calcTotal() {
    var tot = 0.0;
    for (var item in items) {
      tot += item.product.priceIncludeVat*item.quantity.value;
    }
    total.value = tot;
  }

  Future<bool> addItem(CartItemModel item) async {
    if(!isLoggedIn()) {
      Get.snackbar(
        'Almost there',
        'Log in to continue adding items to your cart',
        snackPosition: SnackPosition.BOTTOM,
        colorText: Colors.black,
        mainButton: TextButton(
          onPressed: () => Get.toNamed('/login'),
          child: const Text(
            'LOGIN',
            style: TextStyle(color: Colors.black),
          ),
        ),
      );
      return false;
    }
    if(item.product.inventoryBalance.value > 1){
      items.add(item);
      saveCart();
      return true;
    }
    return false;
  }

  Future<void> removeItem(CartItemModel item) async {
    items.remove(item);
    saveCart();
  }

  void clearCart() {
    items.clear();
    saveCart();
  }

  Future<void> incrementQuantity(CartItemModel item) async {
    if(item.product.inventoryBalance.value > item.quantity.value){
      item.quantity.value = item.quantity.value + 1;
      var p = await productDetailService.getProduct(item.product.id, item.quantity.value);
      item.product.basePrice.value = p!.basePrice.value;
      item.product.discountPercentage.value = p.discountPercentage.value;
      saveCart();
    }
  }

  Future<void> setQuantity(int qty,CartItemModel item) async {
    if(item.product.inventoryBalance.value > qty){
      item.quantity.value = qty;
      var p = await productDetailService.getProduct(item.product.id, qty);
      item.product.basePrice.value = p!.basePrice.value;
      item.product.discountPercentage.value = p.discountPercentage.value;
      saveCart();
    }
  }

  Future<void> decrementQuantity(CartItemModel item) async {
    if (item.quantity.value <= 1) {
      items.remove(item);
    } else {
      item.quantity.value = item.quantity.value - 1;
      var p = await productDetailService.getProduct(item.product.id, item.quantity.value);
      item.product.basePrice.value = p!.basePrice.value;
      item.product.discountPercentage.value = p.discountPercentage.value;
    }
    saveCart();
  }

  bool inCart(int productId) {
    return items.any((item) => item.product.id == productId);
  }

  CartItemModel? getItem(int productId) {
    bool isExists =  items.any((item) => item.product.id == productId);
    if(isExists){
      var foundItem = items.firstWhere((item) => item.product.id == productId);
      return foundItem;
    }
    return null;
  }

  int getQty(int productId) {
    int index = items.indexWhere((item) => item.product.id == productId);
    if(index<0) {
      return 0;
    }
    return items[index].quantity.value;
  }
}

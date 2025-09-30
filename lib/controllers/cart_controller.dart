import 'package:get/get.dart';
import 'package:logix_market_place/features/cart/cart_screen.dart';
import 'package:logix_market_place/services/cart_service.dart';

import '../models/cart_item_model.dart';

class CartController extends GetxController{
  RxList<CartItemModel> items= <CartItemModel>[].obs;
  CartService cartService = Get.put(CartService());

  RxBool loading = true.obs;
  RxInt quantity = 1.obs;

  Future<void> addItem(CartItemModel item) async{
    loading.value = true;
    cartService.addItem(item);
    loading.value = false;
  }

  Future<void> removeItem(CartItemModel item) async{
    loading.value = true;
    cartService.removeItem(item);
    loading.value = false;
  }

  Future<void> incrementQuantity(CartItemModel item) async{
    loading.value = true;
    cartService.incrementQuantity(item);
    loading.value = false;
  }

  Future<void> decrementQuantity(CartItemModel item) async{
    loading.value = true;
    cartService.decrementQuantity(item);
    loading.value = false;
  }

  Future<void> getList() async{
    loading.value = true;
    var list = await cartService.getList();
    items.value = list;
    loading.value = false;
  }

}
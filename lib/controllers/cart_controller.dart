import 'package:get/get.dart';
import 'package:get/get_rx/get_rx.dart';
import 'package:logix_market_place/services/cart_service.dart';
import 'package:logix_market_place/services/service_result.dart';

import '../mock/mock_cart_service.dart';
import '../models/cart_item_model.dart';

class CartController extends GetxController {
  RxList<CartItemModel> items = <CartItemModel>[].obs;
  CartService cartService = Get.put(MockCartService());
  RxInt selectedItemsCount = 0.obs;
  RxBool loading = true.obs;
  RxInt quantity = 1.obs;

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
    print('selected:'+selected.toString());
    print('selectedItemsCount:'+selectedItemsCount.value.toString());
  }

  Future<void> addItem(CartItemModel item) async {
    loading.value = true;
    var result = await cartService.addItem(item);
    if (result is SuccessStatus) {
      items.add(item);
    }
    else{
    }
    loading.value = false;
  }

  bool inCart(int productId) {
    return items.any((item) => item.product.id == productId);
  }

  int getQty(int productId) {
    int index = items.indexWhere((item) => item.product.id == productId);
    return items[index].quantity.value;
  }

  Future<void> removeItem(CartItemModel item) async {
    loading.value = true;
    items.remove(item);
    var result = cartService.removeItem(item);
    if (result is SuccessStatus) {
      items.remove(item);
    }
    loading.value = false;
  }

  Future<void> incrementQuantity(CartItemModel item) async {
    loading.value = true;
    item.quantity.value = item.quantity.value+1;
    cartService.incrementQuantity(item);
    loading.value = false;
  }

  Future<void> decrementQuantity(CartItemModel item) async {
    loading.value = true;
    if(item.quantity.value <= 1){
      items.remove(item);
    }else{
      item.quantity.value = item.quantity.value - 1;
    }
    cartService.decrementQuantity(item);
    loading.value = false;
  }

  Future<void> getList() async {
    loading.value = true;
    var list = await cartService.getList();
    items.value = list;
    loading.value = false;
  }
}

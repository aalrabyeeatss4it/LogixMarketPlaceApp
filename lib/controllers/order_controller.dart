import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:logix_market_place/models/order_model.dart';
import 'package:logix_market_place/services/service_result.dart';
import '../common/dialogs/bottom_sheets.dart';
import '../common/nav/page_routes.dart';
import '../models/cart_item_model.dart';
import '../models/order_item_model.dart';
import '../services/order_service.dart';
import '../services/product_detail_service.dart';
import 'cart_controller.dart';

class OrderController extends GetxController{
  final CartController cartController = Get.put(CartController());
  RxInt paymentMethod = 2.obs;
  RxInt shipmentMethod = 1.obs;
  OrderService service = Get.put(OrderService());
  RxList<OrderModel> orders = <OrderModel>[].obs;

  var isLoading = false.obs;
  int page = 1;
  bool hasMore = true;
  ScrollController scroll = ScrollController();

  @override
  void onInit() {
    super.onInit();
    scroll.addListener(() {
      if (scroll.position.pixels == scroll.position.maxScrollExtent) {
        getOrders();
      }
    });
  }

  Future<void> orderAgain(String orderCode) async {
    ProductDetailService productDetailService = Get.put(ProductDetailService());
    try{
      var serviceResult = await service.getOrder(orderCode);
      if(serviceResult is SuccessStatus<OrderModel>){
        if(serviceResult.data != null){
          var order = serviceResult.data!;
          for(var orderItem in order.items!){
            int qty = (orderItem.quantity as num).toInt();
            var product = await productDetailService.getProduct(orderItem.productId, qty);
            if(product != null && orderItem.quantity <= product.inventoryBalance.value){
              var item = CartItemModel(product: product);
              item.quantity.value = qty;
              cartController.addItem(item);
            }
          }
        }
      }
    }
    catch(ex){
      print(ex.toString());
    }
  }
  Future<void> createOrder(String deliveryAddressId) async {
    if(isLoading.value) return;
    try {
      isLoading.value = true;
      var order = OrderModel();
      order.deliveryAddressId = deliveryAddressId;
      order.shipmentMethod = shipmentMethod.value.toString();
      order.paymentMethod = paymentMethod.value.toString();
      order.items =
          cartController.items.map((item) => OrderItemModel.fromCartItem(item))
              .toList();
      var serviceResult = await service.createOrder(order);
      if (serviceResult is SuccessStatus<String>) {
        print("serviceResult:" + serviceResult.data!);
        Get.back();
        cartController.clearCart();
        var createdOrder = await getOrder(serviceResult.data!);
        showSuccessOrderBottomSheet(onConfirm: () {
          Get.toNamed(RouteNames.orderDetailsPage, arguments: createdOrder);
        });
      }
      else if (serviceResult is FailureStatus) {
        Get.back();
        showFailureBottomSheet(
            errorMessage: serviceResult.errorMessage, onConfirm: () {});
      }
      else {
        print("serviceResult:" + serviceResult.toString());
        Get.back();
        showFailureBottomSheet(onConfirm: () {});
      }
    }
    catch(ex){
      isLoading.value = false;
    }
    finally {
      isLoading.value = false;
    }
  }

  Future<OrderModel?> getOrder(String orderId) async {
    isLoading.value = true;
    try{
      var serviceResult = await service.getOrder(orderId);
      if(serviceResult is SuccessStatus<OrderModel>){
        if(serviceResult.data != null){
          var order = serviceResult.data!;
          return order;
        }
      }
    }
    catch(ex){
      isLoading.value = false;
    }
    finally {
      isLoading.value = false;
    }
    return null;
  }
  Future<void> getOrders() async {
    if(isLoading.value || !hasMore) return;
    isLoading.value = true;
    try{
      String filters = "page=$page";
      var serviceResult = await service.getOrders(filters);
      if(serviceResult is SuccessStatus<List<OrderModel>>){
        if(serviceResult.data!.isEmpty){
          hasMore = false;
        }
        else{
          orders.addAll(serviceResult.data!);
          page++;
        }
      }
    }
    catch(ex){
      isLoading.value = false;
    }
    finally {
      isLoading.value = false;
    }
  }
}
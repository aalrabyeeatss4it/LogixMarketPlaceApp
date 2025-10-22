import 'package:get/get.dart';
import 'package:logix_market_place/models/order_model.dart';
import 'package:logix_market_place/services/service_result.dart';
import '../common/dialogs/bottom_sheets.dart';
import '../models/order_item_model.dart';
import '../services/order_service.dart';
import 'cart_controller.dart';

class OrderController extends GetxController{
  final CartController cartController = Get.put(CartController());
  RxInt paymentMethod = 1.obs;
  RxInt shipmentMethod = 1.obs;
  OrderService service = Get.put(OrderService());
  RxList<OrderModel> orders = <OrderModel>[].obs;

  Future<void> createOrder(String deliveryAddressId) async {
    var order = OrderModel();
    order.deliveryAddressId = deliveryAddressId;
    order.shipmentMethod = shipmentMethod.value.toString();
    order.paymentMethod = paymentMethod.value.toString();
    order.items = cartController.getSelectedItems().map((item)=> OrderItemModel.fromCartItem(item)).toList();
    var serviceResult = await service.createOrder(order);
    if(serviceResult is SuccessStatus){
      Get.back();
      showSuccessBottomSheet(onConfirm: (){});
    }
    else{
      Get.back();
      showFailureBottomSheet(onConfirm: (){});
    }
  }

  Future<void> getOrders() async {
    var serviceResult = await service.getOrders();
    if(serviceResult is SuccessStatus<List<OrderModel>>){
      orders.value = serviceResult.data!;

    }
  }
}
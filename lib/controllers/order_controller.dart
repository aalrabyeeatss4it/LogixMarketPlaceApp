import 'package:get/get.dart';
import 'package:logix_market_place/models/order_model.dart';

class OrderController extends GetxController{
  Rx<OrderModel> orderModel = OrderModel().obs;
  RxInt paymentMethod = 1.obs;
  RxInt shipmentMethod = 1.obs;

}
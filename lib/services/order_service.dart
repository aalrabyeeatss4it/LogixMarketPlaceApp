import 'dart:convert';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart';
import 'package:logix_market_place/models/order_model.dart';
import 'package:logix_market_place/services/service_result.dart';
import '../common/api_paths.dart';


class OrderService{

  final box = GetStorage();
  Future<ServiceResult> createOrder(OrderModel order) async {
    Response response = await post(Uri.parse(baseUrl + ordersPath),
        body: jsonEncode(order.toJson()),
      headers: {
        "Content-Type": "application/json",
        "Authorization":"Bearer " + box.read("token")
      }
    );
    if (response.statusCode == 200) {
      return SuccessStatus();
    }
    return FailureStatus(errorMessage: 'message');
  }

  Future<ServiceResult<dynamic>> getOrders() async {
    Response response = await get(Uri.parse(baseUrl + ordersPath),
        headers: {
          "Content-Type": "application/json",
          "Authorization":"Bearer "+ box.read("token")
    }
    );
    if(response.statusCode==200){
      var responseJson= jsonDecode(response.body);
      List<OrderModel> orders = OrderModel.fromJsonList(responseJson);
      return SuccessStatus(data: orders);
    }
    return FailureStatus(errorMessage: "errorMessage");
  }

  Future<ServiceResult> getOrder() async {
    Response response = await get(Uri.parse(baseUrl + ordersPath),
        headers: {
          "Content-Type": "application/json",
          "Authorization":"Bearer "+ box.read("token")
        }
    );
    if(response.statusCode==200){
      var responseJson= jsonDecode(response.body);
      OrderModel order = OrderModel.fromJson(responseJson);
      return SuccessStatus(data: order);
    }
    return FailureStatus(errorMessage: "errorMessage");
  }
}
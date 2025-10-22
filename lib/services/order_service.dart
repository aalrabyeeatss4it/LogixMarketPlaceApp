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
    print("response:"+response.statusCode.toString());
    print("response:"+response.body.toString());
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
    print("response.statusCode:"+response.statusCode.toString());
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
          "Authorization":"Bearer "+ "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOiIxODIzOSIsInVzZXJOYW1lIjoiQ3VzdG9tZXIiLCJCcmFuY2hJZCI6IjEiLCJDdXN0b21lck5hbWUiOiLYsdi22KciLCJDdXN0b21lclBob25lIjoiKzk2NjU1MTM5MjAwNyIsIkN1c3RvbWVySUQiOiIxMDEzNSIsIlVTRVJfRlVMTE5BTUUiOiLYp9it2YXYryDYqNmGINis2KfYsSDYp9mE2YTZhyDYp9mE2K3Yp9ix2KvZiiIsIlVTRVJfUEtfSUQiOiIxIiwiVXNlcl9UeXBlX0lEIjoiMiIsIkZhY2lsaXR5X0lEIjoiMSIsIm5iZiI6MTc2MDg2MTc2MSwiZXhwIjoxNzYwODY1MzYxLCJpYXQiOjE3NjA4NjE3NjEsImlzcyI6IkxvZ2l4IE1hcmtldHBsYWNlIiwiYXVkIjoiTG9naXggQ2xpZW50cyJ9.xjzy_7I2YC6Xm_ejYGPDBPgbc7I3xhx8D2_wkmvQwhE"
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
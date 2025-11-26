import 'dart:convert';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart';
import 'package:logix_market_place/models/order_model.dart';
import 'package:logix_market_place/services/my_service.dart';
import 'package:logix_market_place/services/service_result.dart';
import '../common/api_paths.dart';
import '../common/storage/local_storage.dart';


class OrderService extends MyService{
  Future<ServiceResult> createOrder(OrderModel order) async {
    Response response = await postData(ordersPath,order.toJson());
    if (response.statusCode == 200) {
      return SuccessStatus();
    }
    if (response.statusCode == 400) {
      var json = jsonDecode(response.body);
      return FailureStatus(errorMessage: json['message']??'حدث خطأ اثناء تنفيذ الطلب، الرجاء المحاولة مرة اخرى.');
    }
    return FailureStatus(errorMessage: 'حدث خطأ اثناء تنفيذ الطلب، الرجاء المحاولة مرة اخرى.');
  }

  Future<ServiceResult<dynamic>> getOrders(String filters) async {
    Response response = await getData("$ordersPath?$filters");
    if(response.statusCode==200){
      var responseJson= jsonDecode(response.body);
      List<OrderModel> orders = OrderModel.fromJsonList(responseJson);
      return SuccessStatus(data: orders);
    }
    return FailureStatus(errorMessage: "errorMessage");
  }

  Future<ServiceResult> getOrder() async {
    Response response = await getData(ordersPath);
    if(response.statusCode==200){
      var responseJson= jsonDecode(response.body);
      OrderModel order = OrderModel.fromJson(responseJson);
      return SuccessStatus(data: order);
    }
    return FailureStatus(errorMessage: "errorMessage");
  }
}
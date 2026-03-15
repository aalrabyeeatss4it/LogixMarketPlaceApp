import 'dart:convert';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart';
import 'package:logix_market_place/models/order_model.dart';
import 'package:logix_market_place/services/my_service.dart';
import 'package:logix_market_place/services/service_result.dart';
import '../common/api_paths.dart';
import '../common/storage/local_storage.dart';
import '../models/delivery_cost_request_model.dart';
import '../models/delivery_fee_model.dart';
import '../models/shipment_option_model.dart';


class OrderService extends MyService{
  Future<ServiceResult<dynamic>> createOrder(OrderModel order) async {
    Response response = await postData(ordersPath,order.toJson());
    print("createOrder"+response.statusCode.toString());
    print("createOrder"+response.body.toString());
    if (response.statusCode == 200) {
      var json = jsonDecode(response.body);
      return SuccessStatus<String>(data: json['data'] as String);
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
      print("getOrders");
      List<OrderModel> orders = OrderModel.fromJsonList(responseJson);
      print("getOrders");
      return SuccessStatus(data: orders);
    }
    return FailureStatus(errorMessage: "errorMessage");
  }

  Future<ServiceResult<dynamic>> getShipmentOptions() async {
    Response response = await getData(shipmentPath);
    if(response.statusCode==200){
      var responseJson= jsonDecode(response.body);
      ShipmentOptionModel shipmentOption = ShipmentOptionModel.fromJson(responseJson);
      return SuccessStatus(data: shipmentOption);
    }
    return FailureStatus(errorMessage: "errorMessage");
  }

  Future<ServiceResult<dynamic>> getDeliveryCost(DeliveryCostRequestModel  costRequestModel) async {
    Response response = await putData(deliveryInfoPath, costRequestModel.toJson());
    if(response.statusCode==200){
      var responseJson= jsonDecode(response.body);
      DeliveryInfoModel deliveryFeeModel = DeliveryInfoModel.fromJson(responseJson);
      return SuccessStatus(data: deliveryFeeModel);
    }
    return FailureStatus(errorMessage: "errorMessage");
  }

  Future<ServiceResult<dynamic>> getOrder(String orderId) async {
    Response response = await getData("$ordersPath/$orderId");
    if(response.statusCode==200){
      var responseJson= jsonDecode(response.body);
      OrderModel order = OrderModel.fromJson(responseJson);
      return SuccessStatus(data: order);
    }
    return FailureStatus(errorMessage: "errorMessage");
  }
}
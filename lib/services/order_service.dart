import 'dart:convert';
import 'package:http/http.dart';
import 'package:logix_market_place/models/order_model.dart';
import 'package:logix_market_place/services/service_result.dart';
import '../common/api_paths.dart';


class OrderService{

  Future<ServiceResult> createOrder(OrderModel order) async {
    Response response = await post(Uri.parse(baseUrl + newOrderPath),body: jsonEncode(order));
    if (response.statusCode == 200) {
      return SuccessStatus();
    }
    return FailureStatus(errorMessage: 'message');
  }

}
import 'dart:convert';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart';
import 'package:logix_market_place/models/order_model.dart';
import 'package:logix_market_place/services/my_service.dart';
import 'package:logix_market_place/services/service_result.dart';
import '../common/api_paths.dart';
import '../common/storage/local_storage.dart';
import '../models/customer_invoices_model.dart';

class InvoiceService extends MyService{
  Future<ServiceResult<dynamic>> getInvoices(String filters) async {
    Response response = await getData("$invoicesPath?$filters");
    if(response.statusCode==200){
      var responseJson= jsonDecode(response.body);
      CustomerInvoicesModel customerInvoicesModel = CustomerInvoicesModel.fromJson(responseJson);
      return SuccessStatus(data: customerInvoicesModel);
    }
    return FailureStatus(errorMessage: "errorMessage");
  }

  Future<ServiceResult> getInvoice() async {
    Response response = await getData(invoicesPath);
    if(response.statusCode==200){
      var responseJson= jsonDecode(response.body);
      OrderModel order = OrderModel.fromJson(responseJson);
      return SuccessStatus(data: order);
    }
    return FailureStatus(errorMessage: "errorMessage");
  }
}
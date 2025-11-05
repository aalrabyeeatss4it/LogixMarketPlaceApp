import 'dart:convert';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart';
import 'package:logix_market_place/models/order_model.dart';
import 'package:logix_market_place/services/service_result.dart';
import '../common/api_paths.dart';
import '../common/storage/local_storage.dart';
import '../models/customer_invoices_model.dart';

class InvoiceService{
  final box = GetStorage();
  Future<ServiceResult<dynamic>> getInvoices() async {
    Response response = await get(Uri.parse(baseUrl + invoicesPath),
        headers: {
          "Content-Type": "application/json",
          "Authorization":"Bearer "+ box.read(tokenIndex)
    }
    );
    print("response.statusCode:"+response.statusCode.toString());
    if(response.statusCode==200){
      var responseJson= jsonDecode(response.body);
      CustomerInvoicesModel customerInvoicesModel = CustomerInvoicesModel.fromJson(responseJson);
      return SuccessStatus(data: customerInvoicesModel);
    }
    return FailureStatus(errorMessage: "errorMessage");
  }

  Future<ServiceResult> getInvoice() async {
    Response response = await get(Uri.parse(baseUrl + invoicesPath),
        headers: {
          "Content-Type": "application/json",
          "Authorization":"Bearer "+ box.read(tokenIndex)
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
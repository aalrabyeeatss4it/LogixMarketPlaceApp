import 'dart:convert';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart';
import 'package:logix_market_place/models/order_model.dart';
import 'package:logix_market_place/models/trans_model.dart';
import 'package:logix_market_place/services/my_service.dart';
import 'package:logix_market_place/services/service_result.dart';
import '../common/api_paths.dart';
import '../common/storage/local_storage.dart';
import '../models/customer_invoices_model.dart';

class AccountStatementService extends MyService{
  Future<ServiceResult<dynamic>> getStatement(String filters) async {
    Response response = await getData("$accountStatementPath?$filters");
    if(response.statusCode==200){
      var responseJson= jsonDecode(response.body);
      List<TransModel> transList = TransModel.fromJsonList(responseJson);
      return SuccessStatus(data: transList);
    }
    return FailureStatus(errorMessage: "errorMessage");
  }
}
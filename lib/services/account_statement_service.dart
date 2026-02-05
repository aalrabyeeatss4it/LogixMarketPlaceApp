import 'dart:convert';
import 'package:http/http.dart';
import 'package:logix_market_place/models/trans_model.dart';
import 'package:logix_market_place/services/my_service.dart';
import 'package:logix_market_place/services/service_result.dart';
import '../common/api_paths.dart';
import '../models/customer_balance_model.dart';

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
  Future<ServiceResult<dynamic>> getBalance() async {
    Response response = await getData(balancePath);
    if(response.statusCode==200){
      var responseJson= jsonDecode(response.body);
      CustomerBalanceModel balanceModel = CustomerBalanceModel.fromJson(responseJson);
      return SuccessStatus(data: balanceModel);
    }
    return FailureStatus(errorMessage: "errorMessage");
  }
}
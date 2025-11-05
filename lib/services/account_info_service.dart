import 'dart:convert';
import 'package:http/http.dart';
import 'package:logix_market_place/services/service_result.dart';
import '../common/api_paths.dart';
import '../models/user_password_model.dart';
import 'my_service.dart';

class AccountInfoService extends MyService{
  Future<ServiceResult> changePwd(UserPasswordModel pwd) async {
    Response response = await postData(changePasswordPath,pwd.toJson());
    if (response.statusCode == 200) {
      return SuccessStatus();
    }
    var error = jsonDecode(response.body);
    return FailureStatus(errorMessage: error["message"]);
  }
}
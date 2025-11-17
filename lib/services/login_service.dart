import 'dart:convert';
import 'package:http/http.dart';
import 'package:logix_market_place/services/my_service.dart';
import 'package:logix_market_place/services/service_result.dart';
import '../common/api_paths.dart';
import '../common/dialogs/bottom_sheets.dart';
import '../models/authorized_user_model.dart';
import '../models/user_cred_model.dart';

class LoginService extends MyService{

  Future<ServiceResult> login(UserCredModel user) async {
    try{
      showLoading();
      Response response = await postLogin(loginPath,user.toJson());
      hideLoading();
      if (response.statusCode == 200) {
        AuthorizedUserModel userModel = AuthorizedUserModel.fromJson(jsonDecode(response.body));
        return SuccessStatus(data: userModel);
      }
      if (response.statusCode == 400) {
        var json = jsonDecode(response.body);
        return FailureStatus(errorMessage: json['message']??'بيانات الدخول غير صحيحة، الرجاء التأكد والمحاولة مرة اخرى.');
      }
      return FailureStatus(errorMessage: 'بيانات الدخول غير صحيحة، الرجاء التأكد والمحاولة مرة اخرى.');
    }
    catch(ex){
      hideLoading();
      return  FailureStatus(errorMessage: 'مشكلة في الوصول، الرجاء التأكد والمحاولة مرة اخرى.'+ex.toString());
    }
  }

}
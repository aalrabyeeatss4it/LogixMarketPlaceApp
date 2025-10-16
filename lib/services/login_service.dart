import 'dart:convert';
import 'package:http/http.dart';
import 'package:logix_market_place/services/service_result.dart';
import '../common/api_paths.dart';
import '../models/authorized_user_model.dart';
import '../models/user_cred_model.dart';

class LoginService{

  Future<ServiceResult> login(UserCredModel user) async {
    Response response = await post(Uri.parse(baseUrl + loginPath),
        headers: {
          "Content-Type": "application/json",
        },
        body: jsonEncode(user.toJson())
    );
    if (response.statusCode == 200) {
      AuthorizedUserModel userModel = AuthorizedUserModel.fromJson(jsonDecode(response.body));
      return SuccessStatus(data: userModel);
    }
    return FailureStatus(errorMessage: 'بيانات الدخول غير صحيحة.');
  }

}
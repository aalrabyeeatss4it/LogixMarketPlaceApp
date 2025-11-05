import 'dart:convert';

import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart';

import '../common/api_paths.dart';
import '../common/storage/local_storage.dart';
import '../controllers/login_controller.dart';

class MyService {
  final box = GetStorage();
  Future<Response> postData(String path, Map<String, dynamic> json) async{
    Response response = await post(Uri.parse(baseUrl + path),
        body: jsonEncode(json),
        headers: {
          "Content-Type": "application/json",
          "Authorization":"Bearer " + box.read(tokenIndex)
        }
    );
    return response;
  }

  Future<Response> getData(String path) async{
    Response response = await get(Uri.parse(baseUrl + path),
        headers: {
          "Content-Type": "application/json",
          "Authorization":"Bearer " + box.read(tokenIndex)
        }
    );
    if(response.statusCode==401){
      print("getData:"+response.statusCode.toString());
      // LoginController.logout();
    }
    return response;
  }
}
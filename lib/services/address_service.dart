import 'dart:convert';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart';
import 'package:logix_market_place/models/delivery_address_model.dart';
import 'package:logix_market_place/services/service_result.dart';
import '../common/api_paths.dart';
import '../common/storage/local_storage.dart';

class AddressService {
  final box = GetStorage();

  Future<ServiceResult<dynamic>> getAddress() async {
    Response response = await get(Uri.parse(baseUrl + addressesPath), headers: {
      "Content-Type": "application/json",
      "Authorization": "Bearer " + box.read(tokenIndex)
    });
    print("getAddress"+response.statusCode.toString());
    if (response.statusCode == 200) {
      var responseJson = jsonDecode(response.body);
      DeliveryAddressModel address = DeliveryAddressModel.fromJson(responseJson);
      return SuccessStatus(data: address);
    }
    return FailureStatus(errorMessage: "errorMessage");
  }
}

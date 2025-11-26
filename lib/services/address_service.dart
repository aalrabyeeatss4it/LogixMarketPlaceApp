import 'dart:convert';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart';
import 'package:logix_market_place/models/delivery_address_model.dart';
import 'package:logix_market_place/services/my_service.dart';
import 'package:logix_market_place/services/service_result.dart';
import '../common/api_paths.dart';
import '../common/storage/local_storage.dart';

class AddressService extends MyService {
  Future<ServiceResult<dynamic>> getAddress() async {
    Response response = await getData(addressesPath);
    if (response.statusCode == 200) {
      var responseJson = jsonDecode(response.body);
      DeliveryAddressModel address = DeliveryAddressModel.fromJson(responseJson);
      return SuccessStatus(data: address);
    }
    return FailureStatus(errorMessage: "errorMessage");
  }

  Future<ServiceResult<dynamic>> updateAddress(DeliveryAddressModel address) async {
    Response response = await postData(updateAddressPath,address.toJson());
    if (response.statusCode == 200) {
      return SuccessStatus();
    }
    return FailureStatus(errorMessage: "errorMessage");
  }
}

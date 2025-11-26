import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import '../common/dialogs/bottom_sheets.dart';
import '../models/delivery_address_model.dart';
import '../services/address_service.dart';
import '../services/service_result.dart';

class DeliveryAddressController extends GetxController {
  AddressService service = Get.put(AddressService());
  Rx<DeliveryAddressModel?> defaultAddress = DeliveryAddressModel().obs;

  RxBool isDefaultAddress = true.obs;

  TextEditingController regionNameController = TextEditingController();
  TextEditingController districtNameController = TextEditingController();
  TextEditingController streetNameController = TextEditingController();
  TextEditingController zipCodeController = TextEditingController();
  TextEditingController buildingNoController = TextEditingController();
  TextEditingController mobileNoController = TextEditingController();

  Future<void> getAddresses() async {
    try{
      var serviceResult = await service.getAddress();
      if(serviceResult is SuccessStatus<DeliveryAddressModel>){
        defaultAddress.value = serviceResult.data!;
        defaultAddress.value?.id = "1";
        regionNameController.text = defaultAddress.value?.regionName??"";
        districtNameController.text = defaultAddress.value?.districtName??"";
        streetNameController.text = defaultAddress.value?.streetName??"";
        zipCodeController.text = defaultAddress.value?.zipCode??"";
        buildingNoController.text = defaultAddress.value?.buildingNo??"";
        mobileNoController.text = defaultAddress.value?.mobileNo??"";
      }
      else{
        // defaultAddress.value?.id = "1";
      }
    }
    catch(ex){
      // defaultAddress.value?.id = "1";
    }
  }

  Future<void> updateAddress() async {
    try{
       defaultAddress.value?.regionName =regionNameController.text ;
       defaultAddress.value?.districtName = districtNameController.text;
       defaultAddress.value?.streetName   = streetNameController.text;
       defaultAddress.value?.zipCode      = zipCodeController.text;
       defaultAddress.value?.buildingNo   = buildingNoController.text;
       defaultAddress.value?.mobileNo     = mobileNoController.text;
      var serviceResult = await service.updateAddress(defaultAddress.value!);
       if (serviceResult is SuccessStatus) {
         showSuccessBottomSheet(onConfirm: () {  });
       } else if (serviceResult is FailureStatus) {
         showFailureBottomSheet(onConfirm: () {  },errorMessage: serviceResult.errorMessage);
       }
    }
    catch(ex){
      print("ex="+ex.toString());
    }
  }
}

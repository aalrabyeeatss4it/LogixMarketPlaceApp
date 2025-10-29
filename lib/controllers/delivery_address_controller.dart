import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
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
  }

  initAddress(){
    defaultAddress.value =  DeliveryAddressModel(
      id: "100",
      recipientName: "محمد حرب",
      streetName: "شارع 11",
      buildingName: "فيلا 90",
      buildingNo: "1, 4",
      closestPlace: "",
      zipCode: "الرياض",
      districtName: "حي الياسمين",
      regionName: "منطقة الرياض",
      mobileNo: "",
    );
  }

}

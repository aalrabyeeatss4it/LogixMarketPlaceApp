import 'package:get/get.dart';
import '../models/delivery_address_model.dart';

class DeliveryAddressController extends GetxController {
  Rx<DeliveryAddressModel?> defaultAddress = DeliveryAddressModel().obs;

  @override
  void onInit() {
    super.onInit();
    getAddresses();
  }

  Future<void> getAddresses() async {
    defaultAddress.value =  DeliveryAddressModel(
      id: "100",
      recipientName: "محمد حرب",
      streetName: "شارع 11",
      buildingName: "فيلا 90",
      floorNo: "1, 4",
      closestPlace: "",
      city: "الرياض",
      neighborhoodName: "حي الياسمين",
      governance: "منطقة الرياض",
      recipientMobileNo: "",
    );
  }

}

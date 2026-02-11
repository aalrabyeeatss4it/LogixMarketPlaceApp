import 'package:flutter/cupertino.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/get_rx.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../common/dialogs/bottom_sheets.dart';
import '../models/delivery_address_model.dart';
import '../services/address_service.dart';
import '../services/service_result.dart';

class DeliveryAddressController extends GetxController {
  Rx<DeliveryAddressModel?> defaultAddress = DeliveryAddressModel().obs;
  AddressService service = Get.put(AddressService());
  Rx<DeliveryAddressModel> address = DeliveryAddressModel().obs;
  RxList<DeliveryAddressModel> addresses = <DeliveryAddressModel>[].obs;
  Rx<LatLng> selectedLocation = const LatLng(0, 0).obs;

  final labelCtrl = TextEditingController();
  final regionCtrl = TextEditingController();
  final cityCtrl = TextEditingController();
  final districtCtrl = TextEditingController();
  final streetCtrl = TextEditingController();
  final zipCtrl = TextEditingController();
  final buildingNoCtrl = TextEditingController();
  final mobileNoController = TextEditingController();
  final recipientNameController = TextEditingController();
  final closestPlaceController = TextEditingController();


  RxBool isDefaultAddress = true.obs;

  TextEditingController regionNameController = TextEditingController();
  TextEditingController districtNameController = TextEditingController();
  TextEditingController streetNameController = TextEditingController();
  TextEditingController zipCodeController = TextEditingController();
  TextEditingController buildingNoController = TextEditingController();

  var isLoading = false.obs;
  int page = 1;
  bool hasMore = true;

  ScrollController scroll = ScrollController();

  @override
  void onInit() {
    super.onInit();
    scroll.addListener(() {
      if (scroll.position.pixels == scroll.position.maxScrollExtent) {
        getAddresses();
      }
    });
  }
  void syncTextControllers() {
    print("address.value.regionName "+address.value.regionName!);
    buildingNoCtrl.text = address.value.buildingNo ?? '';
    labelCtrl.text = address.value.label ?? '';
    regionCtrl.text = address.value.regionName ?? '';
    cityCtrl.text = address.value.cityName ?? '';
    districtCtrl.text = address.value.districtName ?? '';
    streetCtrl.text = address.value.streetName ?? '';
    zipCtrl.text = address.value.zipCode ?? '';

    recipientNameController.text =address.value.recipientName??"";
    mobileNoController.text = address.value.mobileNo?? "";
    closestPlaceController.text = address.value.closestPlace??"";
  }

  @override
  void onClose() {
    clear();
    super.onClose();
  }

  Future<void> getAddresses() async {
    if(isLoading.value || !hasMore) return;
    isLoading.value = true;
    try{
      String filters = "page=$page";
      var serviceResult = await service.getAddresses();
      print("getAddresses");
      if(serviceResult is SuccessStatus<List<DeliveryAddressModel>>){
        print("getAddresses");
        if(serviceResult.data!.isEmpty){
          hasMore = false;
        }
        else{
          addresses.addAll(serviceResult.data!);
          page++;
        }
      }
    }
    catch(ex){
      print(ex.toString());
      isLoading.value = false;
    }
    finally {
      isLoading.value = false;
    }
    // try{
    //   var serviceResult = await service.getAddresses();
    //   if(serviceResult is SuccessStatus<List<DeliveryAddressModel>>){
    //     // defaultAddress.value = serviceResult.data!;
    //     // // defaultAddress.value?.id = "1";
    //     // regionNameController.text = defaultAddress.value?.regionName??"";
    //     // districtNameController.text = defaultAddress.value?.districtName??"";
    //     // streetNameController.text = defaultAddress.value?.streetName??"";
    //     // zipCodeController.text = defaultAddress.value?.zipCode??"";
    //     // buildingNoController.text = defaultAddress.value?.buildingNo??"";
    //     // mobileNoController.text = defaultAddress.value?.mobileNo??"";
    //   }
    //   else{
    //     // defaultAddress.value?.id = "1";
    //   }
    // }
    // catch(ex){
    //   // defaultAddress.value?.id = "1";
    // }
  }

  Future<void> setAddress(DeliveryAddressModel a) async {
    address.value = a;
    syncTextControllers();
  }
  Future<void> saveAddress() async {
    try{
      address.value.recipientName= recipientNameController.text;
      address.value.mobileNo= mobileNoController.text;
      address.value.closestPlace= closestPlaceController.text;
      var serviceResult = await service.updateAddress(address.value);
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

  void clear(){
    buildingNoCtrl.text = "";
    labelCtrl.text = "";
    regionCtrl.text = "";
    cityCtrl.text = "";
    districtCtrl.text = "";
    streetCtrl.text = "";
    zipCtrl.text = "";
    mobileNoController.text = "";
    recipientNameController.text = "";
    closestPlaceController.text = "";
    address.value.shortAddress = null;

  }

  Future<void> getCurrentLocation() async {
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    selectedLocation.value = LatLng(position.latitude, position.longitude);
  }
  Future<void> updateLocation(LatLng location) async {
    selectedLocation.value = location;
    address.update((a) {
      a?.latitude = location.latitude;
      a?.longitude = location.longitude;
    });
    address.refresh();
    await _reverseGeocode(location);
  }

  Future<void> _reverseGeocode(LatLng location) async {
    final placemarks = await placemarkFromCoordinates(
        location.latitude, location.longitude);

    if (placemarks.isNotEmpty) {
      final p = placemarks.first;
      final updated = address.value.copyWith(
        streetName: p.street,
        districtName: p.subLocality,
        cityName: p.locality,
        regionName: p.administrativeArea,
        zipCode: p.postalCode,
        shortAddress: '${p.street}, ${p.subLocality}, ${p.locality}',
      );
      address.value = updated;
      syncTextControllers();
    }
  }
}

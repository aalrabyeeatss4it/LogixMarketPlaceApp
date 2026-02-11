import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import '../common/dialogs/bottom_sheets.dart';
import '../models/opportunity_model.dart';
import '../models/product_model.dart';
import '../services/provide_request_service.dart';
import '../services/service_result.dart';

class OpportunityController extends GetxController {
  final box = GetStorage();
  ProvideRequestService provideService = Get.put(ProvideRequestService());

  RxList<ProductModel> products = <ProductModel>[].obs;
  var isLoading = false.obs;
  int page = 1;
  bool hasMore = true;
  ScrollController scroll = ScrollController();

  @override
  void onInit() {
    super.onInit();
    scroll.addListener(() {
      if (scroll.position.pixels == scroll.position.maxScrollExtent) {
        getRequests();
      }
    });
  }

  Future<void> requestToProvide(ProductModel product) async {
    OpportunityModel opportunityModel = OpportunityModel(productId: product.id,unitId: product.unitId,productName: product.name);
    var serviceResult = await provideService.createRequest(opportunityModel);
    if(serviceResult is SuccessStatus<String>){
      Get.back();
      showSuccessOrderBottomSheet(onConfirm: () {
        Get.back();
      });
    }
    else if(serviceResult is FailureStatus){
      Get.back();
      showFailureBottomSheet(errorMessage: serviceResult.errorMessage,onConfirm: () {  });
    }
    else{
      Get.back();
      showFailureBottomSheet(onConfirm: (){});
    }
  }

  Future<void> getRequests() async {
    if(isLoading.value || !hasMore) return;
    isLoading.value = true;
    try{
      String filters = "page=$page";
      var serviceResult = await provideService.getRequests(filters);

      print("getRequests");
      if(serviceResult is SuccessStatus<List<ProductModel>>){
        print("getRequests");
        if(serviceResult.data!.isEmpty){
          hasMore = false;
        }
        else{
          products.addAll(serviceResult.data!);
          page++;
        }
      }
    }
    catch(ex){
      isLoading.value = false;
    }
    finally {
      isLoading.value = false;
    }
  }
}

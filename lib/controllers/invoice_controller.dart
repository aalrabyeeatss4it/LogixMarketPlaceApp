import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:logix_market_place/services/service_result.dart';
import '../models/customer_invoices_model.dart';
import '../services/invoice_service.dart';

class InvoiceController extends GetxController{
  InvoiceService service = Get.put(InvoiceService());
  Rx<CustomerInvoicesModel>  invoicesModel = CustomerInvoicesModel(invoices: []).obs;

  var isLoading = false.obs;
  int page = 1;
  bool hasMore = true;
  ScrollController scroll = ScrollController();

  @override
  void onInit() {
    super.onInit();
    scroll.addListener(() {
      if (scroll.position.pixels == scroll.position.maxScrollExtent) {
        getInvoices();
      }
    });
  }
  Future<void> getInvoices() async {
    if(isLoading.value || !hasMore) return;
    isLoading.value = true;
    try{
      String filters = "page=$page";
      var serviceResult = await service.getInvoices(filters);
      if(serviceResult is SuccessStatus<CustomerInvoicesModel>){
        if(serviceResult.data!.invoices!.isEmpty){
          hasMore = false;
        }
        else{
          invoicesModel.value.summaryDto = serviceResult.data!.summaryDto;
          invoicesModel.value.invoices?.addAll(serviceResult.data!.invoices!);
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
  // Future<void> getInvoices() async {
  //   var serviceResult = await service.getInvoices();
  //   if(serviceResult is SuccessStatus<CustomerInvoicesModel>){
  //     invoicesModel.value = serviceResult.data!;
  //
  //   }
  // }
}
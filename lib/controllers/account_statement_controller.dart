import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:logix_market_place/models/trans_model.dart';
import 'package:logix_market_place/services/account_statement_service.dart';

import '../models/customer_balance_model.dart';
import '../services/service_result.dart';

class AccountStatementController extends GetxController{
  AccountStatementService service = Get.put(AccountStatementService());
  RxList<TransModel>  transModel = <TransModel>[].obs;
  Rx<CustomerBalanceModel>  balance =CustomerBalanceModel().obs;

  var isLoading = false.obs;
  int page = 1;
  bool hasMore = true;
  ScrollController scroll = ScrollController();

  @override
  void onInit() {
    super.onInit();
    getBalance();
    scroll.addListener(() {
      if (scroll.position.pixels == scroll.position.maxScrollExtent) {
        getStatement();
      }
    });
  }
  Future<void> getBalance() async {
    // isLoading.value = true;
    try{
      var serviceResult = await service.getBalance();
      if(serviceResult is SuccessStatus<CustomerBalanceModel>){
        if(serviceResult.data != null){
          balance.value = serviceResult.data!;
        }
      }
    }
    catch(ex){
      // isLoading.value = false;
    }
    finally {
      // isLoading.value = false;
    }
  }

  Future<void> getStatement() async {
    if(isLoading.value || !hasMore) return;
    isLoading.value = true;
    try{
      String filters = "page=$page";
      var serviceResult = await service.getStatement(filters);
      if(serviceResult is SuccessStatus<List<TransModel>>){
        if(serviceResult.data!.isEmpty){
          hasMore = false;
        }
        else{
          transModel.value = serviceResult.data!;
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
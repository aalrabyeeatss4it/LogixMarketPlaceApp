import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:logix_market_place/common/storage/local_storage.dart';
import 'package:logix_market_place/models/trans_model.dart';
import 'package:logix_market_place/services/account_statement_service.dart';

import '../common/theme/colors.dart';
import '../models/customer_balance_model.dart';
import '../services/service_result.dart';

class AccountStatementController extends GetxController{
  AccountStatementService service = Get.put(AccountStatementService());
  RxList<TransModel>  transModel = <TransModel>[].obs;
  Rx<CustomerBalanceModel>  balance =CustomerBalanceModel(debit: 0).obs;
  RxBool popupShown = false.obs;

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
  void showDebitBottomSheetIfNeeded() {
    bool alreadyShown = box.read(debitPopupShown) ?? false;

    if (balance.value.debit > 0 && !alreadyShown) {
      box.write(debitPopupShown, true);
      Get.bottomSheet(
        Container(
          padding: const EdgeInsets.all(20),
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(
              top: Radius.circular(25),
            ),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 50,
                height: 5,
                margin: const EdgeInsets.only(bottom: 20),
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              const Icon(Icons.warning_amber_rounded,size: 60,color: Colors.red),
              Text('pending debit'.tr,style: const TextStyle(fontSize: 20,fontWeight: FontWeight.bold)),
              const SizedBox(height: 10),
              Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    '${balance.value.debit.toStringAsFixed(2)} ',
                    style: const TextStyle(fontSize: 22,fontWeight: FontWeight.bold,color: Colors.red
                    ),
                  ),
                  Image.asset('icons/riyal.png' ,width: 16,color: Colors.red),
                ],
              ),
              const SizedBox(height: 10),

              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () => Get.back(),
                  style: ElevatedButton.styleFrom(
                      backgroundColor:  primaryColor,
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))
                  ),
                  child: Text("ok".tr, style: const TextStyle(fontSize: 16),),
                ),
              ),
            ],
          ),
        ),
        isDismissible: true,
        enableDrag: true,
      );
    }
  }
  Future<void> getBalance() async {
    try{
      var serviceResult = await service.getBalance();
      if(serviceResult is SuccessStatus<CustomerBalanceModel>){
        if(serviceResult.data != null){
          balance.value = serviceResult.data!;
        }
      }
    }
    catch(ex){
    }
    finally {
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
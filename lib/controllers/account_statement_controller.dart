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
              Image.asset("icons/wallet.png",width: 60,),
              SizedBox(height: 10,),
              Text('pending debit desc'.tr,style: const TextStyle(fontSize: 20,fontWeight: FontWeight.w900)),
              const SizedBox(height: 10),
              Card(
                color: primaryColor.withOpacity(0.05),
                elevation: 0,
                shape: RoundedRectangleBorder(borderRadius: const BorderRadius.all(Radius.circular(10)),side: BorderSide(color: primaryColor.withOpacity(0.2),width: 01)),
                child: Padding(
                  padding: const EdgeInsets.all(12),
                  child: Column(
                    children: [

                      Text('pending debit'.tr,style: const TextStyle(color: Colors.grey,fontSize: 20,fontWeight: FontWeight.bold)),
                      const SizedBox(height: 10),
                      Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            '${balance.value.debit.toStringAsFixed(2)} ',
                            style: const TextStyle(fontSize: 28,fontWeight: FontWeight.bold,color: primaryColor
                            ),
                          ),
                          Image.asset('icons/riyal.png' ,width: 20,color: Colors.black),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 25),

              SizedBox(
                height: 50,
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () => Get.back(),
                  style: ElevatedButton.styleFrom(
                      backgroundColor:  primaryColor,
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset("icons/credit.png", width: 25,),
                      SizedBox(width: 10,),
                      Text('show payment methods'.tr, style: const TextStyle(fontSize: 20),),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(12),
                child: TextButton(onPressed: (){}, child: Text('later'.tr, style: TextStyle(color: Colors.black, fontSize: 24),)),
              )
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
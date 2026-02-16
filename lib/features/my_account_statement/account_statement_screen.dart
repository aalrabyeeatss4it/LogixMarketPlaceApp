import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:logix_market_place/features/my_account_statement/transaction_card.dart';
import '../../common/nav/app_bar_custom.dart';
import '../../common/theme/colors.dart';
import '../../controllers/account_statement_controller.dart';
import '../../controllers/token_controller.dart';


class AccountStatementScreen extends StatefulWidget {
  const AccountStatementScreen({super.key});

  @override
  State<StatefulWidget> createState() => _AccountStatementScreenState();
}
class _AccountStatementScreenState extends State<AccountStatementScreen>{
  final AccountStatementController statementController = Get.put(AccountStatementController());
  TokenController tokenController = Get.put(TokenController());

  @override
  void initState() {
    super.initState();
    statementController.getStatement();
    tokenController.getToken();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBarCustom(title: "home"),
        body: Column(
            children: [
              SizedBox(height: 16.h),
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(right: 20,top: 8),
                    child: Text('account statement'.tr,style: const TextStyle(fontSize: 20,fontWeight: FontWeight.w900),),
                  ),
                ],
              ),
              const Divider(),
              Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                      decoration: BoxDecoration(color: remainingColor,borderRadius: BorderRadius.circular(8)),
                      child: SizedBox(
                        width: 170.w,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8.0,horizontal: 14),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text('credit limit'.tr,style: const TextStyle(color: Colors.white,fontSize: 14,fontWeight: FontWeight.bold),),
                              const SizedBox(height: 8),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Obx(() => Text(statementController.balance.value.creditLimit??"", style: const TextStyle(color: Colors.white,fontSize: 16))),
                                  const SizedBox(width: 5),
                                  Image.asset('icons/riyal.png' ,width: 18,color: Colors.white),
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(color: paidColor,borderRadius: BorderRadius.circular(8)),
                      child: SizedBox(
                        width: 170.w,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8.0,horizontal: 10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text('balance'.tr,style: const TextStyle(color: Colors.white,fontSize: 14,fontWeight: FontWeight.bold),),
                              const SizedBox(height: 8),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Obx(() => Text(statementController.balance.value.creditBalance??"", style: const TextStyle(color: Colors.white,fontSize: 16))),
                                  const SizedBox(width: 5),
                                  Image.asset('icons/riyal.png' ,width: 18,color: Colors.white),
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(color: unpaidColor,borderRadius: BorderRadius.circular(8)),
                      child: SizedBox(
                        width: 170.w,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8.0,horizontal: 10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text('debit'.tr,style: const TextStyle(color: Colors.white,fontSize: 14,fontWeight: FontWeight.bold),),
                              const SizedBox(height: 8),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Obx(() => Text(statementController.balance.value.getDebit(), style: const TextStyle(color: Colors.white,fontSize: 16))),
                                  const SizedBox(width: 5),
                                  Image.asset('icons/riyal.png' ,width: 18,color: Colors.white),
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                ]
              ),
              const Divider(),
              Expanded(
                child: Obx(() {
                  if (statementController.isLoading.value && statementController.page==1) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  if (statementController.transModel.isEmpty) {
                    return Center(child: Text("No invoices".tr));
                  }
                  return ListView.builder(
                      controller: statementController.scroll,
                      shrinkWrap: true,
                      padding: const EdgeInsets.all(8),
                      itemCount: statementController.transModel.length + 1,
                      itemBuilder: (BuildContext context, int index) {
                        if(index < statementController.transModel.length){
                          return TransactionCard(trans: statementController.transModel[index],ssoToken: tokenController.ssoToken.value,);
                        }
                        else{
                          return (statementController.hasMore && statementController.isLoading.value)?
                          const Padding(
                              padding: EdgeInsets.all(16),
                              child: Center(child: CircularProgressIndicator())
                          ): const SizedBox();
                        }
                      }
                  );
                }
                ),
              )
            ]
        )
    );
  }
}
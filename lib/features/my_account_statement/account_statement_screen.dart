import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:logix_market_place/features/my_account_statement/transaction_card.dart';
import '../../common/nav/app_bar_custom.dart';
import '../../controllers/account_statement_controller.dart';


class AccountStatementScreen extends StatefulWidget {
  const AccountStatementScreen({super.key});

  @override
  State<StatefulWidget> createState() => _AccountStatementScreenState();
}
class _AccountStatementScreenState extends State<AccountStatementScreen>{
  final AccountStatementController statementController = Get.put(AccountStatementController());

  @override
  void initState() {
    super.initState();
    statementController.getStatement();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBarCustom(title: "home"),
        body: Column(
            children: [
              SizedBox(height: 16.h),
              const Row(
                children: [
                  Padding(
                    padding: EdgeInsets.only(right: 20,top: 8),
                    child: Text('كشف حسابي',style: TextStyle(fontSize: 18,fontWeight: FontWeight.w900),),
                  ),
                ],
              ),
              const Divider(),
              Expanded(
                child: Obx(() {
                  if (statementController.isLoading.value && statementController.page==1) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  if (statementController.transModel.isEmpty) {
                    return const Center(child: Text("No invoices"));
                  }
                  return ListView.builder(
                      controller: statementController.scroll,
                      shrinkWrap: true,
                      padding: const EdgeInsets.all(8),
                      itemCount: statementController.transModel.length + 1,
                      itemBuilder: (BuildContext context, int index) {
                        if(index < statementController.transModel.length){
                          return TransactionCard(trans: statementController.transModel[index],);
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
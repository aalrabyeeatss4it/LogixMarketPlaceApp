import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:logix_market_place/common/theme/colors.dart';
import 'package:logix_market_place/controllers/availability_order_controller.dart';
import '../../common/nav/app_bar_custom.dart';
import '../../common/nav/page_routes.dart';
import '../../controllers/invoice_controller.dart';
import '../../controllers/order_controller.dart';
import 'invoice_card.dart';


class InvoicesScreen extends StatefulWidget {
  const InvoicesScreen({super.key});

  @override
  State<StatefulWidget> createState() => _InvoicesScreen();
}
class _InvoicesScreen extends State<InvoicesScreen>{
  final InvoiceController invoiceController = Get.put(InvoiceController());

  @override
  void initState() {
    super.initState();
    invoiceController.getInvoices();
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
              child: Text('فواتيري',style: TextStyle(fontSize: 18,fontWeight: FontWeight.w900),),
            ),
          ],
        ),
        SizedBox(height: 10,),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const SizedBox(width: 15,),
            Container(
              decoration: BoxDecoration(color: remainingColor,borderRadius: BorderRadius.circular(8)),
              child: SizedBox(
                width: 170.w,
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0,horizontal: 14),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Text("إجمالي المستحق",style: TextStyle(color: Colors.white,fontSize: 12,fontWeight: FontWeight.bold),),
                      const SizedBox(height: 12),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Obx(() {
                            if(invoiceController.invoicesModel.value.summaryDto==null) {
                              return Text("",style: TextStyle(color: Colors.white));
                            } else {
                              return Text(invoiceController.invoicesModel.value.summaryDto!.remaining.toString(),style: TextStyle(color: Colors.white,fontSize: 12));
                            }
                          }
                          ),
                          const SizedBox(width: 5),
                          Image.asset('icons/riyal.png' ,width: 18,color: Colors.white),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(width: 5,),
            Container(
              decoration: BoxDecoration(color: unpaidColor,borderRadius: BorderRadius.circular(8)),
              child: SizedBox(
                width: 170.w,
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0,horizontal: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Text("الفواتير غير المسددة",style: TextStyle(color: Colors.white,fontSize: 12,fontWeight: FontWeight.bold),),
                      const SizedBox(height: 12),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Obx(() {
                            if(invoiceController.invoicesModel.value.summaryDto==null) {
                              return const Text("",style: TextStyle(color: Colors.white));
                            } else {
                              return Text(invoiceController.invoicesModel.value.summaryDto!.unpaidCount.toString(),style: TextStyle(color: Colors.white,fontSize: 14));
                            }
                          }
                          )
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(width: 5,),
            Container(
              decoration: BoxDecoration(color: paidColor,borderRadius: BorderRadius.circular(8)),
              child: SizedBox(
                width: 170.w,
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0,horizontal: 18),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Text("تم تسديده",style: TextStyle(color: Colors.white,fontSize: 12,fontWeight: FontWeight.bold),),
                      const SizedBox(height: 12),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Obx(() {
                            if(invoiceController.invoicesModel.value.summaryDto==null) {
                              return const Text("",style: TextStyle(color: Colors.white));
                            } else {
                              return Text(invoiceController.invoicesModel.value.summaryDto!.paid.toString(),style: TextStyle(color: Colors.white,fontSize: 12));
                            }
                          }
                          ),
                          const SizedBox(width: 5),
                          Image.asset('icons/riyal.png' ,width: 18,color: Colors.white),
                        ]
                      )
                    ]
                  )
                )
              )
            ),
            const SizedBox(width: 15,),
          ],
        ),
        SizedBox(height: 12,),
        const Row(
          children: [
            Padding(
              padding: EdgeInsets.only(right: 20,top: 8),
              child: Text('لم يتم تحديد الفواتير المراد تسديدها بعد',style: TextStyle(fontSize: 16,fontWeight: FontWeight.w900),),
            ),
          ],
        ),
        SizedBox(height: 12,),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SizedBox(
                    height: 50,
                    child: TextButton(
                        style: ElevatedButton.styleFrom(
                            elevation: 0,
                            padding: const EdgeInsets.all(5),
                            backgroundColor: secondaryColor,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10)
                            )
                        ),
                        onPressed: () {
                          Get.offAllNamed(RouteNames.checkoutPage,predicate: (route) => route.isFirst);
                        },
                        child: const Text('تابع للدفع الآمن ( 0 فاتورة )',style: TextStyle(color: Colors.white,fontWeight: FontWeight.w700,fontSize: 16))),
                  ),
                ),
              ),
            ],
          ),
        ),
        Divider(),
        Expanded(
          child: SingleChildScrollView(
            child: Obx(() {
              if(invoiceController.invoicesModel.value.invoices==null) {
                return const SizedBox();
              }
              return ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  padding: const EdgeInsets.all(8),
                  itemCount: invoiceController.invoicesModel.value.invoices?.length,
                  itemBuilder: (BuildContext context, int index) {
                    return InvoiceCard(order: invoiceController.invoicesModel.value.invoices![index],);
                  }
              );
            }
            ),
          ),
        )
      ]
    )
  );
}
}
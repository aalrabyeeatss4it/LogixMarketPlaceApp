import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:logix_market_place/features/my_provide_requests/request_product_card.dart';
import '../../common/nav/app_bar_custom.dart';
import '../../common/nav/bottom_nav_bar_custom.dart';
import '../../controllers/opportunity_controller.dart';

class ProvideRequestScreen extends StatefulWidget {
  const ProvideRequestScreen({super.key});
  @override
  State<StatefulWidget> createState() => _ProvideRequestScreenState();
}

class _ProvideRequestScreenState extends State<ProvideRequestScreen> {
  final OpportunityController opportunityController = Get.put(OpportunityController());

  @override
  void initState() {
    super.initState();
    opportunityController.getRequests();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBarCustom(title: "home"),
      body: Container(
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: Column(
            children: [
              SizedBox(height: 16.h),
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(right: 20,top: 8),
                    child: Text('provide orders'.tr,style: const TextStyle(fontSize: 20,fontWeight: FontWeight.w900),),
                  )
                ]
              ),
              Expanded(
                child: Obx(() {
                  if (opportunityController.isLoading.value && opportunityController.page==1) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  if (opportunityController.products.isEmpty) {
                    return Center(
                        child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 150),
                            child: Column(
                                children: [
                                  Image.asset('icons/available-order.png', width: 45,),
                                  Text('empty availability orders'.tr,style: const TextStyle(fontWeight: FontWeight.w800,fontSize: 16),),
                                  TextButton(
                                      onPressed: () {
                                        // Get.toNamed('/secondPage');
                                      },
                                      child: Text(
                                          'browse most requested products'.tr,
                                          style: const TextStyle(
                                            color: Colors.indigo,
                                            decoration: TextDecoration.underline,
                                          )
                                      )
                                  )
                                ]
                            )
                        )
                    );
                  }
                  return ListView.builder(
                      controller: opportunityController.scroll,
                      shrinkWrap: true,
                      padding: const EdgeInsets.all(8),
                      itemCount: opportunityController.products.length+1,
                      itemBuilder: (BuildContext context, int index) {
                        if(index < opportunityController.products.length){
                          return RequestProductCard(product: opportunityController.products[index],);
                        }
                        else{
                          return opportunityController.hasMore  && opportunityController.isLoading.value?
                          const Padding(
                              padding: EdgeInsets.all(16),
                              child: Center(child: CircularProgressIndicator())
                          ): const SizedBox();
                        }
                      }
                  );
                }
                )
              )
            ]
          )
        )
      ),
      bottomNavigationBar: BottomNavBarCustom(currentPage: 3,),
    );
  }
}

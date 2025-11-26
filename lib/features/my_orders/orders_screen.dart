import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:logix_market_place/controllers/order_controller.dart';
import '../../common/nav/app_bar_custom.dart';
import '../../common/nav/bottom_nav_bar_custom.dart';
import 'order_card.dart';

class OrdersScreen extends StatefulWidget {
  const OrdersScreen({super.key});
  @override
  State<StatefulWidget> createState() => _OrdersScreenState();
}

class _OrdersScreenState extends State<OrdersScreen> {
  final OrderController orderController = Get.put(OrderController());

  @override
  void initState() {
    super.initState();
    orderController.getOrders();
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
              SizedBox(height: 25.h),
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Text("طلباتك", style: TextStyle(fontSize: 20, fontWeight: FontWeight.w900))
                  ],
                ),
              ),
              Expanded(
                child: Obx(() {

                  if (orderController.isLoading.value && orderController.page==1) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  if (orderController.orders.isEmpty) {
                    return const Center(child: Text("No orders"));
                  }
                  return ListView.builder(
                      controller: orderController.scroll,
                      shrinkWrap: true,
                      padding: const EdgeInsets.all(8),
                      itemCount: orderController.orders.length+1,
                      itemBuilder: (BuildContext context, int index) {
                        if(index < orderController.orders.length){
                          return OrderCard(order: orderController.orders[index],);
                        }
                        else{
                          return orderController.hasMore?
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
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavBarCustom(currentPage: 3,),
    );
  }
}

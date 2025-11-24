import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:logix_market_place/common/theme/colors.dart';
import '../../common/exit_wrapper.dart';
import '../../common/nav/app_bar_custom.dart';
import '../../common/nav/bottom_nav_bar_custom.dart';
import '../../common/nav/page_routes.dart';
import '../../controllers/profile_controller.dart';

class ProfileScreen extends StatelessWidget{
    ProfileScreen({super.key});

    final List<Option> options = [
      Option(title: 'طلباتي السابقة', subTitle: 'عرض الطلبات, تتبّعها أو إعادة الطلب.', icon: 'icons/my-orders.png', onTap: (){
        Get.toNamed(RouteNames.ordersPage);
      }),
      Option(title: 'المفضلة', subTitle: 'إدارة القوائم، والنقل إلى السلة.', icon: 'icons/favorites.png', onTap: (){
        Get.toNamed(RouteNames.favPage);
      }),
      Option(title: 'عناوين التوصيل', subTitle: 'إضافة وتعديل وحذف عناوين', icon: 'icons/my-addresses.png', onTap: (){
        Get.toNamed(RouteNames.deliveryAddressPage);
      }),
      Option(title: 'فواتيري', subTitle: 'دفع فواتيرك المستحقة مجمعة أو مفردة', icon: 'icons/my-invoices.png', onTap: (){
        Get.toNamed(RouteNames.invoicesPage);
      }),
      Option(title: 'طرق الدفع', subTitle: 'إضافة وتعديل وحذف تفاصيل الدفع', icon: 'icons/payments.png', onTap: (){
        Get.toNamed(RouteNames.paymentMethodsPage);
      }),
      Option(title: 'طلباتي قيد التوفّر', subTitle: 'متابعة المنتجات غير المتاحة ', icon: 'icons/supply-orders.png', onTap: (){
        Get.toNamed(RouteNames.availabilityOrderPage);
      })
    ];

    final ProfileController profileController = Get.put(ProfileController());

    @override
    Widget build(BuildContext context) {
      return ExitWrapper(
        child: Scaffold(
          appBar: AppBarCustom(title: "home"),
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 10.h),
              InkWell(
                onTap: (){
                  Get.offAllNamed(RouteNames.accountSettingPage);
                },
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.w),
                  child: Container(
                    margin: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.15), // shadow color
                          blurRadius: 8,
                          spreadRadius: 1,
                          offset: const Offset(4, 4),
                        ),
                      ],
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 18.0,horizontal: 12),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                    color: primaryColor,
                                    borderRadius: BorderRadius.circular(30)
                                ),
                                child: ClipOval(
                                    child: SizedBox(
                                      width: 60,
                                      height: 60,
                                      child: Center(child: Text( profileController.firstName.isNotEmpty ? profileController.firstName.substring(0, 1) : '',
                                        style: const TextStyle(fontSize: 28,color: Colors.white),)),
                                    )
                                ),
                              ),
                              const SizedBox(width: 12,),
                              Text(profileController.firstName +" "+profileController.lastName,style: TextStyle(fontSize: 16,fontWeight: FontWeight.w700),),
                            ],
                          ),
                          InkWell(
                            child: Image.asset("icons/settings.png",width: 25,),
                            onTap: (){
                              Get.offAllNamed(RouteNames.accountSettingPage);
                              },
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: EdgeInsets.all(16.w),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                            margin: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(12),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.15), // shadow color
                                  blurRadius: 8,
                                  spreadRadius: 1,
                                  offset: const Offset(4, 4),
                                ),
                              ],
                            ),
                            child: Padding(
                                padding: const EdgeInsets.symmetric(vertical: 18.0,horizontal: 18),
                              child: ListView.builder(
                                shrinkWrap: true,
                                itemCount: options.length,
                                physics: const NeverScrollableScrollPhysics(),
                                itemBuilder: (BuildContext context, int index) {
                                  return InkWell(
                                    onTap: () => options[index].onTap(),
                                    child: Column(
                                      children: [
                                        SizedBox(height: 10,),
                                        Row(
                                          children: [
                                            Image.asset(options[index].icon,width: 22,),
                                            const SizedBox(width: 20,),
                                            Expanded(
                                              child: Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  Text(options[index].title,style: const TextStyle(fontSize: 18,fontWeight: FontWeight.bold),),
                                                  Text(options[index].subTitle,style: const TextStyle(fontSize: 16,color: Colors.grey),)
                                                ],
                                              ),
                                            ),
                                            Image.asset("icons/arrow.png",color: Colors.black,width: 7,)
                                          ],
                                        ),
                                        (index<options.length-1)?Divider(color: Colors.grey.withOpacity(0.2),thickness: 1,):SizedBox()
                                      ],
                                    ),
                                  );
                                },
                              ),
                            )
                        ),
                      ]
                    )
                  ),
                ),
              )
            ]
          ),
          bottomNavigationBar: BottomNavBarCustom(currentPage: 3,),
        ),
      );
    }
  }

  class Option{
    late String title;
    late String subTitle;
    late String icon;
    late Function onTap;
    Option({required this.title,required this.subTitle,required this.icon,required this.onTap,});
  }
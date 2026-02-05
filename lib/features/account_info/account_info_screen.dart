import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../common/nav/app_bar_custom.dart';
import '../../common/theme/colors.dart';
import '../../controllers/account_info_controller.dart';

class AccountInfoScreen  extends StatefulWidget {
  const AccountInfoScreen({super.key});

  @override
  State<StatefulWidget> createState()=> _AccountInfoScreenState();
}

class _AccountInfoScreenState extends State<AccountInfoScreen>{
  final AccountInfoController controller = Get.put(AccountInfoController());

  @override
  void initState() {
    super.initState();
    controller.loadData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarCustom(title: "home"),
      body: SingleChildScrollView(
        child: Padding(
            padding: EdgeInsets.all(16.w),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12.0,vertical: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Text('account info'.tr, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w900)),
                        // Text('edit'.tr, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w900,decoration: TextDecoration.underline,color: primaryColor)),
                      ],
                    ),
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Expanded(
                        child: LabeledWidget(label: 'first name'.tr,hint: 'fill first name'.tr,editController:  controller.firstNameController),
                      ),
                      Expanded(
                        child: LabeledWidget(label: 'last name'.tr,hint: 'fill last name'.tr,editController:  controller.lastNameController),
                      ),
                    ],
                  ),
                  LabeledWidget(label: 'customer no'.tr,hint: 'fill customer no'.tr,editController: controller.customerNoController),
                  LabeledWidget(label: 'customer name'.tr,hint: 'fill customer name'.tr,editController: controller.customerNameController),
                  LabeledWidget(label: 'tax no'.tr,hint: 'fill tax no'.tr,editController: controller.taxNoController),
                  LabeledWidget(label: 'mobile no'.tr,hint: 'fill mobile no'.tr,editController: controller.mobileNoController),
                  LabeledWidget(label: 'email'.tr,hint: 'fill email'.tr,editController: controller.emailController),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0,vertical: 20),
                    child: SizedBox(
                      height: 60,
                      child: TextButton(
                          style: ElevatedButton.styleFrom(
                              elevation: 0,
                              padding: const EdgeInsets.all(5),
                              backgroundColor: redColor.withOpacity(0.1),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10)
                              )
                          ),
                          onPressed: () {
                            // loginController.logout();
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text('remove account'.tr,style: TextStyle(color: redColor,fontWeight: FontWeight.w700,fontSize: 18))
                            ],
                          )
                      ),
                    ),
                  ),
                ]
            )
        ),
      ),
      // bottomNavigationBar: Padding(
      //   padding: const EdgeInsets.symmetric(horizontal: 8.0),
      //   child: SizedBox(
      //     height: 60,
      //     child: TextButton(
      //         style: ElevatedButton.styleFrom(
      //             elevation: 0,
      //             padding: const EdgeInsets.all(5),
      //             backgroundColor: primaryColor,
      //             shape: RoundedRectangleBorder(
      //                 borderRadius: BorderRadius.circular(10)
      //             )
      //         ),
      //         onPressed: () {
      //           // loginController.logout();
      //         },
      //         child: const Row(
      //           mainAxisAlignment: MainAxisAlignment.center,
      //           children: [
      //             Text("حفظ",style: TextStyle(color: Colors.white,fontWeight: FontWeight.w700,fontSize: 18))
      //           ],
      //         )
      //     ),
      //   ),
      // ),
    );
  }
}

class LabeledWidget extends StatelessWidget{
  const LabeledWidget({super.key, required this.editController, required this.label, required this.hint});
  final TextEditingController editController;
  final String label;
  final String hint;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
            padding:  EdgeInsets.symmetric(horizontal: 12.0,vertical: 4),
            child: Text(label,style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold),)
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12.0,vertical: 4),
          child: SizedBox(
            height: 65.h,
            child: TextFormField(
              enabled: false,
              controller: editController,
              decoration: InputDecoration(
                  hintText: hint,
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: BorderSide(color: grayBorderColor1.withOpacity(0.1), width: 0.2)
                  )
              ),
            ),
          ),
        ),
      ],
    );
  }

}
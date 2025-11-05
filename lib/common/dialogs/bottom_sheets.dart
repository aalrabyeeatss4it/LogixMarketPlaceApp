import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../theme/colors.dart';

void showFailureBottomSheet({
  required VoidCallback onConfirm,
  String? errorMessage
}) {
  Get.bottomSheet(
      Container(
        width: double.infinity,
        padding: const EdgeInsets.only(top: 20,left: 20,right: 20),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(25)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(height: 20,),
            Image.asset("icons/error.png",height: 40,),
            const SizedBox(height: 10,),
            const Text("حدث خطأ أثناء تنفيذ العملية",
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: errorColor
              ),),
            Text((errorMessage)??"يرجى المحاولة مرة أخرى أو التحقق من اتصالك بالإنترنت",
                style: TextStyle(
                    fontSize: 16,
                    color: Colors.grey
                )
            ),
            const SizedBox(height: 25,),
            Container(
              height: 5,
              width: 150,
              margin: const EdgeInsets.only(bottom: 16),
              decoration: BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.circular(5),
              ),
            ),
          ],
        ),
      )
  );
}


void showSuccessOrderBottomSheet({
  required VoidCallback onConfirm,
}) {
  Get.bottomSheet(
      Container(
        padding: const EdgeInsets.only(top: 20,left: 20,right: 20),
        decoration: const BoxDecoration(
          color: primaryColor,
          borderRadius: BorderRadius.vertical(top: Radius.circular(25)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(height: 20,),
            Image.asset("icons/paid.png",height: 40,),
            const SizedBox(height: 10,),
            const Text("تم الدفع بنجاح!",
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.white
              ),),
            const Text(" تمت معالجة دفعتك بنجاح, تم الآن تأكيد طلبك.",
                style: TextStyle(
                    fontSize: 16,
                    color: Colors.white
                )
            ),
            const SizedBox(height: 40,),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                      onPressed: () {
                        // Get.back();
                        onConfirm();
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: secondaryColor,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                              "تتبّع طلبي",
                              style: TextStyle(color: Colors.white,fontWeight: FontWeight.w700,fontSize: 16)
                          ),
                          const SizedBox(width: 10,),
                          Padding(
                            padding: const EdgeInsets.only(left: 20.0),
                            child: Image.asset('icons/white-arrow.png' ,width: 16,color: Colors.white,),
                          )
                        ],
                      )
                  ),
                ),
              ],
            ),
            const SizedBox(height: 25,),
            Container(
              height: 5,
              width: 150,
              margin: const EdgeInsets.only(bottom: 16),
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(5),
              ),
            ),
          ],
        ),
      )
  );
}

void showSuccessBottomSheet({
  required VoidCallback onConfirm,
  String? message
}) {
  Get.bottomSheet(
      Container(
        width: double.infinity,
        padding: const EdgeInsets.only(top: 20,left: 20,right: 20),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(25)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(height: 20,),
            Image.asset("icons/success.png",height: 40,color: successActionColor,),
            const SizedBox(height: 10,),
            const Text("تم تنفيذ العملية بنجاح",
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: successActionColor
              ),),
            Text((message)??"شكراً لك! تم تحديث بياناتك بنجاح.",
                style: TextStyle(
                    fontSize: 16,
                    color: Colors.grey
                )
            ),
            const SizedBox(height: 25,),
            Container(
              height: 5,
              width: 150,
              margin: const EdgeInsets.only(bottom: 16),
              decoration: BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.circular(5),
              ),
            ),
          ],
        ),
      )
  );
}
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:logix_market_place/common/storage/local_storage.dart';
import '../../common/nav/app_bar_custom.dart';
import '../../common/theme/colors.dart';
import '../../controllers/account_info_controller.dart';

class ChangePasswordScreen   extends StatelessWidget{
  ChangePasswordScreen({super.key});
  final box = GetStorage();
  final AccountInfoController infoController = Get.put(AccountInfoController());
  @override
  Widget build(BuildContext context) {
    final formKey= GlobalKey<FormState>();
    return Scaffold(
      appBar: AppBarCustom(title: "home"),
      body: Form(
        key: formKey,
        child: SingleChildScrollView(
          child: Padding(
              padding: EdgeInsets.all(16.w),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 10.h),
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 12.0,vertical: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Text("تغيير كلمة المرور", style: TextStyle(fontSize: 20, fontWeight: FontWeight.w900))
                        ],
                      ),
                    ),
                    const Padding(
                        padding:  EdgeInsets.symmetric(horizontal: 12.0,vertical: 4),
                        child: Text("كلمة المرور الحالية",style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold),)
                    ),
                    Obx(()=>
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 12.0,vertical: 4),
                        child: TextFormField(
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter a current password';
                            }
                            if (box.read(pwdIndex)!=infoController.currentPwdController.text) {
                              return 'Current password is not correct.';
                            }
                            return null;
                          },
                          controller: infoController.currentPwdController,
                          decoration: InputDecoration(
                              suffixIcon:
                              IconButton(
                                icon: Icon((infoController.isCurrentPwdHidden.value)? Icons.visibility_off : Icons.visibility),
                                onPressed: () {
                                  infoController.isCurrentPwdHidden.value = !infoController.isCurrentPwdHidden.value;
                                },
                              ),
                              hintText: 'ادخل كلمة المرور الحالية..',
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15),
                                  borderSide: BorderSide(color: grayBorderColor1.withOpacity(0.1), width: 0.2)
                              )
                          ),
                          obscureText: infoController.isCurrentPwdHidden.value,
                        ),
                      ),
                    ),
                    const Padding(
                        padding:  EdgeInsets.symmetric(horizontal: 12.0,vertical: 4),
                        child: Text("كلمة المرور الجديدة",style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold),)
                    ),
                    Obx(()=>
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 12.0,vertical: 4),
                        child: TextFormField(
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter a new password';
                            }
                            final regex = RegExp(r'^(?=.*[a-zA-Z])(?=.*[^a-zA-Z0-9])(?=.*[a-zA-Z0-9])[a-zA-Z0-9!@#$%^&*]{8,}$');
                            if (!regex.hasMatch(value)) {
                              return 'Password must be at least 8 chars, include letters, numbers, and a symbol';
                            }
                            return null;
                          },
                          controller: infoController.newPwdController,
                          decoration: InputDecoration(
                              suffixIcon:
                              IconButton(
                                icon: Icon((infoController.isNewPwdHidden.value)? Icons.visibility_off : Icons.visibility),
                                onPressed: () {
                                  infoController.isNewPwdHidden.value = !infoController.isNewPwdHidden.value;
                                },
                              ),
                              hintText: 'ادخل كلمة المرور الجديدة..',
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15),
                                  borderSide: BorderSide(color: grayBorderColor1.withOpacity(0.1), width: 0.2)
                              )
                          ),
                          obscureText: infoController.isNewPwdHidden.value,
                        ),
                      ),
                    ),
                    const Padding(
                        padding:  EdgeInsets.symmetric(horizontal: 12.0,vertical: 4),
                        child: Text("أعد كتابة كلمة المرور الجديدة",style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold),)
                    ),
                    Obx(()=>
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 12.0,vertical: 4),
                        child: TextFormField(
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter a new password confirm';
                            }

                            if (value!=infoController.newPwdController.text) {
                              return 'Password and its confirm not match.';
                            }
                            return null;
                          },
                          controller: infoController.newPwdConfirmController,
                          decoration: InputDecoration(
                              suffixIcon:
                              IconButton(
                                icon: Icon((infoController.isNewPwdConfirmHidden.value)? Icons.visibility_off : Icons.visibility),
                                onPressed: () {
                                  infoController.isNewPwdConfirmHidden.value = !infoController.isNewPwdConfirmHidden.value;
                                },
                              ),
                              hintText: 'أعد كتابة كلمة المرور الجديدة ..',
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15),
                                  borderSide: BorderSide(color: grayBorderColor1.withOpacity(0.1), width: 0.2)
                              )
                          ),
                          obscureText: infoController.isNewPwdConfirmHidden.value,
                        ),
                      ),
                    ),

                  ]
              )
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: SizedBox(
          height: 60,
          child: TextButton(
              style: ElevatedButton.styleFrom(
                  elevation: 0,
                  padding: const EdgeInsets.all(5),
                  backgroundColor: primaryColor,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)
                  )
              ),
              onPressed: () {
                if(formKey.currentState!.validate()){
                  infoController.changePwd();
                }
              },
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("تغيير كلمة المرور",style: TextStyle(color: Colors.white,fontWeight: FontWeight.w700,fontSize: 18))
                ],
              )
          ),
        ),
      ),
    );
  }
}
class CustomTextInput extends StatelessWidget {
  CustomTextInput(
      {Key? key,
        this.textEditingController,
        this.labelText = "",
        this.exText = "",
        this.maxLgh,
        this.maxLin = 1,
        this.minLin = 1,
        this.obscureTxt = false,
        this.onChangeText,
        this.icon1,
        this.icon2,
        this.isRequired = false,
        this.withMaxLgh = false,
        this.textInputAction = TextInputAction.next,
        this.keyboardType = TextInputType.text,
        this.validatorError,
        this.inetValue,
        this.filled = true,
        this.isEnabled = true,
        this.autovalidateModeAlways = false,
        this.paddingHorizontal=5, this.paddingVertical=8,this.withBolder=true, this.stringLgh, this.wedgetIcon1, this.text, this.styleText, this.fillColor, this.border, this.BorderSideColor, this.textAlign,  this.readOnly=false, this.inputFormatters})
      : super(key: key);

  final TextEditingController? textEditingController;
  final String labelText;
  final String exText;
  final int maxLin;
  final int minLin;
  final double paddingHorizontal;
  final String? inetValue;
  final String? text;
  final int? maxLgh;
  final TextStyle? styleText;
  final int? stringLgh;
  final double paddingVertical;
  final bool obscureTxt,readOnly, isEnabled,withMaxLgh, filled,withBolder;
  bool isRequired;
  bool autovalidateModeAlways;
  final IconData? icon1;
  final Widget? icon2;
  final Color? fillColor;
  final Color? BorderSideColor;
  final String? wedgetIcon1;
  final double? border;
  final List<TextInputFormatter>? inputFormatters;
  final TextAlign? textAlign;
  final ValueChanged<String>? onChangeText;
  final TextInputAction textInputAction;
  final TextInputType keyboardType;
  final FormFieldValidator<String>? validatorError;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical:paddingVertical,horizontal: paddingHorizontal),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          text==null?SizedBox(): Padding(
            padding: const EdgeInsets.symmetric(vertical:2.0),
            child: Text(text.toString(),style: styleText??Theme.of(context).textTheme.displayMedium?.copyWith(color: blackLightColor),),
          ),

          TextFormField(

            inputFormatters: inputFormatters,

            textAlign:textAlign??(icon1!=null? TextAlign.center:TextAlign.start),
            cursorColor:context.theme.primaryColor ,
            initialValue: inetValue,

            decoration: InputDecoration(

              labelStyle:Theme.of(context).textTheme.displayMedium?.copyWith(color: Colors.grey.withOpacity(.5)) ,
              hintStyle:Theme.of(context).textTheme.displayMedium?.copyWith(color: Colors.grey.withOpacity(.5)) ,
              fillColor:fillColor??blackLightColor,
              filled: filled,

              isCollapsed: false,

              hintText:withBolder?exText.isNotEmpty?"${""}\t$exText":"":labelText.tr,
              suffixText: '   ',
              contentPadding:isEnabled? EdgeInsets.all(6):EdgeInsets.all(8),
              prefixIconColor:Get.theme.primaryColor ,
              suffixIconColor: Get.theme.indicatorColor,
              prefixIcon: wedgetIcon1!=null?Card(
                margin: EdgeInsets.all(0),elevation: 0,
                color:blackLightColor.withOpacity(.2),

                child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Image.asset(

                    wedgetIcon1.toString(),
                    color:context.theme.iconTheme.color ,
                    width: 30,
                    height: 30,
                  ),
                ),
              ): icon1 != null
                  ? Icon(icon1,
                color:context.theme.iconTheme.color ,
              ) : null,
              suffixIcon: icon2,

              focusedErrorBorder:OutlineInputBorder(
                borderRadius: BorderRadius.circular(border??4),
                borderSide: BorderSide(color:context.theme.colorScheme.error, width: 0.5),
              ) ,
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(border??4),
                borderSide: BorderSide(width:1.5,color:BorderSideColor??blackLightColor),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(border??4),
                borderSide:  BorderSide( color:BorderSideColor??blackLightColor, width: 1),
              ),
              border:OutlineInputBorder(
                borderRadius: BorderRadius.circular(border??4),
                borderSide:  BorderSide( color:BorderSideColor??blackLightColor, width: 1),
              ) ,
              errorBorder:  OutlineInputBorder(
                borderRadius: BorderRadius.circular(border??4),
                borderSide:  BorderSide( color:redColor, width: 1),
              ) ,

              disabledBorder:OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide(color: blackLightColor, width: 1),
              ) ,
            ),
            onChanged: onChangeText,
            style: Theme.of(context).textTheme.displayMedium?.copyWith(color: blackLightColor),
            textInputAction: textInputAction,
            keyboardType: keyboardType,
            obscureText: obscureTxt,
            enabled: isEnabled,
            readOnly: readOnly,

            controller: textEditingController,
            maxLines: maxLin,
            minLines: minLin,
            maxLength:maxLgh,


            autovalidateMode: autovalidateModeAlways ? AutovalidateMode.always : AutovalidateMode.onUserInteraction,
            validator:(x) {
              if(isRequired&& x!.trim().isEmpty) {
                return '${labelText.tr} ${"مطلوب"}';
              } else if(withMaxLgh&& x!.length>stringLgh!) {
                return "لقد تجاوزت القبمةالمدخلة اكثر من 50 حرفا";
              }else if( validatorError != null){
                return validatorError!(x);
              }
              return null;
            },
          ),
        ],
      ),
    );
  }
}
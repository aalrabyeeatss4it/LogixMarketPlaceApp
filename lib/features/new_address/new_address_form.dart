import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../common/theme/colors.dart';
import '../../common/widgets/section_title_card.dart';

class NewAddressForm extends StatefulWidget {
  const NewAddressForm({super.key});

  @override
  State<StatefulWidget> createState() => _NewAddressFormState();
}

class _NewAddressFormState extends State<NewAddressForm> {
  bool isDefaultAddress = false;

  @override
  Widget build(BuildContext context) {
    return Column(
        children: [
          SizedBox(height: 16.h),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12.0,vertical: 4),
            child: SizedBox(
              height: 65.h,
              child: TextFormField(
                decoration: InputDecoration(
                    hintText: 'street'.tr,
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: const BorderSide(color: grayBorderColor1,width: 0.2)
                    )
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12.0,vertical: 4),
            child: SizedBox(
              height: 65.h,
              child: TextFormField(
                decoration: InputDecoration(
                    hintText: 'building no'.tr,
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: const BorderSide(color: grayBorderColor1,width: 0.2)
                    )
                ),
              ),
            ),
          ),
          Row(
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12.0,vertical: 4),
                  child: SizedBox(
                    height: 65.h,
                    child: TextFormField(
                      decoration: InputDecoration(
                          hintText: 'floor'.tr,
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                              borderSide: const BorderSide(color: grayBorderColor1,width: 0.2)
                          )
                      ),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12.0,vertical: 4),
                  child: SizedBox(
                    height: 65.h,
                    child: TextFormField(
                      decoration: InputDecoration(
                          hintText: 'nearest place'.tr,
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                              borderSide: const BorderSide(color: grayBorderColor1,width: 0.2)
                          )
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12.0,vertical: 4),
            child: SizedBox(
              height: 65.h,
              child: TextFormField(
                decoration: InputDecoration(
                    hintText: 'city/region'.tr,
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: const BorderSide(color: grayBorderColor1,width: 0.2)
                    )
                ),
              ),
            ),
          ),
          Row(
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12.0,vertical: 4),
                  child: SizedBox(
                    height: 65.h,
                    child: TextFormField(
                      decoration: InputDecoration(
                          hintText: 'neighborhood'.tr,
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                              borderSide: const BorderSide(color: grayBorderColor1,width: 0.2)
                          )
                      ),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12.0,vertical: 4),
                  child: SizedBox(
                    height: 65.h,
                    child: TextFormField(
                      decoration: InputDecoration(
                          hintText: 'governance'.tr,
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                              borderSide: const BorderSide(color: grayBorderColor1,width: 0.2)
                          )
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),

          SizedBox(height: 16.h),
          SectionTitleCard(title: 'personal info'.tr,fontSize: 16,),
          SizedBox(height: 5.h),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12.0,vertical: 4),
            child: SizedBox(
              height: 65.h,
              child: TextFormField(
                decoration: InputDecoration(
                    hintText: 'full-name'.tr,
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: const BorderSide(color: grayBorderColor1,width: 0.2)
                    )
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12.0,vertical: 4),
            child: SizedBox(
              height: 65.h,
              child: TextFormField(
                decoration: InputDecoration(
                    hintText: '+966XXXXXX',
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: const BorderSide(color: grayBorderColor1,width: 0.2)
                    )
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8),
            child: Row(
              children: [
                Checkbox(
                  value: isDefaultAddress,
                  onChanged: (value) {
                    // setState(() {
                    //   isDefaultAddress = value ?? false;
                    // });
                  },
                ),
                Text('use as main address'.tr),
              ],
            ),
          ),

        ]
    );
  }
}

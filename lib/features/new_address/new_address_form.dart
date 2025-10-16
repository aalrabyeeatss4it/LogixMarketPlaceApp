import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../common/theme/colors.dart';
import '../../common/widgets/section_title_card.dart';

class NewAddressForm extends StatefulWidget {
  const NewAddressForm({super.key});

  @override
  _NewAddressFormState createState() => _NewAddressFormState();
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
                    hintText: 'اسم الشارع..',
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: const BorderSide(color: grayBorderColor1,width: 0.2)
                    )
                ),
              ),
            ),
          ),Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12.0,vertical: 4),
            child: SizedBox(
              height: 65.h,
              child: TextFormField(
                decoration: InputDecoration(
                    hintText: 'اسم / رقم المبنى..',
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
                          hintText: 'رقم الطابق / الشقة / الفيلا..',
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
                          hintText: 'أقرب معلم..',
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
          ),Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12.0,vertical: 4),
            child: SizedBox(
              height: 65.h,
              child: TextFormField(
                decoration: InputDecoration(
                    hintText: 'المدينة / المنطقة..',
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: const BorderSide(color: grayBorderColor1,width: 0.2)
                    )
                ),
              ),
            ),
          ),Row(
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12.0,vertical: 4),
                  child: SizedBox(
                    height: 65.h,
                    child: TextFormField(
                      decoration: InputDecoration(
                          hintText: 'الحي..',
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                              borderSide: const BorderSide(color: grayBorderColor1,width: 0.2)
                          )
                      ),
                    ),
                  ),
                ),
              ),Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12.0,vertical: 4),
                  child: SizedBox(
                    height: 65.h,
                    child: TextFormField(
                      decoration: InputDecoration(
                          hintText: 'المحافظة..',
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
          SectionTitleCard(title: "بيانات شخصية",fontSize: 16,),
          SizedBox(height: 5.h),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12.0,vertical: 4),
            child: SizedBox(
              height: 65.h,
              child: TextFormField(
                decoration: InputDecoration(
                    hintText: 'الاسم كامل..',
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
                const Text("الاستخدام كعناوني الرئيسي."),
              ],
            ),
          ),

        ]
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:logix_market_place/common/widgets/section_title_card.dart';
import '../../common/theme/colors.dart';
import '../../controllers/delivery_address_controller.dart';
import '../map_picker/map_picker_screen.dart';


class NewAddressScreen extends StatefulWidget{
  const NewAddressScreen({super.key});

  @override
  State<StatefulWidget> createState() => _NewAddressScreenState();

}
class _NewAddressScreenState extends State<NewAddressScreen> {
  final DeliveryAddressController controller = Get.put(DeliveryAddressController(), permanent: false);

  @override
  void initState() {
    super.initState();
    controller.clear();
  }

  @override
  Widget build(BuildContext context) {
    final formKey= GlobalKey<FormState>();
    return Scaffold(
      appBar: AppBar(title: Text('add new address'.tr)),
      body: Form(
        key: formKey,
        child:
          SingleChildScrollView(
              child: Obx(() {
                var address = controller.address.value;
                return Column(
                  children: [
                    SizedBox(height: 16.h),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12.0,vertical: 4),
                      child: OutlinedButton.icon(
                        icon: const Icon(Icons.location_on),
                        label: Text(
                          address.shortAddress ?? 'choose location on map'.tr,
                        ),
                        onPressed: () async {
                          final result = await Get.to(() => const MapPickerScreen(),
                          );
                          if (result != null) {
                            print("controller.address.value");
                            controller.address.value = result;
                          }
                        },
                      ),
                    ),
                    // _field('address label'.tr, controller.labelCtrl, (v) => address.label = v),
                    SizedBox(height: 16.h),
                    SectionTitleCard(title: 'delivery address'.tr, fontSize: 18,),
                    SizedBox(height: 16.h),
                    _field('region'.tr, controller.regionCtrl, (v) => controller.address.value.regionName = v),
                    _field('city'.tr, controller.cityCtrl, (v) => address.cityName = v),
                    _field('neighborhood'.tr, controller.districtCtrl, (v) => address.districtName = v),
                    _field('street'.tr, controller.streetCtrl, (v) => address.streetName = v),
                    _field('zip code'.tr, controller.zipCtrl, (v) => address.zipCode = v),
                    _field('floor'.tr, controller.buildingNoCtrl, (v) => address.buildingNo = v),
                    _field('nearest place'.tr, controller.closestPlaceController, (v) => address.closestPlace = v),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      child: SectionTitleCard(title: 'personal info'.tr, fontSize: 16,),
                    ),
                    _field('full-name'.tr, controller.recipientNameController, (v) => address.recipientName = v),
                    _field('mobile no'.tr, controller.mobileNoController, (v) => address.mobileNo = v),
                    Obx(() =>
                        InkWell(
                          onTap: (){
                            controller.isDefaultAddress.value = !controller.isDefaultAddress.value;
                          },
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 12.0, vertical: 8),
                            child: Row(
                              children: [
                                Checkbox(
                                  value: controller.isDefaultAddress.value,
                                  onChanged: (value) {
                                    controller.isDefaultAddress.value = value ?? false;
                                  },
                                ),
                                Text('use as main address'.tr),
                              ]
                            )
                          ),
                        )
                    )
                  ]
                  );
              }
              )
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(20),
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
                  controller.addAddress();
                }
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('save'.tr,style: const TextStyle(color: Colors.white,fontWeight: FontWeight.w700,fontSize: 18))
                ],
              )
          ),
        ),
      ),
    );
  }
  Widget _field(String label, TextEditingController controller, Function(String) onChanged , {TextInputType keyboard = TextInputType.text}){
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12.0,vertical: 4),
      child: SizedBox(
        height: 65.h,
        child: TextFormField(
          controller: controller,
          keyboardType: keyboard,
          decoration: InputDecoration(
              hintText: label,
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                  borderSide: const BorderSide(color: grayBorderColor1,width: 0.2)
              )
          ),
          onChanged: onChanged,
        ),
      ),
    );
  }
}
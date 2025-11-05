import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:logix_market_place/features/product_detail/attribute_card.dart';

import '../../common/nav/app_bar_custom.dart';
import '../../common/nav/bottom_nav_bar_custom.dart';
import '../../common/theme/colors.dart';
import '../../controllers/cart_controller.dart';
import '../../controllers/product_detail_controller.dart';
import '../../models/cart_item_model.dart';
import '../home/home_product_card.dart';

class ProductDetailScreen extends StatefulWidget {
  const ProductDetailScreen({super.key});

  @override
  State<StatefulWidget> createState() => ProductDetailScreenState();
}
class ProductDetailScreenState extends State<ProductDetailScreen>{
  late final int productId ;
  final ProductDetailController _productController = Get.put(ProductDetailController());
  final CartController cartController = Get.find<CartController>();

  @override
  void initState() {
    super.initState();
    final args = Get.arguments as Map<String,dynamic>;
    productId = args['productId'];
    _productController.getProduct(productId);
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarCustom(title: "home"),
      body:
      Obx(() {
        if (_productController.loading.value) {
          return const Center(child: CircularProgressIndicator());
        }
        return SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.all(16.w),
                child: Wrap(
                    children: [
                      const SizedBox(height: 10),
                      Text(_productController.product.value.name,
                          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w900),
                          softWrap: true,
                          overflow: TextOverflow.visible,
                          maxLines: null
                      ),
                      Text(_productController.product.value.desc,
                          style: const TextStyle(fontSize: 14),
                          softWrap: true,
                          overflow: TextOverflow.visible,
                          maxLines: null
                      )
                    ]
                ),
              ),
              Card(
                elevation: 0,
                shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.zero)),
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                  child: Column(
                      children:
                      [
                        Center(
                            child:
                            SizedBox( width: 120, height: 120,
                                child: Image.network(
                                  _productController.product.value.getThumbPath(),
                                  fit: BoxFit.cover,
                                  loadingBuilder: (context, child, loadingProgress) {
                                    if (loadingProgress == null) return child; // image loaded
                                    return Center(
                                      child: CircularProgressIndicator(
                                        value: loadingProgress.expectedTotalBytes != null
                                            ? loadingProgress.cumulativeBytesLoaded / (loadingProgress.expectedTotalBytes ?? 1)
                                            : null,
                                      ),
                                    );
                                  },
                                  errorBuilder: (context, error, stackTrace) {
                                    // return default image if network image fails
                                    return Image.asset(
                                      'assets/logo.png',
                                      fit: BoxFit.cover,
                                    );
                                  },
                                )
                            )
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Expanded(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Image.asset('icons/dots.png', height: 10),
                                  ],
                                ),
                              ),
                              Row(
                                children: [
                                  Image.asset('icons/fav-black.png', height: 25),
                                  SizedBox(width: 5),
                                  Image.asset('icons/share.png', height: 25),
                                ],
                              ),

                            ]
                        )
                      ]
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(16.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(_productController.product.value.getDiscountRate(), style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700,color: secondaryColor)),
                        Text(_productController.product.value.priceIncludeVat.toStringAsFixed(2), style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700, color:  primaryColor)),
                        Image.asset('icons/riyal.png' ,width: 12,),
                      ]
                    ),
                    Text(_productController.product.value.getPreDiscountPrice(), style: TextStyle(fontSize: 16,color: Colors.grey, decoration: TextDecoration.lineThrough,)),
                    const Text('متوفر', style: TextStyle(fontSize: 16,fontWeight: FontWeight.w700,color: successColor)),
                    const Divider(),
                    const Text('تفاصيل المنتج', style: TextStyle(fontSize: 18,fontWeight: FontWeight.w900)),
                    (_productController.product.value.attributes!=null)?const Column(
                      children: [
                        Divider(),
                        SizedBox(height: 20,),
                        Text('المواصفات:', style: TextStyle(fontSize: 16,fontWeight: FontWeight.w700)),
                      ],
                    ):SizedBox(),
                    (_productController.product.value.attributes!=null)?
                    ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: _productController.product.value.attributes!.length,
                        itemBuilder: (BuildContext context, int index) {
                          return AttributeCard(attribute: _productController.product.value.attributes![index]);
                        }):const SizedBox(),
                    (_productController.product.value.attributes!=null)?Column(
                      children: [
                        const Divider(),
                        const Text('المنتجات المرتبطة', style: TextStyle(fontSize: 18,fontWeight: FontWeight.w900)),
                      ],
                    ):const SizedBox(),

                  ]
                ),
              ),
              Padding(
                padding: EdgeInsets.all(16.w),
                child: Obx(() {
                  if(_productController.relatedProducts.isEmpty){
                    // return const Center(child: CircularProgressIndicator());
                    return const Center(child: SizedBox());
                  }
                  return SizedBox(
                    height: 350,
                    child: ListView.builder(
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        itemCount: _productController.relatedProducts.length,
                        itemBuilder: (BuildContext context, int index) {
                          return HomeProductCard(product: _productController.relatedProducts[index]);
                        }),
                  );
                }
                ),
              ),
            ],
          ),
        );
      }),
      bottomNavigationBar: BottomNavBarCustom(
          currentPage: 0,
          actionRow: SizedBox(
            child: Container(
              color: Colors.white,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  SizedBox(
                    height: 55,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0,vertical: 3),
                      child: Obx(() {
                        bool added = cartController.inCart(_productController.product.value.id);
                        return !added?ElevatedButton(
                            onPressed: (){
                              if(!added){
                                CartItemModel item = CartItemModel(product: _productController.product.value);
                                cartController.addItem(item);
                              }
                            },
                          style: ElevatedButton.styleFrom(
                              backgroundColor: secondaryColor,
                              foregroundColor: Colors.white,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10)
                              )
                          ),
                          child: const Text('اشترِ الآن'),
                        ):const SizedBox();
                      }
                      )
                    ),
                  ),
                  Expanded(
                    child: SizedBox(
                      height: 55,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0,vertical: 3),
                        // child: Obx(() {
                        //     return ElevatedButton(
                        //         onPressed: (){
                        //           if(!added){
                        //             CartItemModel item = CartItemModel(product: product);
                        //             cartController.addItem(item);
                        //           }
                        //         },
                        //         style: ElevatedButton.styleFrom(
                        //             backgroundColor:  primaryColor,
                        //             foregroundColor: Colors.white,
                        //             shape: RoundedRectangleBorder(
                        //                 borderRadius: BorderRadius.circular(10)
                        //             )
                        //         ),
                        //         child: Text('add to cart'.tr)
                        //     );
                        //   }
                        //   )
                        child: Obx(() {
                          bool added = cartController.inCart(_productController.product.value.id);
                          CartItemModel? item = cartController.getItem(_productController.product.value.id);
                          if(added){
                            WidgetsBinding.instance.addPostFrameCallback((_) {
                              _productController.setQty(cartController.getQty(_productController.product.value.id));
                            });
                            return Padding(
                              padding: const EdgeInsets.all(4.0),
                              child: Container(
                                width: 210.w,
                                height: 40,
                                decoration: BoxDecoration(
                                    border: Border.all(width: 1.5,color: secondaryColor),
                                    borderRadius: BorderRadius.circular(20)
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    InkWell(
                                      onTap: (){
                                        cartController.decrementQuantity(item);
                                      },
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                                        child: Image.asset((item!.quantity.value<=1)?'icons/trash.png':'icons/minus.png', width: 20,),
                                      ),
                                    ),
                                    Obx(() => Text(item.quantity.value.toString())),
                                    InkWell(
                                      onTap: (){
                                        cartController.incrementQuantity(item);
                                      },
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                                        child: Image.asset('icons/plus.png', width: 20,),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            );
                          }
                          return ElevatedButton(
                              onPressed: (){
                                if(!added){
                                  CartItemModel item = CartItemModel(product: _productController.product.value);
                                  item.quantity.value = _productController.quantity.value;
                                  cartController.addItem(item);
                                }
                              },
                              style: ElevatedButton.styleFrom(
                                    backgroundColor:  primaryColor,
                                    foregroundColor: Colors.white,
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(10)
                                    )
                                ),
                                child: Text('add to cart'.tr)
                          );
                        }
                        ),
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: (){
                      showModalBottomSheet(
                        context: context,
                        backgroundColor: Colors.white,
                        shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(16))) ,
                        builder: (context) {
                          return SizedBox(
                            height: 100,
                            child: Padding(
                              padding: const EdgeInsets.all(12),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                children: List.generate(6, (index)
                                {
                                  final qty = index + 1;
                                  return GestureDetector(
                                      onTap: () {
                                        _productController.setQty(qty);
                                        Navigator.pop(context);
                                        },
                                      child: Container(
                                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(8),
                                          border: Border.all(color: Colors.grey.shade400),
                                          color: Colors.grey.shade100,
                                        ),
                                        child: Text(qty.toString(),style: const TextStyle(fontWeight: FontWeight.bold,fontSize: 16),)
                                      )
                                  );
                                }
                                )
                              )
                            )
                          );
                        }
                          );
                      },
                    child: Container(
                      height: 48,
                      width: 55,
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey, width: 0.2),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Column(children: [
                        Text('QTY',style: const TextStyle(color: Colors.grey)),
                        Obx(()=> Text(_productController.quantity.value.toString(),style: TextStyle(fontWeight: FontWeight.w900,fontSize: 16)))
                      ]
                      )
                    ),
                  )
                ]
              )
            ),
          )
      )
    );
  }
}
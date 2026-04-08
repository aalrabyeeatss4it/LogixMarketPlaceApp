import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:logix_market_place/common/dialogs/bottom_sheets.dart';
import 'package:logix_market_place/features/product_detail/attribute_card.dart';
import 'package:logix_market_place/features/product_detail/product_file_slider.dart';

import '../../common/nav/app_bar_custom.dart';
import '../../common/nav/bottom_nav_bar_custom.dart';
import '../../common/storage/local_storage.dart';
import '../../common/theme/colors.dart';
import '../../controllers/cart_controller.dart';
import '../../controllers/fav_controller.dart';
import '../../controllers/opportunity_controller.dart';
import '../../controllers/product_detail_controller.dart';
import '../../controllers/token_controller.dart';
import '../../models/cart_item_model.dart';
import '../../models/product_offer.dart';
import '../home/home_product_card.dart';

class ProductDetailScreen extends StatefulWidget {
  const ProductDetailScreen({super.key});

  @override
  State<StatefulWidget> createState() => ProductDetailScreenState();
}

class ProductDetailScreenState extends State<ProductDetailScreen> {
  late final int productId;
  final ProductDetailController _productController = Get.put(ProductDetailController());
  final FavController favController = Get.find<FavController>();
  final OpportunityController opportunityController = Get.put(OpportunityController());
  final CartController cartController = Get.find<CartController>();

  final TokenController tokenController = Get.put(TokenController());
  @override
  void initState() {
    super.initState();
    final args = Get.arguments as Map<String, dynamic>;
    productId = args['productId'];
    tokenController.getToken();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await _loadProduct();
      if(_productController.product.value.files != null){
        for (var file in _productController.product.value.files!) {
          final url = file.getFilePath(tokenController.ssoToken.value);
          precacheImage(
            CachedNetworkImageProvider(
              url,
              cacheKey: file.id.toString(),
            ),
            context,
          );
        }
      }
    });
  }

  Future<void> _loadProduct() async {
    await _productController.getProduct(productId);
    CartItemModel? item = cartController.getItem(productId);
    if (item != null) {
      _productController.updateProduct(item.quantity.value, item.product);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      bool added = cartController.inCart(productId);
      CartItemModel? item = cartController.getItem(productId);
      return Scaffold(
          appBar: AppBarCustom(title: "home"),
          body: Obx(() {
            if (_productController.loading.value) {
              return const Center(child: CircularProgressIndicator());
            }
            if(_productController.product.value.id == 0){
              return const Center(child: Text("No Data"),);
            }
            return SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.all(16.w),
                    child: Text(_productController.product.value.getName,
                        style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w900),
                        softWrap: true,
                        overflow: TextOverflow.visible,
                        maxLines: null
                    ),
                  ),
                  Card(
                    elevation: 0,
                    shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.zero)),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 2.0),
                      child: Column(children: [
                        (_productController.product.value.files != null && _productController.product.value.files!.isNotEmpty)?
                        ProductFileSlider(files: _productController.product.value.files):
                        Center(
                            child: SizedBox(
                                width: 180,
                                height: 180,
                                child: (_productController.product.value.thumbPath == "no_image.jpg")? Image.asset('assets/logo.png',fit: BoxFit.cover):
                                Image.network(
                                  _productController.product.value.getThumbPath(),
                                  fit: BoxFit.fill,
                                  loadingBuilder: (context, child, loadingProgress) {
                                    if (loadingProgress == null) return child; // image loaded
                                    return Center(
                                      child: CircularProgressIndicator(
                                        value: loadingProgress.expectedTotalBytes != null?
                                        loadingProgress.cumulativeBytesLoaded / (loadingProgress.expectedTotalBytes ?? 1) : null,
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
                                ))
                        ),
                        // Row(
                        //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        //     children: [
                        //       const Expanded(child: SizedBox()),
                        //       Row(
                        //         children: [
                        //           Obx((){
                        //             bool favAdded = favController.inFav(_productController.product.value.id);
                        //             return InkWell(
                        //                 onTap: (){
                        //                   if(favAdded){
                        //                     favController.removeById(_productController.product.value.id);
                        //                   }
                        //                   else{
                        //                     favController.addItem(_productController.product.value);
                        //                   }
                        //                 },
                        //                 child: Image.asset(favAdded? 'icons/fav-checked.png' : 'icons/fav.png', width: 25,color: Colors.black,)
                        //             );
                        //           }
                        //           ),
                        //           const SizedBox(width: 5),
                        //           InkWell(
                        //               onTap: () async {
                        //                 await _productController.shareProductLink();
                        //               },
                        //               child: Image.asset('icons/share.png', height: 25)
                        //           ),
                        //         ],
                        //       ),
                        // ]),

                      ]),
                    ),
                  ),

                  InkWell(
                    onTap: () async {
                      await Clipboard.setData(
                        ClipboardData(text: _productController.product.value.getProductCode()),
                      );
                      showCopyToast();
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Card(
                        elevation: 0,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8,),
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    Text('product code'.tr,
                                        style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w900, color: grayBorderColor3),
                                        softWrap: true,
                                        overflow: TextOverflow.visible,
                                        maxLines: null),
                                    const SizedBox(width: 10,),
                                    Text(_productController.product.value.getProductCode(),
                                        style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w900, color: grayBorderColor3),
                                        softWrap: true,
                                        overflow: TextOverflow.visible,
                                        maxLines: null),
                                  ],
                                ),
                                IconButton(
                                    onPressed: () async {
                                      await Clipboard.setData(
                                        ClipboardData(text: _productController.product.value.getProductCode()),
                                      );
                                      showCopyToast();
                                    },
                                    icon: Image.asset("icons/copy.png", width: 25,))
                              ]
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(16.w),
                    child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                      Row(mainAxisSize: MainAxisSize.min, mainAxisAlignment: MainAxisAlignment.start, children: [
                        Text(_productController.product.value.getDiscountRate(),
                            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w700, color: secondaryColor)),
                        Text(_productController.product.value.getPriceIncludeVat,
                            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w700, color: primaryColor)),
                        (_productController.product.value.getPriceIncludeVat!="")?Image.asset('icons/riyal.png' ,width: 12,): const SizedBox(),
                      ]),
                      Text(_productController.product.value.getPreDiscountPrice(),
                          style: const TextStyle(fontSize: 16,color: Colors.grey,decoration: TextDecoration.lineThrough)),
                      (_productController.product.value.isAvailable(_productController.quantity.value)==1)?
                       Text('available'.tr, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w700, color: successColor)):
                      (_productController.product.value.isAvailable(_productController.quantity.value)==-1)?
                       Text('in available'.tr, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w700, color: unAvailableColor)):
                      Text('${'available quantity'.tr}${_productController.product.value.inventoryBalance}', style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w700, color: unAvailableColor)),
                      if(_productController.product.value.offers.isNotEmpty)
                      Column(
                        children: [
                          const SizedBox(height: 10,),
                          Row(
                            children: [
                              Image.asset("icons/offers.png", width: 25,),
                              const SizedBox(width: 10,),
                              Text('buy more get more'.tr, style: const TextStyle(fontWeight: FontWeight.w900, fontSize: 18), )
                            ],
                          ),
                          ListView.builder(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: _productController.displayOffers.length,
                              itemBuilder: (BuildContext context, int index) {
                                final offer = _productController.displayOffers[index];
                                final isCheapestOffer = index != 0 && _productController.product.value.isCheapestOffer(index - 1);
                                final isSelectedOffer = _productController.selectedOfferId.value == offer.id;
                                return offerCard(added, offer, isCheapestOffer, item, isSelectedOffer);
                              })
                        ],
                      ),
                      const Divider(),
                      Text('product details'.tr, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w900)),
                      Text(_productController.product.value.desc, style: const TextStyle(fontSize: 18)),

                      (_productController.product.value.attributes != null)
                          ? Column(
                              children: [
                                const Divider(),
                                const SizedBox(
                                  height: 20,
                                ),
                                Text('specifications'.tr, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w700)),
                              ],
                            )
                          : const SizedBox(),
                      (_productController.product.value.attributes != null)
                          ? ListView.builder(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: _productController.product.value.attributes!.length,
                              itemBuilder: (BuildContext context, int index) {
                                return AttributeCard(attribute: _productController.product.value.attributes![index]);
                              })
                          : const SizedBox(),
                      (_productController.relatedProducts.isNotEmpty)?
                      Column(
                              children: [
                                const Divider(),
                                Text('related products'.tr, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w900)),
                              ],
                            )
                          : const SizedBox(),
                    ]),
                  ),
                  Padding(
                    padding: EdgeInsets.all(16.w),
                    child: Obx(() {
                      if (_productController.relatedProducts.isEmpty) {
                        return const Center(child: SizedBox());
                      }
                      return SizedBox(
                        height: 370,
                        child: ListView.builder(
                            shrinkWrap: true,
                            scrollDirection: Axis.horizontal,
                            itemCount: _productController.relatedProducts.length,
                            itemBuilder: (BuildContext context, int index) {
                              return HomeProductCard(product: _productController.relatedProducts[index]);
                            }),
                      );
                    }),
                  ),
                ],
              ),
            );
          }),
          bottomNavigationBar:  BottomNavBarCustom(
              currentPage: 0,
              actionRow:  Obx(() {
                if(_productController.product.value.id == 0 || !isLoggedIn()){
                  return const SizedBox();
                }
                if(_productController.product.value.isAvailable(1) == -1){
                  return SizedBox(
                      child: Container(
                        color: Colors.white,
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: InkWell(
                              onTap: (){
                                showActionConfirmBottomSheet(title: 'order confirm msg'.tr, buttonLabel: 'send'.tr, onConfirm: () {
                                  opportunityController.requestToProvide(_productController.product.value);
                                });

                              },
                              child: Container(
                                padding: const EdgeInsets.symmetric(vertical: 12,horizontal: 30),
                                decoration: const BoxDecoration(
                                    color: secondaryColor,
                                    borderRadius: BorderRadius.all(Radius.circular(20))
                                ),
                                child: Text('request to provide'.tr, style: const TextStyle(color: Colors.white),),
                              ),
                            ),
                          )
                        ]
                        )
                      )
                  );
                }
                return SizedBox(
                  child: Container(
                      color: Colors.white,
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
                        SizedBox(
                          height: 55,
                          child: Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 3),
                              child: Obx(() {
                                bool added = cartController.inCart(_productController.product.value.id);
                                return !added? ElevatedButton(
                                        onPressed: () {
                                          if (!added) {
                                            CartItemModel item = CartItemModel(product: _productController.product.value);
                                            cartController.addItem(item);
                                          }
                                        },
                                        style: ElevatedButton.styleFrom(
                                            backgroundColor: secondaryColor,
                                            foregroundColor: Colors.white,
                                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))),
                                        child: Text('buy now'.tr),
                                      )
                                    : const SizedBox();
                              })),
                        ),
                        Expanded(
                          child: SizedBox(
                            height: 55,
                            child: Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 3),
                              child: Obx(() {
                                bool added = cartController.inCart(_productController.product.value.id);
                                CartItemModel? item = cartController.getItem(_productController.product.value.id);
                                if (added) {
                                  WidgetsBinding.instance.addPostFrameCallback((_) {
                                    _productController.setQty(cartController.getQty(_productController.product.value.id));
                                  });
                                  return Padding(
                                    padding: const EdgeInsets.all(4.0),
                                    child: Container(
                                      width: 210.w,
                                      height: 40,
                                      decoration: BoxDecoration(
                                          border: Border.all(width: 1.5, color: secondaryColor), borderRadius: BorderRadius.circular(20)),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          InkWell(
                                            onTap: () async {
                                              await cartController.decrementQuantity(item);
                                              var qty = cartController.getQty(_productController.product.value.id);
                                              _productController.updateProduct(qty,item.product);
                                            },
                                            child: Padding(
                                              padding: const EdgeInsets.symmetric(horizontal: 8.0),
                                              child: Image.asset(
                                                (item!.quantity.value <= 1) ? 'icons/trash.png' : 'icons/minus.png',
                                                width: 20,
                                              ),
                                            ),
                                          ),
                                          Obx(() => Text(item.quantity.value.toString())),
                                          InkWell(
                                            onTap: () async {
                                              await cartController.incrementQuantity(item);
                                              _productController.updateProduct(cartController.getQty(_productController.product.value.id),item.product);
                                            },
                                            child: Padding(
                                              padding: const EdgeInsets.symmetric(horizontal: 8.0),
                                              child: Image.asset(
                                                'icons/plus.png',
                                                width: 20,
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  );
                                }
                                return ElevatedButton(
                                    onPressed: () async {
                                      if (!added) {
                                        CartItemModel item = CartItemModel(product: _productController.product.value);
                                        added = await cartController.addItem(item);
                                        if(added){
                                          if(_productController.quantity.value==0){
                                            _productController.quantity.value = 1;
                                          }
                                          await cartController.setQuantity(_productController.quantity.value,item);
                                          _productController.updateProduct(cartController.getQty(_productController.product.value.id),item.product);
                                        }
                                      }
                                    },
                                    style: ElevatedButton.styleFrom(
                                        backgroundColor: primaryColor,
                                        foregroundColor: Colors.white,
                                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))),
                                    child: Text('add to cart'.tr));
                              }),
                            ),
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            showModalBottomSheet(
                                context: context,
                                backgroundColor: Colors.white,
                                shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(16))),
                                builder: (context) {
                                  return SizedBox(
                                      height: 100,
                                      child: Padding(
                                          padding: const EdgeInsets.all(12),
                                          child: Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                                              children: List.generate(6, (index) {
                                                final qty = index + 1;
                                                return GestureDetector(
                                                    onTap: () async {
                                                      if (!added) {
                                                        _productController.setQty(qty);
                                                      }
                                                      else{
                                                        await cartController.setQuantity(qty,item!);
                                                        _productController.updateProduct(cartController.getQty(_productController.product.value.id),item.product);
                                                      }
                                                      Navigator.pop(context);
                                                    },
                                                    child: Container(
                                                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                                                        decoration: BoxDecoration(
                                                          borderRadius: BorderRadius.circular(8),
                                                          border: Border.all(color: Colors.grey.shade400),
                                                          color: Colors.grey.shade100,
                                                        ),
                                                        child: Text(
                                                          qty.toString(),
                                                          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                                                        )));
                                              })
                                          )
                                      )
                                  );
                                });
                          },
                          child: Container(
                              height: 48,
                              width: 55,
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.grey, width: 0.2),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Column(children: [
                                const Text('QTY', style: TextStyle(color: Colors.grey)),
                                Obx(() => Text(_productController.quantity.value.toString(),
                                    style: const TextStyle(fontWeight: FontWeight.w900, fontSize: 16)))
                              ]
                              )
                          )
                        )
                      ]
                      )
                  )
                );
              }
              )
          )
      );
    }
    );
  }
  Widget offerCard(bool added,ProductOffer offer, bool isCheapestOffer,CartItemModel? item, bool isSelectedOffer){
    return InkWell(
      onTap: () async {
        if (!added) {
          _productController.setQty(offer.qtyFrom);
        }
        else{
          await cartController.setQuantity(offer.qtyFrom,item!);
          _productController.updateProduct(cartController.getQty(_productController.product.value.id),item.product);
        }
      },
      child: Padding(
        padding: EdgeInsets.all(10),
        child: Stack(
          children: [
            Container(
              decoration: BoxDecoration(
                border: Border.all(color: isSelectedOffer ? Colors.green : Colors.grey, width: isSelectedOffer ? 2 : 1),
                borderRadius: BorderRadius.circular(15),
                color: isSelectedOffer ? Colors.green.withOpacity(0.1) : Colors.white,
              ),
              child: Padding(
                padding: const EdgeInsets.all(8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Row(
                      children: [
                        Radio(value: offer.id, groupValue: _productController.selectedOfferId.value, onChanged: (val) async {
                          if (!added) {
                            _productController.setQty(offer.qtyFrom);
                          }
                          else{
                            await cartController.setQuantity(offer.qtyFrom,item!);
                            _productController.updateProduct(cartController.getQty(_productController.product.value.id),item.product);
                          }
                        }),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text(offer.getOfferRange(), style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w900,),textDirection: TextDirection.ltr,),
                                const SizedBox(width: 5,),
                                Text('piece'.tr, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w900)),
                              ],
                            ),
                            (offer.id==0)?
                            Text('base price'.tr, style: const TextStyle(fontSize: 14, color: Colors.grey, fontWeight: FontWeight.bold)):
                            Text(offer.getOfferMessage(_productController.product.value.basePriceIncludeVat), style: const TextStyle(fontSize: 12, color: offerGreenColor, fontWeight: FontWeight.bold)),
                          ],
                        ),
                      ],
                    ),

                    Column(
                      children: [
                        Row(
                          children: [
                            Text(offer.getOfferPriceIncludeVat(), style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w900, color: primaryColor)),
                            const SizedBox(width: 5,),
                            Text(offer.getOfferPriceUnit(), style: const TextStyle(fontSize: 12)),
                          ],
                        ),
                      ],
                    ),

                  ],
                ),
              ),
            ),
            if (isCheapestOffer)
              Positioned(
                top: 0,
                left: 0,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                  decoration: const BoxDecoration(
                    color: cheapestColor,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(10),
                      bottomRight: Radius.circular(10),
                    ),
                  ),
                  child: const Text(
                    '🔥 الأكثر توفيرًا',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

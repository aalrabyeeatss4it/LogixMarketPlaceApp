import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/get_rx.dart';
import 'package:logix_market_place/models/product_image_model.dart';
import 'package:logix_market_place/models/product_offer.dart';

import '../common/api_paths.dart';

class ProductModel {
  int id;
  int categoryId;
  int unitId;
  String name;
  String? productCode;
  RxDouble basePrice = 0.0.obs;
  RxDouble offerPrice = 0.0.obs;
  RxDouble discountPercentage = 0.0.obs;
  RxInt inventoryBalance = 0.obs;
  double vat = 0;
  String desc;
  String thumbPath;
  List<Attribute>? attributes;
  List<ProductImageModel>? files;
  List<ProductOffer> offers;

  ProductModel(
      {
        required this.id,
        required this.categoryId,
        required this.unitId,
        required this.name,
        required this.desc,
        required this.thumbPath,
        required this.vat,
        required this.productCode,
        required double basePrice,
        required double offerPrice,
        required double discountPercentage,
        required int inventoryBalance,
        this.offers = const [],
        this.attributes,
        this.files
      })
  {
    this.inventoryBalance.value = inventoryBalance;
    this.basePrice.value = basePrice;
    this.offerPrice.value = offerPrice;
    this.discountPercentage.value = discountPercentage;
  }

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
        id: json['id'],
        categoryId: json['categoryId'],
        name: json['name'],
        desc: json['desc'],
        basePrice: json['price'],
        offerPrice: (json['offerPrice'] as num).toDouble(),
        vat: json['vaT_Rate']??0,
        unitId: json['unitId'],
        discountPercentage: json['discountPercentage'],
        inventoryBalance: json['inventoryBalance']??0,
        productCode: json['productCode']??"",
        thumbPath: json['thumbPath'],
        files: ProductImageModel.fromJsonList(json['files']),
        offers: (json['offers']!=null)?ProductOffer.fromJsonList(json['offers']):[]
    );
  }

  static List<ProductModel> fromJsonList(List<dynamic> jsonList) {
    try{
      return jsonList.map((item) => ProductModel.fromJson(item)).toList();
    }
    catch(e){
      if (kDebugMode) {
        print("List<ProductImageModel> fromJsonList$e");
      }
    }
    return [];
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'categoryId': categoryId,
      'name': name,
      'vaT_Rate': vat,
      'unitId': unitId,
      'desc': desc,
      'thumbPath': thumbPath,
      'productCode': productCode,
      'price': basePrice.value,
      'offerPrice': offerPrice.value,
      'discountPercentage': discountPercentage.value,
      'inventoryBalance': inventoryBalance.value,
    };
  }
  bool isCheapestOffer(int index) {
    if (offers.isEmpty || index < 0 || index >= offers.length) return false;

    final cheapestPrice = offers.map((o) => o.price).reduce((a, b) => a < b ? a : b);
    return offers[index].price == cheapestPrice;
  }
  void updatePrices(ProductModel p){
    basePrice.value = p.basePrice.value;
    offerPrice.value = p.offerPrice.value;
    discountPercentage.value = p.discountPercentage.value;
  }
  //Computed Values
  double get lastPrice {
    if(offerPrice.value > 0){
      return offerPrice.value;
    }
    else{
      return basePrice.value;
    }
  }
  double get basePriceIncludeVat => basePrice.value + ((vat * basePrice.value) / 100);
  double get discountedBasePrice => lastPrice-(discountPercentage.value * lastPrice);
  double get priceIncludeVat => discountedBasePrice + ((vat * discountedBasePrice) / 100);
  double get vatValue => ((vat * discountedBasePrice) / 100);

  String getPreDiscountPrice(){
    if(offerPrice.value>0 || discountPercentage.value>0){
      return "${(basePrice.value + ((vat * basePrice.value) / 100)).toStringAsFixed(2)} ريال";
    }
    return "";
  }

  //Display Helpers
  String get getPriceIncludeVat=> (priceIncludeVat>0)?priceIncludeVat.toStringAsFixed(2):"";
  String getDiscountRate(){
    if(discountPercentage.value==0) return "";
    return "${(discountPercentage*100).toInt()}% ";
  }

  int isAvailable(int qty){
    if(inventoryBalance.value==0) {
      return -1;
    }
    else if(inventoryBalance.value> qty) {
      return 1;
    } else if(inventoryBalance.value == qty) {
      return 0;
    }
    return -1;
  }

  String getThumbPath(){
    String path = thumbPath;
    if(path.isEmpty){
      path = "no_image.jpg";
    }
    return erpUrl()+imagesDirPath()+path;
  }

  String getProductCode(){
    if(productCode == null || productCode == "") return "";
    return productCode!;
  }

  List<ProductOffer> get displayOffers {
    final baseOffer = ProductOffer(
      id: 0,
      productId: id,
      qtyFrom: 1,
      qtyTo: 1,
      price:  double.parse(basePrice.value.toStringAsFixed(2)),
    );

    return [baseOffer, ...offers];
  }

  RxInt selectedOfferId = 0.obs;
  void updateSelectedOffer(int quantity) {
    ProductOffer? offer;

    if (offers.isNotEmpty) {
      offer = offers.firstWhere(
            (o) => quantity >= o.qtyFrom && quantity <= o.qtyTo,
        orElse: () => displayOffers.first,
      );
      selectedOfferId.value = offer.id;
    } else {
      selectedOfferId.value = 0;
    }
    print("selectedOfferId.value:"+selectedOfferId.value.toString());
  }
}
class Attribute {
  String? label;
  String? value;
  Attribute({this.label, this.value});
}
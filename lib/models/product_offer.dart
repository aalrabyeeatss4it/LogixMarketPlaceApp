import 'package:get/get.dart';

class ProductOffer {
  int id;
  int productId;
  int qtyFrom;
  int qtyTo;
  double price;
  ProductOffer(
      {required this.id,
      required this.productId,
      required this.qtyFrom,
      required this.qtyTo,
      required this.price});
  factory ProductOffer.fromJson(Map<String, dynamic> json){
    return ProductOffer(
      id: json['id'],
      productId: json['productId'],
      qtyFrom: json['qtyFrom'],
      qtyTo: json['qtyTo'],
      price: json['price'],
    );
  }

  String getOfferPrice(){
    return '$price';
  }

  String getOfferPriceUnit(){
    return 'rial'.tr+'per piece'.tr;
  }
  String getOfferPriceCurrency(){
    return 'rial'.tr;
  }

  String getOfferRange(){
    var range = '$qtyFrom';
    if(id!=0){
      range = '$range+';
    }
    return range;
  }

  String getOfferMessage(double basePrice){
    if(id==0){
      return 'base price'.tr;
    }
    return '${'get'.tr} ${(basePrice-price).toStringAsFixed(0)} ${'rial'.tr}${'per piece'.tr}';
  }

  static List<ProductOffer> fromJsonList(List<dynamic>? jsonList) {
    try{
      if(jsonList == null) return [];
      List<ProductOffer>  list = jsonList.map((item) => ProductOffer.fromJson(item)).toList();
      return list;
    }
    catch(e){
      print("fromJsonList"+e.toString());
    }
    return [];
  }

}

import 'package:get/get.dart';
import 'package:logix_market_place/models/shipment_info_model.dart';

import 'delivery_fee_model.dart';
import 'order_item_model.dart';

class OrderModel{
  String? subTotal;
  String? deliveryFee;
  String? total;
  String? paid;
  String? remaining;
  String? orderId;
  String? orderCode;
  String? shipmentMethodId;
  String? shipmentCompanyId;
  String? trackingId;
  String? paymentMethod;
  String? paymentMethodId;
  String? orderStatus;
  String? deliveryAddressId;
  String? expectedDeliveryDate;
  String? deliveryDate;
  ShipmentInfoModel? shipmentInfo;
  RxBool selected= false.obs;
  RxBool isExpanded = true.obs;
  List<OrderItemModel>? items;

  OrderModel({
    this.subTotal,
    this.deliveryFee,
    this.total,
    this.orderId,
    this.orderCode,
    this.shipmentMethodId,
    this.shipmentCompanyId,
    this.trackingId,
    this.paymentMethod,
    this.paymentMethodId,
    this.orderStatus,
    this.deliveryAddressId,
    this.expectedDeliveryDate,
    this.deliveryDate,
    this.paid,
    this.remaining,
    this.items,
    this.shipmentInfo,
  });
  get getTotal => (total!=null && total!= "")? double.tryParse(total!)?.toStringAsFixed(2):"";
  get getSubTotal => (subTotal!=null && subTotal!= "")? double.tryParse(subTotal!)?.toStringAsFixed(2):"";
  get getVat => (total!=null && total!= "" && subTotal!=null && subTotal!= "")? ( double.tryParse(total!)! - double.tryParse(subTotal!)!).toStringAsFixed(2):"";
  get getSubTotalWithoutDelivery {
    if(subTotal!=null && subTotal!= ""){
      double subTot= 0;
      subTot = double.tryParse(subTotal!)!;
      OrderItemModel? deliveryFeeItem = getDeliveryItem();
      if(deliveryFeeItem!=null){
        subTot = subTot -  deliveryFeeItem.price;
      }
      return subTot.toStringAsFixed(2);
    }
    else{
      return "";
    }
  }
  get getDeliveryFee {
    if(subTotal!=null && subTotal!= ""){
      double deliveryFee= 0;
      OrderItemModel? deliveryFeeItem = getDeliveryItem();
      if(deliveryFeeItem!=null){
        deliveryFee = deliveryFeeItem.price;
      }
      return deliveryFee.toStringAsFixed(2);
    }
    else{
      return "";
    }
  }
  OrderItemModel? getDeliveryItem(){
    for(var item in items!){
      if(item.productId==shipmentInfo?.feeProductId){
        return item;
      }
    }
    return null;
  }

  factory OrderModel.fromJson(Map<String, dynamic> json) {
    return OrderModel(
      subTotal: json['subTotal']?.toString() ?? '0',
      deliveryFee: json['deliveryFee']?.toString() ?? '0',
      total: json['total']?.toString() ?? '0',
      orderId: json['orderId']?.toString() ?? '',
      orderCode: json['orderCode']?.toString() ?? '',
      shipmentMethodId: json['shipmentMethod']?.toString() ?? '',
      shipmentCompanyId: json['shipmentCompany']?.toString() ?? '',
      trackingId: json['trackingId']?.toString() ?? '',
      paymentMethod: json['paymentMethod']?.toString() ?? '',
      paymentMethodId: json['paymentMethodId']?.toString() ?? '',
      orderStatus: json['orderStatus']?.toString() ?? '',
      deliveryAddressId: json['deliveryAddressId']?.toString() ?? '0',
      expectedDeliveryDate: json['expectedDeliveryDate']?.toString() ?? '',
      deliveryDate: json['deliveryDate']?.toString() ?? '',
      paid: json['paid']?.toString() ?? '',
      remaining: json['remaining']?.toString() ?? '',
      shipmentInfo: ShipmentInfoModel.fromJson(json['shipmentInfo']),
      items: (json['items'] as List<dynamic>?)
          ?.map((e) => OrderItemModel.fromJson(e))
          .toList() ??
          [],
    );
  }

  static List<OrderModel> fromJsonList(List<dynamic> jsonList) {
    return jsonList.map((o)=> OrderModel.fromJson(o)).toList();
  }
  Map<String, dynamic> toJson() {
    return {
      'subTotal': subTotal,
      'deliveryFee': deliveryFee,
      'total': total,
      'orderId': orderId,
      'shipmentMethodId': shipmentMethodId,
      'shipmentCompanyId': shipmentCompanyId,
      'trackingId': trackingId,
      'paymentMethod': paymentMethod,
      'orderStatus': orderStatus,
      'deliveryAddressId': deliveryAddressId,
      'expectedDeliveryDate': expectedDeliveryDate,
      'deliveryDate': deliveryDate,
      'items': items?.map((e) => e.toJson()).toList(),
    };
  }
}
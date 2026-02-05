import 'package:get/get.dart';

import 'order_item_model.dart';

class OrderModel{
  String? subTotal;
  String? deliveryFee;
  String? total;
  String? paid;
  String? remaining;
  String? orderId;
  String? orderCode;
  String? shipmentMethod;
  String? trackingId;
  String? paymentMethod;
  String? paymentMethodId;
  String? orderStatus;
  String? deliveryAddressId;
  String? expectedDeliveryDate;
  String? deliveryDate;
  RxBool selected= false.obs;
  List<OrderItemModel>? items;

  OrderModel({
    this.subTotal,
    this.deliveryFee,
    this.total,
    this.orderId,
    this.orderCode,
    this.shipmentMethod,
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
  });
  get getTotal => (total!=null && total!= "")? double.tryParse(total!)?.toStringAsFixed(2):"";
  get getSubTotal => (subTotal!=null && subTotal!= "")? double.tryParse(subTotal!)?.toStringAsFixed(2):"";
  get getVat => (total!=null && total!= "" && subTotal!=null && subTotal!= "")? ( double.tryParse(total!)! - double.tryParse(subTotal!)!).toStringAsFixed(2):"";
  factory OrderModel.fromJson(Map<String, dynamic> json) {
    return OrderModel(
      subTotal: json['subTotal']?.toString() ?? '0',
      deliveryFee: json['deliveryFee']?.toString() ?? '0',
      total: json['total']?.toString() ?? '0',
      orderId: json['orderId']?.toString() ?? '',
      orderCode: json['orderCode']?.toString() ?? '',
      shipmentMethod: json['shipmentMethod']?.toString() ?? '',
      trackingId: json['trackingId']?.toString() ?? '',
      paymentMethod: json['paymentMethod']?.toString() ?? '',
      paymentMethodId: json['paymentMethodId']?.toString() ?? '',
      orderStatus: json['orderStatus']?.toString() ?? '',
      deliveryAddressId: json['deliveryAddressId']?.toString() ?? '0',
      expectedDeliveryDate: json['expectedDeliveryDate']?.toString() ?? '',
      deliveryDate: json['deliveryDate']?.toString() ?? '',
      paid: json['paid']?.toString() ?? '',
      remaining: json['remaining']?.toString() ?? '',
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
      'shipmentMethod': shipmentMethod,
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
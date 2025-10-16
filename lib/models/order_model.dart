import 'order_item_model.dart';

class OrderModel{
  String? subTotal;
  String? deliveryFee;
  String? total;
  String? orderId;
  String? shipmentMethod;
  String? trackingId;
  String? paymentMethod;
  String? orderStatus;
  String? deliveryAddressId;
  String? expectedDeliveryDate;
  String? deliveryDate;
  List<OrderItemModel>? items;

  OrderModel({
    this.subTotal,
    this.deliveryFee,
    this.total,
    this.orderId,
    this.shipmentMethod,
    this.trackingId,
    this.paymentMethod,
    this.orderStatus,
    this.deliveryAddressId,
    this.expectedDeliveryDate,
    this.deliveryDate,
    this.items,
  });

  factory OrderModel.fromJson(Map<String, dynamic> json) {
    return OrderModel(
      subTotal: json['subTotal']?.toString() ?? '0',
      deliveryFee: json['deliveryFee']?.toString() ?? '0',
      total: json['total']?.toString() ?? '0',
      orderId: json['orderId']?.toString() ?? '',
      shipmentMethod: json['shipmentMethod']?.toString() ?? '',
      trackingId: json['trackingId']?.toString() ?? '',
      paymentMethod: json['paymentMethod']?.toString() ?? '',
      orderStatus: json['orderStatus']?.toString() ?? '',
      deliveryAddressId: json['deliveryAddressId']?.toString() ?? '0',
      expectedDeliveryDate: json['expectedDeliveryDate']?.toString() ?? '',
      deliveryDate: json['deliveryDate']?.toString() ?? '',
      items: (json['items'] as List<dynamic>?)
          ?.map((e) => OrderItemModel.fromJson(e))
          .toList() ??
          [],
    );
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
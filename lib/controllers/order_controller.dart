import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:logix_market_place/models/delivery_cost_request_model.dart';
import 'package:logix_market_place/models/order_model.dart';
import 'package:logix_market_place/models/shipment_company_model.dart';
import 'package:logix_market_place/models/shipment_option_model.dart';
import 'package:logix_market_place/services/service_result.dart';
import '../common/dialogs/bottom_sheets.dart';
import '../common/nav/page_routes.dart';
import '../models/cart_item_model.dart';
import '../models/delivery_address_model.dart';
import '../models/delivery_fee_model.dart';
import '../models/order_item_model.dart';
import '../models/shipment_method_model.dart';
import '../services/address_service.dart';
import '../services/order_service.dart';
import '../services/product_detail_service.dart';
import 'cart_controller.dart';

class OrderController extends GetxController{
  final CartController cartController = Get.put(CartController());
  Rx<DeliveryInfoModel> deliveryFee = DeliveryInfoModel(productId: 0, fee: 0,vat: 0, date: '').obs;
  RxInt paymentMethod = 2.obs;
  RxInt shipmentMethod = 0.obs;
  RxInt shipmentCompany = 0.obs;
  RxInt deliveryAddressId = 0.obs;
  RxString shipmentMethodErrorMessage = "".obs;
  RxString shipmentCompanyErrorMessage = "".obs;
  RxString addressErrorMessage = "".obs;

  void setShipmentMethod(int methodId){
    shipmentMethod.value = methodId;
    getDeliveryCost();
  }

  void setShipmentCompany(int companyId){
    print("setShipmentCompany");
    shipmentCompany.value = companyId;
    if(companyId==0){
      shipmentCompanyNote.value ="";
    }
    for(var comp in shipmentCompanies){
      if(comp.id==companyId){
        shipmentCompanyNote.value = comp.disclaimerMessage ?? "";
      }
    }
    getDeliveryCost();
  }
  bool validateCheckout() {
    shipmentMethodErrorMessage.value = "";
    shipmentCompanyErrorMessage.value = "";
    addressErrorMessage.value = "";

    bool valid = true;

    if (shipmentMethod.value == 0) {
      shipmentMethodErrorMessage.value = "Please select shipment method".tr;
      valid = false;
    }

    if (shipmentMethod.value == 3 && shipmentCompany.value == 0) {
      print("shipmentCompany");
      shipmentCompanyErrorMessage.value = "Please select shipment company".tr;
      valid = false;
    }

    if (deliveryAddressId.value == 0) {
      addressErrorMessage.value = "Please select delivery address".tr;
      valid = false;
    }

    return valid;
  }
  Rx<DeliveryAddressModel?> deliveryAddress = DeliveryAddressModel().obs;

  OrderService service = Get.put(OrderService());
  AddressService addressService = Get.put(AddressService());
  RxList<OrderModel> orders = <OrderModel>[].obs;
  Rx<ShipmentOptionModel> shipmentOptions = ShipmentOptionModel().obs;
  RxList<ShipmentMethodModel> shipmentMethods = <ShipmentMethodModel>[].obs;
  RxList<ShipmentCompanyModel> shipmentCompanies = <ShipmentCompanyModel>[].obs;
  RxList<DeliveryAddressModel> addresses = <DeliveryAddressModel>[].obs;

  var isLoading = false.obs;
  var shipmentCompanyNote = "".obs;
  int page = 1;
  bool hasMore = true;
  ScrollController scroll = ScrollController();

  Future<void> getAddresses() async {
    try{
      var serviceResult = await addressService.getAddresses();
      if(serviceResult is SuccessStatus<List<DeliveryAddressModel>>){
        if(serviceResult.data!.isNotEmpty){
          addresses.addAll(serviceResult.data!);
          DeliveryAddressModel? defaultAddress = addresses.firstWhereOrNull((a)=> a.isDefault == true);
          deliveryAddress.value = defaultAddress;
        }
      }
    }
    catch(ex){
      print(ex.toString());
    }
    finally {
    }
  }

  Future<void> getShipmentOptions() async {
    try{
      var serviceResult = await service.getShipmentOptions();
      if(serviceResult is SuccessStatus<ShipmentOptionModel>){
        shipmentMethods.assignAll(serviceResult.data!.shipmentMethods);
        shipmentCompanies.assignAll(serviceResult.data!.shipmentCompanies);
      }
    }
    finally {
    }
  }

  Future<void> getDeliveryCost() async {
    try{
      DeliveryCostRequestModel  costRequestModel = DeliveryCostRequestModel(shipmentMethodId: shipmentMethod.value.toString(), shipmentCompanyId: shipmentCompany.value.toString());
      var serviceResult = await service.getDeliveryCost(costRequestModel);
      if(serviceResult is SuccessStatus<DeliveryInfoModel>){
        deliveryFee.value = serviceResult.data!;
      }
    }
    finally {
    }
  }

  @override
  void onInit() {
    super.onInit();
    getShipmentOptions();
    scroll.addListener(() {
      if (scroll.position.pixels == scroll.position.maxScrollExtent) {
        getOrders();
      }
    });
  }

  Future<void> orderAgain(String orderCode) async {
    ProductDetailService productDetailService = Get.put(ProductDetailService());
    try{
      var serviceResult = await service.getOrder(orderCode);
      if(serviceResult is SuccessStatus<OrderModel>){
        if(serviceResult.data != null){
          var order = serviceResult.data!;
          for(var orderItem in order.items!){
            int qty = (orderItem.quantity as num).toInt();
            var product = await productDetailService.getProduct(orderItem.productId, qty);
            if(product != null && orderItem.quantity <= product.inventoryBalance.value){
              var item = CartItemModel(product: product);
              item.quantity.value = qty;
              cartController.addItem(item);
            }
          }
        }
      }
    }
    catch(ex){
      print(ex.toString());
    }
  }
  Future<void> createOrder() async {
    print("createOrder");
    if(isLoading.value) return;
    try {
      isLoading.value = true;
      var order = OrderModel();
      order.paymentMethod = paymentMethod.value.toString();
      order.deliveryAddressId = deliveryAddressId.value.toString();
      order.shipmentMethodId = shipmentMethod.value.toString();
      order.shipmentCompanyId = shipmentCompany.value.toString();
      order.deliveryFee = deliveryFee.value.fee.toString();
      print("createOrder");

      order.items = cartController.items.map((item) => OrderItemModel.fromCartItem(item)).toList();
      var serviceResult = await service.createOrder(order);
      if (serviceResult is SuccessStatus<String>) {
        Get.back();
        cartController.clearCart();
        var createdOrder = await getOrder(serviceResult.data!);

        Get.back();
        showSuccessOrderBottomSheet(onConfirm: () {
          Get.toNamed(RouteNames.orderDetailsPage, arguments: createdOrder);
        });
      }
      else if (serviceResult is FailureStatus) {
        Get.back();
        showFailureBottomSheet(errorMessage: serviceResult.errorMessage, onConfirm: () {});
      }
      else {
        Get.back();
        showFailureBottomSheet(onConfirm: () {});
      }
    }
    catch(ex){
      isLoading.value = false;
    }
    finally {
      isLoading.value = false;
    }
  }

  Future<OrderModel?> getOrder(String orderId) async {
    isLoading.value = true;
    try{
      var serviceResult = await service.getOrder(orderId);
      if(serviceResult is SuccessStatus<OrderModel>){
        if(serviceResult.data != null){
          var order = serviceResult.data!;
          return order;
        }
      }
    }
    catch(ex){
      isLoading.value = false;
    }
    finally {
      isLoading.value = false;
    }
    return null;
  }
  Future<void> getOrders() async {
    if(isLoading.value || !hasMore) return;
    isLoading.value = true;
    try{
      String filters = "page=$page";
      var serviceResult = await service.getOrders(filters);
      if(serviceResult is SuccessStatus<List<OrderModel>>){
        if(serviceResult.data!.isEmpty){
          hasMore = false;
        }
        else{
          orders.addAll(serviceResult.data!);
          page++;
        }
      }
    }
    catch(ex){
      print(ex.toString());
      isLoading.value = false;
    }
    finally {
      isLoading.value = false;
    }
  }

}
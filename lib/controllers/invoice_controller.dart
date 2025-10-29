import 'package:get/get.dart';
import 'package:logix_market_place/models/order_model.dart';
import 'package:logix_market_place/services/service_result.dart';
import '../common/dialogs/bottom_sheets.dart';
import '../common/nav/page_routes.dart';
import '../models/customer_invoices_model.dart';
import '../models/order_item_model.dart';
import '../services/invoice_service.dart';
import '../services/order_service.dart';
import 'cart_controller.dart';

class InvoiceController extends GetxController{
  InvoiceService service = Get.put(InvoiceService());
  Rx<CustomerInvoicesModel>  invoicesModel = CustomerInvoicesModel().obs;

  Future<void> getInvoices() async {
    var serviceResult = await service.getInvoices();
    if(serviceResult is SuccessStatus<CustomerInvoicesModel>){
      invoicesModel.value = serviceResult.data!;

    }
  }
}
import 'invoice_summary_model.dart';
import 'order_model.dart';

class CustomerInvoicesModel {
  List<OrderModel>? invoices;
  InvoiceSummaryModel? summaryDto;
  CustomerInvoicesModel({this.invoices, this.summaryDto});

  factory CustomerInvoicesModel.fromJson(Map<String, dynamic> json) {
    return CustomerInvoicesModel(
        invoices: OrderModel.fromJsonList(json["invoices"]),
        summaryDto: InvoiceSummaryModel.fromJson(json["summaryDto"]));
  }
}

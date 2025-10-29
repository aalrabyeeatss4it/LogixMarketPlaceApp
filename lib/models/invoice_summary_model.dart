class InvoiceSummaryModel {
  int unpaidCount = 0;
  double paid = 0;
  double remaining = 0;
  InvoiceSummaryModel({
    required this.unpaidCount,
    required this.paid,
    required this.remaining,
  });
  factory InvoiceSummaryModel.fromJson(Map<String, dynamic> json) {
    return InvoiceSummaryModel(
      unpaidCount: int.parse(json['unpaidCount'].toString()),
      paid: double.parse(json['paid'].toString()),
      remaining: double.parse(json['remaining'].toString()),
    );
  }
}

class TransModel{
  String? transDate;
  String? amount;
  String? transNo;
  String? description;

  TransModel({
    this.transNo,
    this.amount,
    this.transDate,
    this.description
  });

  factory TransModel.fromJson(Map<String, dynamic> json) {
    return TransModel(
      transDate: json['transDate']?.toString() ?? '0',
      amount: json['amount']?.toString() ?? '0',
      transNo: json['transNo']?.toString() ?? '0',
      description: json['description']?.toString() ?? ''
    );
  }

  static List<TransModel> fromJsonList(List<dynamic> jsonList) {
    return jsonList.map((o)=> TransModel.fromJson(o)).toList();
  }
  Map<String, dynamic> toJson() {
    return {
      'transDate': transDate,
      'amount': amount,
      'transNo': transNo,
      'description': description
    };
  }
}
class CustomerBalanceModel {
  String? balance;
  String? creditLimit;
  CustomerBalanceModel({this.balance, this.creditLimit});
  factory CustomerBalanceModel.fromJson(Map<String, dynamic> json) {
    print("creditLimit:"+json["creditLimit"].toString());
    return CustomerBalanceModel(
        balance: json["balance"].toString(), creditLimit: json["creditLimit"].toString());
  }
}

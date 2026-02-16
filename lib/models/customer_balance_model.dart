import 'dart:ffi';

class CustomerBalanceModel {
  String? creditBalance;
  String? creditLimit;
  double debit;
  CustomerBalanceModel({this.creditBalance, this.creditLimit, required this.debit});
  factory CustomerBalanceModel.fromJson(Map<String, dynamic> json) {
    return CustomerBalanceModel(
        creditBalance: json["creditBalance"].toString(),
        creditLimit: json["creditLimit"].toString(),
        debit:((json["debit"])!=null)? double.parse(json["debit"].toString()):0);
  }
  String getDebit(){
    return debit.toString();
  }
}

import 'package:get/get.dart';
import 'package:logix_market_place/common/api_paths.dart';

class TransModel{
  String? transDate;
  String? amount;
  String? transNo;
  String? docTypeId;
  String? description;

  TransModel({
    this.transNo,
    this.amount,
    this.transDate,
    this.description,
    this.docTypeId
  });

  factory TransModel.fromJson(Map<String, dynamic> json) {
    return TransModel(
      transDate: json['transDate']?.toString() ?? '0',
      amount: json['amount']?.toString() ?? '0',
      transNo: json['transNo']?.toString() ?? '0',
      description: json['description']?.toString() ?? '',
      docTypeId: json['docTypeId']?.toString() ?? ''
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
      'docTypeId': docTypeId,
      'description': description
    };
  }

  String getTransNo(){
    if(transNo == null || transNo!.isEmpty || transNo! == "0") return "";
    return "Id".tr+(transNo??"");
  }
    String? getPrintUrl(String userID,String token){
    print("userID:"+userID);
    print("token:"+token);
    print("docTypeId:"+docTypeId.toString());
    int reportID = 0;
    if(docTypeId=="1") {
      reportID = 2;
    } else if(docTypeId=="14") {
      reportID = 1;
    }
    else {
      return null;
    }
    return erpUrl()+'/ClientArea/Sales/PdfReport?USER_ID=$userID&token=$token&Rep_ID=$reportID&T_ID=$transNo';
  }

}
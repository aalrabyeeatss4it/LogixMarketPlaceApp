class AuthorizedUserModel {
  String userName;
  String userId;
  String token;
  String branchId;
  String facilityID;
  String customerID;
  String customerName;
  String customerPhone;

  AuthorizedUserModel({
    required this.userName,
    required this.userId,
    required this.token,
    required this.branchId,
    required this.facilityID,
    required this.customerID,
    required this.customerName,
    required this.customerPhone,
  });

  factory AuthorizedUserModel.fromJson(Map<String, dynamic> json) {
    return AuthorizedUserModel(
      userName: json['userName'] ?? '',
      userId: json['userId'] ?? '',
      token: json['token'] ?? '',
      branchId: json['branchId'] ?? '',
      facilityID: json['facility_ID'] ?? '',
      customerID: json['customerID'] ?? '',
      customerName: json['customerName'] ?? '',
      customerPhone: json['customerPhone'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'userName': userName,
      'userId': userId,
      'token': token,
      'branchId': branchId,
      'facility_ID': facilityID,
      'customerID': customerID,
      'customerName': customerName,
      'customerPhone': customerPhone,
    };
  }
}

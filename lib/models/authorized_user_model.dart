class AuthorizedUserModel {
  String userName;
  String firstName;
  String lastName;
  String email;
  String userId;
  String token;
  String branchId;
  String facilityID;
  String customerID;
  String customerName;
  String customerPhone;
  String customerTaxNo;

  AuthorizedUserModel({
    required this.userName,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.userId,
    required this.token,
    required this.branchId,
    required this.facilityID,
    required this.customerID,
    required this.customerName,
    required this.customerPhone,
    required this.customerTaxNo,
  });

  factory AuthorizedUserModel.fromJson(Map<String, dynamic> json) {
    return AuthorizedUserModel(
      userName: json['userName'] ?? '',
      firstName: json['firstName'] ?? '',
      lastName: json['lastName'] ?? '',
      email: json['email'] ?? '',
      userId: json['userId'] ?? '',
      token: json['token'] ?? '',
      branchId: json['branchId'] ?? '',
      facilityID: json['facility_ID'] ?? '',
      customerID: json['customerID'].toString() ?? '',
      customerName: json['customerName'] ?? '',
      customerPhone: json['customerPhone'] ?? '',
      customerTaxNo: json['customerTaxNo'] ?? '',
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

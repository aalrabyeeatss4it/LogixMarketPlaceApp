class UserPasswordModel {
  String? resetId;
  String? userName;
  String? otp;
  String? email;
  String? mobileNo;
  String? password;
  String? userId;

  UserPasswordModel({
    this.resetId,
    this.userName,
    this.otp,
    this.email,
    this.mobileNo,
    this.password,
    this.userId,
  });

  factory UserPasswordModel.fromJson(Map<String, dynamic> json) {
    return UserPasswordModel(
      resetId: json['resetId'],
      userName: json['userName'],
      otp: json['otp'],
      email: json['email'],
      mobileNo: json['mobileNo'],
      password: json['password'],
      userId: json['userId'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'resetId': resetId?? "",
      'userName': userName??"",
      'otp': otp??"",
      'email': email??"",
      'mobileNo': mobileNo??"",
      'password': password??"",
      'userId': userId??"",
    };
  }
}

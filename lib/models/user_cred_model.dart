class UserCredModel {
  String? username;
  String? password;
  UserCredModel({this.username, this.password});
  Map<String,dynamic> toJson(){
    return {
      "username": username,
      "password": password,
    };
  }
}






import 'dart:convert';

class AuthModel {

  final String logId;
  String userName;
  String address;
  String logo;
  String email;
  String sellerId;
  String mobile;
  String name;

  AuthModel.test({
    this.logId="ATest@admin.com",
    this.address="",
    this.email="ATest@gmail.com",
    this.logo="https://th.bing.com/th/id/OIP.SHOz2Yw0GPtqgVueWxIKEQHaHa?rs=1&pid=ImgDetMain",
    // this.logo="https://c8.alamy.com/comp/2XA854W/public-domain-license-soft-blue-concept-icon-2XA854W.jpg",
    this.mobile="1234567890",
    this.sellerId="ATestAiu729-001-ERT",
    this.userName="ATest_001",
    this.name="AT",
  });
  
  AuthModel.empty({
    this.logId="",
    this.address="",
    this.email="",
    this.logo="",
    this.mobile="",
    this.sellerId="",
    this.userName="",
    this.name="",
  });

  bool get isModelEmpty => logId.isEmpty;


  String toJson() => jsonEncode({
    "user_name": userName,
    "address": address,
    "logo": logo,
    "email": email,
    "id": logId,
    "sid": sellerId,
    "name": name
  });

  factory AuthModel.fromJson(String json) {
    if(json.isEmpty){
      return AuthModel.empty();
    }
    Map<String,dynamic> mapValue = jsonDecode(json);
    return AuthModel.empty(
      address: mapValue["address"],
      email: mapValue["email"],
      userName: mapValue["user_name"],
      logo: mapValue["logo"],
      logId: mapValue["id"] ?? "",
      name: mapValue["name"] ?? "",
      sellerId: mapValue["sid"] ?? "",
    );
  }

}
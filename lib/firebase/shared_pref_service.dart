


import 'package:flutter_dashboard/model/auth_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefService {

  static SharedPrefService service = SharedPrefService();

  void saveUserLogData(AuthModel auth) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    if(!auth.isModelEmpty){
      preferences.setString("USER_LOGIN", auth.toJson());
    }else{
      preferences.setString("USER_LOGIN", "");
    }
  }

  Future<AuthModel> get userLogData async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String json = preferences.getString("USER_LOGIN") ?? "";
    return AuthModel.fromJson(json);
  }

}
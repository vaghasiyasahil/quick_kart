import 'package:shared_preferences/shared_preferences.dart';

class preferences{
  static late SharedPreferences prefs;

  static Future<void> iniMemory() async {
    prefs = await SharedPreferences.getInstance();
  }

  static void setIsLogin(bool isLogin) {
    prefs.setBool("isLogin", isLogin);
  }
  static bool getIsLogin() {
    return prefs.getBool("isLogin")??false;
  }
  
  static setUserId(int id){
    prefs.setInt("UID", id);
  }
  static int getUserId(){
    return prefs.getInt("UID")??0;
  }

}
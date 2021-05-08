import 'package:shared_preferences/shared_preferences.dart';

class SharedPreference {
  final String userUID;
  final String memberUid;
  //final String token;

  SharedPreference({this.userUID, this.memberUid});

  Future<void> setUserUID() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setString('uid', userUID);
    print(userUID);
  }

  Future<String> getUserUID() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String uid = preferences.getString('uid');
    print(uid);
    return uid;
  }

  Future<void> setMemberUID() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setString('mUid', memberUid);
    print(memberUid);
  }

  Future<String> getMemberUID() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String uid = preferences.getString('mUid');
    print(uid);
    return uid;
  }

  static Future<void> setToken(String token) async {
    final SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setString('token', token);
    print(token);
  }

  static Future<String> getToken() async {
    final SharedPreferences preferences = await SharedPreferences.getInstance();
    String token = preferences.getString('token');
    print(token);
    return token;
  }

  static Future<void> setIsLoggedIn(bool isLoggedIn) async {
    final SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setBool('isLoggedIn', isLoggedIn);
    print(isLoggedIn);
  }

  static Future<bool> getIsLoggedIn() async {
    final SharedPreferences preferences = await SharedPreferences.getInstance();
    bool isLoggedIn = preferences.getBool('isLoggedIn');
    return isLoggedIn;
  }
}

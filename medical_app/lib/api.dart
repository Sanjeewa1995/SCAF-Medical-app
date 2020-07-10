import 'package:http/http.dart' as http;
import 'dart:convert';



// LogIn Page

Future<String> logInUser(String userName, String password) async {
  final String url = 'https://scaf.lk:610/api/Auth/login';
  final response = await http.post(
    url,
    headers: {
      "Accept": "*/*",
      "content-type": 'application/json; charset=utf-8'
    },
    body: jsonEncode({
      'UserName': userName,
      'Password': password,
    }),
  );
  if (response.statusCode == 200) {
    print('200');
    final String responseString = response.body;
    var res = await  userModelFromJson(responseString);
    return res.appUser.userName;
    // return response.statusCode.toString();
  } else {
    print(response.statusCode);
    return 'User name is invalid';
    // final String responseString = response.body;
    // return userModelFromJson(responseString);
  }
}

UserModel userModelFromJson(String str) => UserModel.fromJson(json.decode(str));

String userModelToJson(UserModel data) => json.encode(data.toJson());

class UserModel {
  UserModel({
    this.token,
    this.appUser,
  });

  String token;
  AppUser appUser;

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        token: json["token"],
        appUser: AppUser.fromJson(json["appUser"]),
      );

  Map<String, dynamic> toJson() => {
        "token": token,
        "appUser": appUser.toJson(),
      };
}

class AppUser {
  AppUser({
    this.id,
    this.userName,
    this.passwordHash,
    this.email,
    this.regDate,
    this.gender,
    this.age,
    this.knownAs,
    this.created,
    this.lastActive,
    this.photoUrl,
    this.uid,
    this.userRole,
    this.lastLoginDate,
    this.securityStamp,
  });

  int id;
  String userName;
  String passwordHash;
  String email;
  DateTime regDate;
  dynamic gender;
  int age;
  dynamic knownAs;
  DateTime created;
  DateTime lastActive;
  dynamic photoUrl;
  String uid;
  String userRole;
  DateTime lastLoginDate;
  String securityStamp;

  factory AppUser.fromJson(Map<String, dynamic> json) => AppUser(
        id: json["id"],
        userName: json["userName"],
        passwordHash: json["passwordHash"],
        email: json["email"],
        regDate: DateTime.parse(json["regDate"]),
        gender: json["gender"],
        age: json["age"],
        knownAs: json["knownAs"],
        created: DateTime.parse(json["created"]),
        lastActive: DateTime.parse(json["lastActive"]),
        photoUrl: json["photoUrl"],
        uid: json["uid"],
        userRole: json["userRole"],
        lastLoginDate: DateTime.parse(json["lastLoginDate"]),
        securityStamp: json["securityStamp"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "userName": userName,
        "passwordHash": passwordHash,
        "email": email,
        "regDate": regDate.toIso8601String(),
        "gender": gender,
        "age": age,
        "knownAs": knownAs,
        "created": created.toIso8601String(),
        "lastActive": lastActive.toIso8601String(),
        "photoUrl": photoUrl,
        "uid": uid,
        "userRole": userRole,
        "lastLoginDate": lastLoginDate.toIso8601String(),
        "securityStamp": securityStamp,
      };
}


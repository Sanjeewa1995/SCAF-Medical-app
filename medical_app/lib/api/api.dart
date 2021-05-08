import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:dio/dio.dart';
import '../shared_preference.dart';
import 'package:connectivity/connectivity.dart';

import 'package:medical_app/api/api_response.dart';
import 'package:medical_app/api/api_status.dart';
import 'package:medical_app/api/dio_api_response.dart' as dioRes;

const mainUrl = 'https://scaf.lk:610/api/';
Dio dio = Dio();

class ApiCall {
    static Future<ApiResponse> multyFormPostRequest(
      {String endPoint, Map<String, dynamic> data}) async {
    try {
      var connectivityResult = await (Connectivity().checkConnectivity());
      if (connectivityResult == ConnectivityResult.mobile ||
          connectivityResult == ConnectivityResult.wifi) {
        var uri = Uri.parse(mainUrl + endPoint);
        var request = http.MultipartRequest('POST', uri)..fields.addAll(data);
        var streamResponse = await request.send();
        var response = await http.Response.fromStream(streamResponse);
        print(response.toString());
        return ApiResponse(response: response, validateToken: false);
      } else {
        ApiResponse response = ApiResponse();
        response.isSuccess = false;
        response.apiStatus = ApiStatus.NO_INTERNET;
        response.statusMessage = "Internet connection not available";
        return response;
      }
    } catch (e) {
      print(e.error);
      print(e.response.data);
      return e.response.data;
    }
  }

  static Future<dioRes.ApiResponse> dioPostRequest(
      {String endPoint, Map<String, dynamic> data}) async {
    try {
      var connectivityResult = await (Connectivity().checkConnectivity());
      if (connectivityResult == ConnectivityResult.mobile ||
          connectivityResult == ConnectivityResult.wifi) {
        print('1');
        final response = await dio.post(mainUrl + endPoint,
            data: FormData.fromMap(data),
            options: Options(headers: {
              'accept': "*/*",
              "Content-Type": "multipart/form-data"
            }));
        print(data.toString());
        return dioRes.ApiResponse(response: response, validateToken: false);
      } else {
        dioRes.ApiResponse response = dioRes.ApiResponse();
        response.isSuccess = false;
        response.apiStatus = ApiStatus.NO_INTERNET;
        response.statusMessage = "Internet connection not available";
        return response;
      }
    } on DioError catch (e) {
      print(e.error);
      print('hh');
      return e.response.data;
    }
  }

  static Future<ApiResponse> josnPostRequest(
      String endPoint, Map<String, dynamic> data) async {
    try {
      var connectivityResult = await (Connectivity().checkConnectivity());
      if (connectivityResult == ConnectivityResult.mobile ||
          connectivityResult == ConnectivityResult.wifi) {
        final response = await http.post(
          mainUrl + endPoint,
          headers: {
            "Accept": "*/*",
            "content-type": 'application/json; charset=utf-8'
          },
          body: jsonEncode(data),
        );
        return ApiResponse(response: response, validateToken: false);
      } else {
        ApiResponse response = ApiResponse();
        response.isSuccess = false;
        response.apiStatus = ApiStatus.NO_INTERNET;
        response.statusMessage = "Internet connection not available";
        return response;
      }
    } catch (e) {
      ApiResponse response = ApiResponse();
      response.isSuccess = false;
      response.statusMessage = e.toString();
      return response;
    }
  }

  static Future<ApiResponse> jsonGettRequest(String endPoint) async {
    try {
      var connectivityResult = await (Connectivity().checkConnectivity());
      if (connectivityResult == ConnectivityResult.mobile ||
          connectivityResult == ConnectivityResult.wifi) {
        final response = await http.get(mainUrl + endPoint);
        return ApiResponse(response: response, validateToken: false);
      } else {
        ApiResponse response = ApiResponse();
        response.isSuccess = false;
        response.apiStatus = ApiStatus.NO_INTERNET;
        response.statusMessage = "Internet connection not available";
        return response;
      }
    } catch (e) {
      ApiResponse response = ApiResponse();
      response.isSuccess = false;
      response.statusMessage = e.toString();
      return response;
    }
  }
}

// LogIn Page

// Future<String> logInUser(String endPoint, Map<String, dynamic> data) async {
//   final response = await http.post(
//     mainUrl + endPoint,
//     headers: {
//       "Accept": "*/*",
//       "content-type": 'application/json; charset=utf-8'
//     },
//     body: jsonEncode(data),
//   );
//   if (response.statusCode == 200) {
//     print('200');
//     final String responseString = response.body;
//     var res = userModelFromJson(responseString);
//     return res.appUser.uid;
//     // return response.statusCode.toString();
//   } else {
//     print(response.statusCode);
//     return null;
//     // final String responseString = response.body;
//     // return userModelFromJson(responseString);
//   }
// }

// UserModel userModelFromJson(String str) => UserModel.fromJson(json.decode(str));

// String userModelToJson(UserModel data) => json.encode(data.toJson());

// class UserModel {
//   UserModel({
//     this.token,
//     this.appUser,
//   });

//   String token;
//   AppUser appUser;

//   factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
//         token: json["token"],
//         appUser: AppUser.fromJson(json["appUser"]),
//       );

//   Map<String, dynamic> toJson() => {
//         "token": token,
//         "appUser": appUser.toJson(),
//       };
// }

// class AppUser {
//   AppUser({
//     this.id,
//     this.userName,
//     this.passwordHash,
//     this.email,
//     this.regDate,
//     this.gender,
//     this.age,
//     this.knownAs,
//     this.created,
//     this.lastActive,
//     this.photoUrl,
//     this.uid,
//     this.userRole,
//     this.lastLoginDate,
//     this.securityStamp,
//   });

//   int id;
//   String userName;
//   String passwordHash;
//   String email;
//   DateTime regDate;
//   dynamic gender;
//   int age;
//   dynamic knownAs;
//   DateTime created;
//   DateTime lastActive;
//   dynamic photoUrl;
//   String uid;
//   String userRole;
//   DateTime lastLoginDate;
//   String securityStamp;

//   factory AppUser.fromJson(Map<String, dynamic> json) => AppUser(
//         id: json["id"],
//         userName: json["userName"],
//         passwordHash: json["passwordHash"],
//         email: json["email"],
//         regDate: DateTime.parse(json["regDate"]),
//         gender: json["gender"],
//         age: json["age"],
//         knownAs: json["knownAs"],
//         created: DateTime.parse(json["created"]),
//         lastActive: DateTime.parse(json["lastActive"]),
//         photoUrl: json["photoUrl"],
//         uid: json["uid"],
//         userRole: json["userRole"],
//         lastLoginDate: DateTime.parse(json["lastLoginDate"]),
//         securityStamp: json["securityStamp"],
//       );

//   Map<String, dynamic> toJson() => {
//         "id": id,
//         "userName": userName,
//         "passwordHash": passwordHash,
//         "email": email,
//         "regDate": regDate.toIso8601String(),
//         "gender": gender,
//         "age": age,
//         "knownAs": knownAs,
//         "created": created.toIso8601String(),
//         "lastActive": lastActive.toIso8601String(),
//         "photoUrl": photoUrl,
//         "uid": uid,
//         "userRole": userRole,
//         "lastLoginDate": lastLoginDate.toIso8601String(),
//         "securityStamp": securityStamp,
//       };
// }

// // SignUp

// Response<String> responseBody;

// upload({
//   String bDate,
//   String nic,
//   String firstName,
//   String lastName,
//   String middleName,
//   String sirName,
//   String city,
//   String district,
//   String address,
//   String bPlace,
//   String bTime,
//   String userName,
//   String password,
//   String email,
//   String phoneNumber,
// }) async {
//   String url = 'https://scaf.lk:610/api/Auth/register';

//   FormData formData = FormData.fromMap({
//     'DateOfBirth': bDate,
//     'NationId': nic,
//     'FirstName': firstName,
//     'LastName': lastName,
//     'MiddleName': middleName,
//     'SurName': sirName,
//     'City': city,
//     'District': district,
//     'Address': address,
//     'BirthPlace': bPlace,
//     'BirthTime': bTime,
//     'UserName': userName,
//     'Password': password,
//     'Email': email,
//     'PhoneNumber': phoneNumber,
//   });
//   try {
//     responseBody = await dio.post(url,
//         data: formData,
//         options: Options(
//             headers: {'accept': "*/*", "Content-Type": "multipart/form-data"}));
//   } on DioError catch (e) {
//     print(e.error);
//     print(e.response.data);
//     return e.response.data; //e.response.data;
//     //   eMassage = await e.response.data;
//   }

//   final responseString = responseBody.data;
//   var res = signUpDataFromJson(responseString);
//   print(res);
//   print(responseBody.data);
//   await SharedPreference(userUID: res.userToReturn.uid).setUserUID();
//   return responseBody.statusCode.toString();
// }

// upload({
//   String bDate,
//   String nic,
//   String firstName,
//   String lastName,
//   String middleName,
//   String sirName,
//   String city,
//   String district,
//   String address,
//   String bPlace,
//   String bTime,
//   String userName,
//   String password,
//   String email,
//   String phoneNumber,
// }) async {
//   String url = 'https://scaf.lk:610/api/Auth/register';

//   FormData formData = FormData.fromMap({
//     'DateOfBirth': bDate,
//     'NationId': nic,
//     'FirstName': firstName,
//     'LastName': lastName,
//     'MiddleName': middleName,
//     'SurName': sirName,
//     'City': city,
//     'District': district,
//     'Address': address,
//     'BirthPlace': bPlace,
//     'BirthTime': bTime,
//     'UserName': userName,
//     'Password': password,
//     'Email': email,
//     'PhoneNumber': phoneNumber,
//   });
//   try {
//     responseBody = await dio.post(url,
//         data: formData,
//         options: Options(
//             headers: {'accept': "*/*", "Content-Type": "multipart/form-data"}));
//   } on DioError catch (e) {
//     print(e.error);
//     print(e.response.data);
//     return e.response.data; //e.response.data;
//     //   eMassage = await e.response.data;
//   }

//   final responseString = responseBody.data;
//   var res = signUpDataFromJson(responseString);
//   print(res);
//   print(responseBody.data);
//   await SharedPreference(userUID: res.userToReturn.uid).setUserUID();
//   return responseBody.statusCode.toString();
// }

SignUpData signUpDataFromJson(String str) =>
    SignUpData.fromJson(json.decode(str));

String signUpDataToJson(SignUpData data) => json.encode(data.toJson());

class SignUpData {
  SignUpData({
    this.userToReturn,
  });

  UserToReturn userToReturn;

  factory SignUpData.fromJson(Map<String, dynamic> json) => SignUpData(
        userToReturn: UserToReturn.fromJson(json["userToReturn"]),
      );

  Map<String, dynamic> toJson() => {
        "userToReturn": userToReturn.toJson(),
      };
}

class UserToReturn {
  UserToReturn({
    this.uid,
  });

  String uid;

  factory UserToReturn.fromJson(Map<String, dynamic> json) => UserToReturn(
        uid: json["uid"],
      );

  Map<String, dynamic> toJson() => {
        "uid": uid,
      };
}

//Select User

Future<List> getUserList() async {
  List members = [];
  String uid = await SharedPreference().getUserUID();
  print(uid);
  final String url = 'https://scaf.lk:610/api/Member/$uid';
  final response = await http.get(url);
  if (response.statusCode == 200) {
    print(response.statusCode);
    // print('object');
    print(response.body);
    final jsonData = json.decode(response.body);
    // final members = [];
    members = jsonData;
    // for (var item in jsonData) {
    //   final user = item["firstName"];
    //   members.add(user);
    //   print(jsonData);
    // }

  }
  return members;
  // else {
  //   print('faild');

  // }
}

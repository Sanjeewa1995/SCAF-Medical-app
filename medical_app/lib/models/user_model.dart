import 'dart:convert';

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

//Create user model

CreateUserModel createUserModelFromJson(String str) =>
    CreateUserModel.fromJson(json.decode(str));

String createUserModelToJson(CreateUserModel data) =>
    json.encode(data.toJson());

class CreateUserModel {
  CreateUserModel({
    this.memberId,
    this.memberUid,
    this.birthPlace,
    this.birthTime,
    this.regDate,
    this.firstName,
    this.lastName,
    this.middleName,
    this.surName,
    this.applicationUserUid,
    this.address,
    this.dateOfBirth,
    this.relationshipFromTheUser,
    this.nationalId,
    this.contactNumber,
    this.profileImageUrl,
    this.email,
    this.city,
    this.district,
    this.country,
    this.memberParentUid,
    this.memberRole,
    this.modifyDate,
    this.userName,
    this.photoId,
    this.photo,
  });

  int memberId;
  String memberUid;
  dynamic birthPlace;
  dynamic birthTime;
  DateTime regDate;
  String firstName;
  String lastName;
  String middleName;
  String surName;
  String applicationUserUid;
  dynamic address;
  DateTime dateOfBirth;
  int relationshipFromTheUser;
  dynamic nationalId;
  dynamic contactNumber;
  dynamic profileImageUrl;
  dynamic email;
  dynamic city;
  dynamic district;
  dynamic country;
  String memberParentUid;
  int memberRole;
  DateTime modifyDate;
  dynamic userName;
  int photoId;
  Photo photo;

  factory CreateUserModel.fromJson(Map<String, dynamic> json) =>
      CreateUserModel(
        memberId: json["memberId"],
        memberUid: json["memberUid"],
        birthPlace: json["birthPlace"],
        birthTime: json["birthTime"],
        regDate: DateTime.parse(json["regDate"]),
        firstName: json["firstName"],
        lastName: json["lastName"],
        middleName: json["middleName"],
        surName: json["surName"],
        applicationUserUid: json["applicationUserUid"],
        address: json["address"],
        dateOfBirth: DateTime.parse(json["dateOfBirth"]),
        relationshipFromTheUser: json["relationshipFromTheUser"],
        nationalId: json["nationalId"],
        contactNumber: json["contactNumber"],
        profileImageUrl: json["profileImageURL"],
        email: json["email"],
        city: json["city"],
        district: json["district"],
        country: json["country"],
        memberParentUid: json["memberParentUid"],
        memberRole: json["memberRole"],
        modifyDate: DateTime.parse(json["modifyDate"]),
        userName: json["userName"],
        photoId: json["photoId"],
        photo: Photo.fromJson(json["photo"]),
      );

  Map<String, dynamic> toJson() => {
        "memberId": memberId,
        "memberUid": memberUid,
        "birthPlace": birthPlace,
        "birthTime": birthTime,
        "regDate": regDate.toIso8601String(),
        "firstName": firstName,
        "lastName": lastName,
        "middleName": middleName,
        "surName": surName,
        "applicationUserUid": applicationUserUid,
        "address": address,
        "dateOfBirth": dateOfBirth.toIso8601String(),
        "relationshipFromTheUser": relationshipFromTheUser,
        "nationalId": nationalId,
        "contactNumber": contactNumber,
        "profileImageURL": profileImageUrl,
        "email": email,
        "city": city,
        "district": district,
        "country": country,
        "memberParentUid": memberParentUid,
        "memberRole": memberRole,
        "modifyDate": modifyDate.toIso8601String(),
        "userName": userName,
        "photoId": photoId,
        "photo": photo.toJson(),
      };
}

class Photo {
  Photo({
    this.photoId,
    this.photoUid,
    this.imageUrl,
    this.regDate,
    this.modifyDate,
    this.contentType,
    this.name,
    this.length,
    this.width,
    this.height,
    this.isDelete,
    this.isActive,
  });

  int photoId;
  String photoUid;
  String imageUrl;
  DateTime regDate;
  DateTime modifyDate;
  String contentType;
  String name;
  int length;
  int width;
  int height;
  bool isDelete;
  bool isActive;

  factory Photo.fromJson(Map<String, dynamic> json) => Photo(
        photoId: json["photoId"],
        photoUid: json["photoUid"],
        imageUrl: json["imageUrl"],
        regDate: DateTime.parse(json["regDate"]),
        modifyDate: DateTime.parse(json["modifyDate"]),
        contentType: json["contentType"],
        name: json["name"],
        length: json["length"],
        width: json["width"],
        height: json["height"],
        isDelete: json["isDelete"],
        isActive: json["isActive"],
      );

  Map<String, dynamic> toJson() => {
        "photoId": photoId,
        "photoUid": photoUid,
        "imageUrl": imageUrl,
        "regDate": regDate.toIso8601String(),
        "modifyDate": modifyDate.toIso8601String(),
        "contentType": contentType,
        "name": name,
        "length": length,
        "width": width,
        "height": height,
        "isDelete": isDelete,
        "isActive": isActive,
      };
}

//Register model

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

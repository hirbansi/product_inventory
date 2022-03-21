// To parse this JSON data, do
//
//     final userUpdateModel = userUpdateModelFromJson(jsonString);

import 'dart:convert';

UserUpdateModel userUpdateModelFromJson(String str) => UserUpdateModel.fromJson(json.decode(str));

String userUpdateModelToJson(UserUpdateModel data) => json.encode(data.toJson());

class UserUpdateModel {
  UserUpdateModel({
    this.status,
    this.message,
    this.user,
  });

  bool? status;
  String? message;
  User? user;

  factory UserUpdateModel.fromJson(Map<String, dynamic> json) => UserUpdateModel(
    status: json["status"] == null ? null : json["status"],
    message: json["message"] == null ? null : json["message"],
    user: json["user"] == null ? null : User.fromJson(json["user"]),
  );

  Map<String, dynamic> toJson() => {
    "status": status == null ? null : status,
    "message": message == null ? null : message,
    "user": user == null ? null : user!.toJson(),
  };
}

class User {
  User({
    this.id,
    this.name,
    this.email,
    this.emailVerifiedAt,
    this.image,
    this.createdAt,
    this.updatedAt,
    this.birthDate,
    this.gender,
  });

  int? id;
  String? name;
  String? email;
  dynamic emailVerifiedAt;
  dynamic image;
  DateTime? createdAt;
  DateTime? updatedAt;
  dynamic birthDate;
  dynamic gender;

  factory User.fromJson(Map<String, dynamic> json) => User(
    id: json["id"] == null ? null : json["id"],
    name: json["name"] == null ? null : json["name"],
    email: json["email"] == null ? null : json["email"],
    emailVerifiedAt: json["email_verified_at"],
    image: json["image"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
    birthDate: json["birth_date"],
    gender: json["gender"],
  );

  Map<String, dynamic> toJson() => {
    "id": id == null ? null : id,
    "name": name == null ? null : name,
    "email": email == null ? null : email,
    "email_verified_at": emailVerifiedAt,
    "image": image,
    "created_at": createdAt == null ? null : createdAt!.toIso8601String(),
    "updated_at": updatedAt == null ? null : updatedAt!.toIso8601String(),
    "birth_date": birthDate,
    "gender": gender,
  };
}

// To parse this JSON data, do
//
//     final registerModel = registerModelFromJson(jsonString);

import 'dart:convert';

RegisterModel registerModelFromJson(String str) => RegisterModel.fromJson(json.decode(str));

String registerModelToJson(RegisterModel data) => json.encode(data.toJson());

class RegisterModel {
  RegisterModel({
    this.status,
    this.message,
    this.data,
    this.token,
  });

  bool? status;
  String? message;
  Data? data;
  String? token;

  factory RegisterModel.fromJson(Map<String, dynamic> json) => RegisterModel(
    status: json["status"] == null ? null : json["status"],
    message: json["message"] == null ? null : json["message"],
    data: json["data"] == null ? null : Data.fromJson(json["data"]),
    token: json["token"] == null ? null : json["token"],
  );

  Map<String, dynamic> toJson() => {
    "status": status == null ? null : status,
    "message": message == null ? null : message,
    "data": data == null ? null : data!.toJson(),
    "token": token == null ? null : token,
  };
}

class Data {
  Data({
    this.name,
    this.email,
    this.gender,
    this.image,
    this.birthDate,
    this.updatedAt,
    this.createdAt,
    this.id,
    this.password,
    this.password_confirmation
  });

  String? name;
  String? email;
  String? gender;
  String? image;
  DateTime? birthDate;
  DateTime? updatedAt;
  DateTime? createdAt;
  int? id;
  String? password;
  String? password_confirmation;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    name: json["name"] == null ? null : json["name"],
    email: json["email"] == null ? null : json["email"],
    gender: json["gender"] == null ? null : json["gender"],
    password:json["password"] == null?null:json["password"],
    password_confirmation:json["password_confirmation"]==null?null:json["password_confirmation"],
    image: json["image"] == null ? null : json["image"],
    birthDate: json["birth_date"] == null ? null : DateTime.parse(json["birth_date"]),
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    id: json["id"] == null ? null : json["id"],
  );

  Map<String, dynamic> toJson() => {
    "name": name == null ? null : name,
    "email": email == null ? null : email,
    "gender": gender == null ? null : gender,
    "image": image == null ? null : image,
    "password":password==null?null:password,
    "password_confirmation":password_confirmation==null?null:password_confirmation,
    "birth_date": birthDate == null ? null : "${birthDate!.year.toString().padLeft(4, '0')}-${birthDate!.month.toString().padLeft(2, '0')}-${birthDate!.day.toString().padLeft(2, '0')}",
    "updated_at": updatedAt == null ? null : updatedAt!.toIso8601String(),
    "created_at": createdAt == null ? null : createdAt!.toIso8601String(),
    "id": id == null ? null : id,
  };
}

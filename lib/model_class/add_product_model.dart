// To parse this JSON data, do
//
//     final addProductModel = addProductModelFromJson(jsonString);

import 'dart:convert';

import 'dart:io';

AddProductModel addProductModelFromJson(String str) => AddProductModel.fromJson(json.decode(str));

String addProductModelToJson(AddProductModel data) => json.encode(data.toJson());

class AddProductModel {
  AddProductModel({
    this.status,
    this.message,
    this.data,
  });

  int? status;
  String? message;
  AddData? data;

  factory AddProductModel.fromJson(Map<String, dynamic> json) => AddProductModel(
    status: json["status"] == null ? null : json["status"],
    message: json["message"] == null ? null : json["message"],
    data: json["data"] == null ? null : AddData.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "status": status == null ? null : status,
    "message": message == null ? null : message,
    "data": data == null ? null : data!.toJson(),
  };
}

class AddData {
  AddData({
    this.name,
    this.mrp,
    this.selling,
    this.description,
    this.image,
    this.updatedAt,
    this.createdAt,
    this.id,
    this.img,
  });

  String? name;
  String? mrp;
  String? selling;
  String? description;
  File? image;
  DateTime? updatedAt;
  DateTime? createdAt;
  int? id;
  String? img;

  factory AddData.fromJson(Map<String, dynamic> json) => AddData(
    name: json["name"] == null ? null : json["name"],
    mrp: json["mrp"] == null ? null : json["mrp"],
    selling: json["selling"] == null ? null : json["selling"],
    description: json["description"] == null ? null : json["description"],
    //image: json["image"] == null ? null : json["image"],
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    id: json["id"] == null ? null : json["id"],
    img: json["img"] == null ? null : json["img"],
  );

  Map<String, dynamic> toJson() => {
    "name": name == null ? null : name,
    "mrp": mrp == null ? null : mrp,
    "selling": selling == null ? null : selling,
    "description": description == null ? null : description,
   // "image": image == null ? null : image,
    "updated_at": updatedAt == null ? null : updatedAt!.toIso8601String(),
    "created_at": createdAt == null ? null : createdAt!.toIso8601String(),
    "id": id == null ? null : id,
    "img": img == null ? null : img,
  };
}

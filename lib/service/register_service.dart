import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:incdnc/app_string/pref.dart';
import 'package:incdnc/model_class/add_product_model.dart';
import 'package:incdnc/model_class/list_product.dart';
import 'package:incdnc/model_class/profile_update.dart';
import 'package:incdnc/model_class/register_modelclass.dart';
import 'package:incdnc/model_class/user_login_model.dart';
import 'package:incdnc/model_class/user_profile_model.dart';
import 'package:incdnc/service/app_interceptors.dart';

abstract class AlbumService {
  Future<RegisterModel> createUser();

  Future<UserLoginModel> userLogin();

  Future<UserProfileModel> userProfile();

  Future<ProductListModel> productList();

  Future<UserUpdateModel> updateUser();

  Future<ProductListModel> addProduct();
  Future<void> deleteProduct();
   Future<ProductListModel> dataAdded();
}

class RegisterApi extends AlbumService {
  var dio = Dio();
  @override
  Future<RegisterModel> createUser({RegisterModel? model}) async {
    var url = 'https://139.59.79.228/flutter-api/public/api/register';
    final res = await dio.post(url, data: jsonEncode(model!.data));
    if (res.statusCode == 200) {
      var user = RegisterModel.fromJson(res.data);
        print(res.data);
      return user;
    } else {
      throw Exception('${res.statusCode}===>${res.statusMessage}');
    }
  }

  @override
  Future<UserLoginModel> userLogin({UserLoginModel? userLoginModel}) async {
      var url = 'https://139.59.79.228/flutter-api/public/api/login';
      final res = await dio.post(url, data: jsonEncode(userLoginModel!.user));
      if (res.statusCode == 200) {
        var userLoginData = UserLoginModel.fromJson(res.data);
          print(res.data);

        return userLoginData;
      } else {
        throw Exception('Enter Valide====>');
      }
  }

  @override
  Future<UserProfileModel> userProfile() async {
    String? token;
    token = await AppPreference.getString('token');
    var url = 'https://139.59.79.228/flutter-api/public/api/getUserProfile';
    final res = await dio.get(url,
        options: Options(
          headers: {"Authorization": "Bearer $token"},
        ));

      print(token);

    if (res.statusCode == 200) {
      var user = UserProfileModel.fromJson(res.data);
      return user;
    } else {

        print('${res.statusCode}:${res.data.toString()}');

      throw Exception('Exception ===>${res.statusCode}');
    }
  }
  @override
  Future<ProductListModel> productList({int? page}) async {
    try{
      String? token;
      token = await AppPreference.getString('token');
      var url = 'https://139.59.79.228/flutter-api/public/api/products?page=$page';
      final res = await dio.get(url,
          options: Options(
            headers: {"Authorization": "Bearer $token"},
          ));
        print(token);

      if (res.statusCode == 200) {
        var lst = ProductListModel.fromJson(res.data);

          print(lst.data);

        return lst;
      } else {

          print('${res.statusCode}:${res.data.toString()}');
           throw Exception("UnHandle==>Exception${res.statusCode}");
      }
    }on SocketException catch(e){
      throw SocketException(e.message);
    }on NoInternetConnectionException catch(e){
      throw NoInternetConnectionException(e.requestOptions,);
    }
  }


  @override
  Future<UserUpdateModel> updateUser(
      {UserUpdateModel? userUpdateModel, int? id}) async {
    String token;
    token = await AppPreference.getString("token");
    var url = "https://139.59.79.228/flutter-api/public/api/profileUpdate/$id";
    var res = await dio.post(url,
        data:jsonEncode(userUpdateModel!.user),
        options: Options( headers: {"Authorization": "Bearer $token"},));
         print(res.statusCode);

    if (res.statusCode == 200) {
      var userUpdateData = UserUpdateModel.fromJson(res.data);

        print(res.data);

      return userUpdateData;
    } else {
      throw Exception(AppInterceptors(statusCode: res.statusCode));
    }
  }

  @override
  Future<ProductListModel> addProduct({AddProductModel? addproductModel,int? lastPage}) async {
    FormData formData = FormData.fromMap({
      'name':addproductModel!.data!.name,
      'mrp':addproductModel.data!.mrp,
      'selling':addproductModel.data!.selling,
      'description':addproductModel.data!.description,
      "image":await MultipartFile.fromFile(
    addproductModel.data!.image!.path,filename: 'gjdjkg',
    ),
    });
    String token;
    token = await AppPreference.getString("token");
    var url = "https://139.59.79.228/flutter-api/public/api/products";
    var res = await dio.post(url,
        data:formData,
        options: Options( headers: {"Authorization": "Bearer $token"},
        contentType:"multipart/form-data"));
      print(res.statusCode);

    if (res.statusCode == 200) {
      ProductListModel productListModel= await dataAdded(lastpage: lastPage);
        print(res.data);
      return productListModel ;
    } else {
      throw Exception("Error======>${res.statusMessage}&&${res.statusCode}");
    }
  }

  @override
  Future<void> deleteProduct({int? deleteId})async{
    var url = "https://139.59.79.228/flutter-api/public/api/products/$deleteId";
    String token ;
    token = await AppPreference.getString('token');
    await dio.delete(url,options: Options(headers: {"Authorization":"Bearer $token"}));
  }

  @override
Future<ProductListModel> dataAdded({int? lastpage})async{
    try{
      String? token;
      token = await AppPreference.getString('token');
      var url = 'https://139.59.79.228/flutter-api/public/api/products?page=$lastpage';
      final res = await dio.get(url,
          options: Options(
            headers: {"Authorization": "Bearer $token"},
          ));
      print(token);

      if (res.statusCode == 200) {
        var lst = ProductListModel.fromJson(res.data);

        print(lst.data);

        return lst;
      } else {

        print('${res.statusCode}:${res.data.toString()}');
        throw Exception("UnHandle==>Exception${res.statusCode}");
      }
    }on SocketException catch(e){
      throw SocketException(e.message);
    }on NoInternetConnectionException catch(e){
      throw NoInternetConnectionException(e.requestOptions,);
    }
  }

}

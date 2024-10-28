

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:shopping_app/product/global/global_model/global_item_model.dart';
import 'package:shopping_app/product/global/service/IItemservice.dart';

class ItemService implements IItemService {
  final Dio _dio;

  ItemService._init()
      : _dio = Dio(BaseOptions(baseUrl: 'https://fakestoreapi.com'));

  static final ItemService _instance = ItemService._init();
  static ItemService get instance => _instance;

  @override
  Future<List<GlobalItemModel>?> getItems() async {
    try {
      final response = await _dio.get("/products");

      if (response.statusCode == 200) {
        final datas = response.data;
        if (datas is List) {
          return datas.map((e) => GlobalItemModel.fromJson(e)).toList();
        }
      }
    } on DioException catch (exception) {
      _ShowDebug.showDioError(exception);
    }
    return null ;
  }
}


class _ShowDebug{
 static void showDioError(DioException error){
    if(kDebugMode){
      print(error.message);
    }
  }
}


















/*
import 'dart:collection';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:service_s/service2/post_model.dart';
import '../service2/post_model.dart';


abstract class IPostService{
  Future<bool> addItemToService(PostModel postModel);
  Future<bool> updateItemToService(PostModel postModel, int id);
  Future<bool> deleteItemToService(int id);
  Future<List<PostModel>?> fetchPostItemAdvance();
}

// bu metotları sadece insanalar bu interface üzerinden erişssin kafasına göre erişmesin.
// ya da bu metotları bilsin bunlara göre işlem yapsın.



class PostService implements IPostService{
  final Dio _dio;
  PostService()
      : _dio =
            Dio(BaseOptions(baseUrl: "https://jsonplaceholder.typicode.com/"));

  @override
  Future<bool> addItemToService(PostModel postModel) async {
    // toJsona girecek
    try {
      final response =
          await _dio.post(_PostServicePaths.post.name, data: postModel);

      return response.statusCode == HttpStatus.created;
    } on DioException catch  (exception) {
      _ShowDebug.showDioError(exception);
    }
    return false;
  }

    @override
      Future<bool> updateItemToService(PostModel postModel, int id) async {
    // toJsona girecek
    try {
      final response =
          await _dio.put('${_PostServicePaths.post.name}/$id', data: postModel);

      return response.statusCode == HttpStatus.created;
    } on DioException catch  (exception) {
      _ShowDebug.showDioError(exception);
    }
    return false;
  }

    @override
      Future<bool> deleteItemToService(int id) async {
    // toJsona girecek
    try {
      final response =
          await _dio.put('${_PostServicePaths.post.name}/$id');

      return response.statusCode == HttpStatus.created;
    } on DioException catch  (exception) {
      _ShowDebug.showDioError(exception);
    }
    return false;
  }


  @override
  Future<List<PostModel>?> fetchPostItemAdvance() async {
    try {
      final response = await Dio().get("/posts");
      if (response.statusCode == HttpStatus.ok) {
        final datas = response.data;

        if (datas is List) {
          return datas.map((e) => PostModel.fromJson(e)).toList();
        }
      }
    } on DioException catch (exception) {
      _ShowDebug.showDioError(exception);
    }
    return null;
  }
}
// 200 kısmında try catch leri yazalım.
// test edilebilir kod mantığı

enum _PostServicePaths { post, comments }

class _ShowDebug{
 static void showDioError(DioException error){
    if(kDebugMode){
      print(error.message);
    }
  }
}


 */
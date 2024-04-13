import 'dart:convert';

import 'package:dio/dio.dart';

import 'cache_helper.dart';
class ApiServices{
  final baseUrl= 'https://flutter.prominaagency.com/api/my-gallery';
    final Dio dio ;
   ApiServices(this.dio);
  Future<Map<String, dynamic>> getImages() async {
    try {
      var response = await dio.get(
        baseUrl,
        options: Options(
          headers: {"Authorization": "Bearer ${CacheHelper.getToken()}"},
        ),
      );


      if (response.statusCode == 200) {
        Map<String, dynamic> images = Map<String, dynamic>.from(response.data);
        return images;
      } else {
        throw Exception('Failed to load images');
      }
    } catch (e) {
      throw Exception('Failed to load images');
    }
  }

}
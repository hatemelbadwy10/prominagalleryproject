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

      print('++++++ REQUEST SENT ++++++');

      if (response.statusCode == 200) {
        print(response.data);
        Map<String, dynamic> images = Map<String, dynamic>.from(response.data);
        return images;
      } else {
        print('Request failed with status: ${response.statusCode}');
        throw Exception('Failed to load images');
      }
    } catch (e) {
      print('Error fetching images: $e');
      throw Exception('Failed to load images');
    }
  }

}
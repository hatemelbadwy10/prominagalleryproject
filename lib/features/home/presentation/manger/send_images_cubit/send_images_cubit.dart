import 'dart:io';
import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/utils/cache_helper.dart';
import '../../../data/models/image_model.dart';
part 'send_images_state.dart';

class ImageUploadCubit extends Cubit<SendImagesState> {
  final Dio _dio = Dio();

  ImageUploadCubit() : super(SendImagesInitial());

  Future<void> uploadImage(File imageFile) async {
    emit(SendImagesLoading()); // Reset the upload status
    try {
      final ImageUploadRequest uploadRequest = ImageUploadRequest(imageFile);
      final FormData formData = uploadRequest.toFormData();

      final response = await _dio.post(
        'https://flutter.prominaagency.com/api/upload',
        data: formData,
        options: Options(
          headers: {"Authorization": "Bearer ${CacheHelper.getToken()}"},
        ),
      );

      if (response.statusCode == 200) {
        print(response.statusCode);
        emit(SendImagesSuccess()); // Image upload successful
      } else {
        emit(SendImagesFailure('eror message in api')); // Image upload failed
      }
    } catch (e) {
      emit(SendImagesFailure('error message in code')); // Image upload failed
      print('Error uploading image: $e');
    }
  }
}
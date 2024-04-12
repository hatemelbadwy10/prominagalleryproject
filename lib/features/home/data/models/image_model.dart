import 'dart:io';
import 'package:dio/dio.dart';

class ImageUploadRequest {
  final File imageFile;

  ImageUploadRequest(this.imageFile);

  FormData toFormData() {
    return FormData.fromMap({
      'img': MultipartFile.fromFileSync(imageFile.path, filename: imageFile.path.split('/').last),
    });
  }
}
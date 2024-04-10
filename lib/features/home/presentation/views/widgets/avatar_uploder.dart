import 'dart:io';

import 'package:flutter/cupertino.dart';

import '../../../../../core/utils/media_handler.dart';
import '../../../../../core/utils/service_locator.dart';
import 'avatar_container.dart';
import 'home_view_body.dart';
import 'image_picker_widget.dart';

class AvatarUploader extends StatefulWidget {
  const AvatarUploader({super.key});

  @override
  _AvatarUploaderState createState() => _AvatarUploaderState();
}

class _AvatarUploaderState extends State<AvatarUploader> {
  final MediaServiceInterface _mediaService = getIt<MediaServiceInterface>();

  File? imageFile;
  bool _isLoadingGettingImage = false;

  Future<AppImageSource?> pickImageSource() async {
    AppImageSource? appImageSource = await showCupertinoModalPopup(
      context: context,
      builder: (BuildContext context) => const ImagePickerActionSheet(),
    );
    if (appImageSource != null) {
      _getImage(appImageSource);
    }
    return null;
  }

  Future _getImage(AppImageSource _appImageSource) async {
    setState(() => _isLoadingGettingImage = true);
    final pickedImageFile = await _mediaService.uploadImage(context, _appImageSource);
    setState(() => _isLoadingGettingImage = false);

    if (pickedImageFile != null) {
      setState(() => imageFile = pickedImageFile);
    }
  }

  @override
  Widget build(BuildContext context) {
    return AvatarContainer(
      isLoading: _isLoadingGettingImage,
      onTap: pickImageSource,
      imageFile: imageFile,
    );
  }
}
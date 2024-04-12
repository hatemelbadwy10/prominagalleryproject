import 'dart:io';
import 'dart:ui';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../constants.dart';
import '../../../../../core/utils/assets.dart';
import '../../../../../core/utils/styles.dart';
import '../../manger/send_images_cubit/send_images_cubit.dart';
import 'package:image_picker/image_picker.dart';
class ImagePickerActionSheet extends StatelessWidget {
  const ImagePickerActionSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ImageUploadCubit(),
      child: AlertDialog(
        contentPadding: EdgeInsets.zero,
        backgroundColor: Colors.white70.withOpacity(0.2),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(25.0), // Custom border radius
        ),
        content: ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
            child: Container(
              width: 320.w,
              height: 300.h,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(width: 0.5, color: Colors.white70)),
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 50.0),
                child: Column(
                  children: [
                    BlocConsumer<ImageUploadCubit, SendImagesState>(
                      listener: (context, state) {
                        if (state is SendImagesSuccess) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                                content: Text('Image uploaded successfully')),
                          );
                        } else if (state is SendImagesFailure) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                                content: Text('Failed to upload image')),
                          );
                        }
                      },
                      builder: (context, state) {
                        return state is SendImagesLoading
                            ? const CircularProgressIndicator()
                            : PickUpButton(
                                text: '   Gallery',
                                image: AssetsData.gallery,
                                color: firstContainerColor,
                                onTap: () async {
                                  final XFile? imageFile = await ImagePicker()
                                      .pickImage(source: ImageSource.gallery);
                                  if (imageFile != null) {
                                    context
                                        .read<ImageUploadCubit>()
                                        .uploadImage(File(imageFile.path));
                                  }
                                },
                              );
                      },
                    ),
                    SizedBox(
                      height: 44.h,
                    ),
                    BlocConsumer<ImageUploadCubit, SendImagesState>(
                      listener: (context, state) {
                        if (state is SendImagesSuccess) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                                content: Text('Image uploaded successfully')),
                          );
                        } else if (state is SendImagesFailure) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                                content: Text('Failed to upload image')),
                          );
                        }
                      },
                      builder: (context, state) {
                        return state is SendImagesLoading
                            ? const CircularProgressIndicator()
                            : PickUpButton(
                                text: 'Camera',
                                image: AssetsData.camera,
                                color: secContainerColor,
                                onTap: () async{
                                  final XFile? imageFile = await ImagePicker()
                                      .pickImage(source: ImageSource.camera);
                                  if (imageFile != null) {
                                    context
                                        .read<ImageUploadCubit>()
                                        .uploadImage(File(imageFile.path));
                                  }
                                },
                              );
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

// Future<File?> pickImage() {
//   // Implement your logic to pick an image from gallery
//   return Future.value(null); // Replace this with actual image picking logic
// }
}

class PickUpButton extends StatelessWidget {
  const PickUpButton({
    super.key,
    required this.text,
    required this.image,
    required this.color,
    required this.onTap,
  });

  final String text;
  final String image;
  final Color color;
  final void Function() onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 65.h,
        width: 250.w,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(25), color: color),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Row(
            children: [
              Image.asset(image),
              SizedBox(
                width: 6.5.w,
              ),
              Text(
                text,
                style: Styles.textStyle27,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

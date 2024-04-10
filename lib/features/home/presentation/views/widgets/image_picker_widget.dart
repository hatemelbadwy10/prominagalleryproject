import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../constants.dart';
import '../../../../../core/utils/assets.dart';
import '../../../../../core/utils/media_handler.dart';
import '../../../../../core/utils/styles.dart';
class ImagePickerActionSheet extends StatelessWidget {
  const ImagePickerActionSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.white.withOpacity(.8),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(25.0), // Custom border radius
      ),
      content: SizedBox(
        width: 300.w,
        height: 300.h,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 50.0),
          child: Column(
            children: [
              PickUpButton(
                text: '   Gallery',
                image: AssetsData.gallery,
                color: firstContainerColor,
                onTap: () {
                  Navigator.of(context).pop(AppImageSource.gallery);
                },
              ),
              SizedBox(
                height: 44.h,
              ),
              PickUpButton(
                text: 'Camera',
                image: AssetsData.camera,
                color: secContainerColor,
                onTap: () {
                  Navigator.of(context).pop(AppImageSource.camera);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
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

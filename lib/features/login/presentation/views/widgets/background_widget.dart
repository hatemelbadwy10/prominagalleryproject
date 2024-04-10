import 'package:flutter/material.dart';
import 'package:prominaagencygalleryproject/core/utils/assets.dart';
class BackgroundWidget extends StatelessWidget {
  const BackgroundWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        image:DecorationImage( image:
            AssetImage(
                AssetsData.background
            ),
        fit:BoxFit.fill
        )
      ),
    );
  }
}

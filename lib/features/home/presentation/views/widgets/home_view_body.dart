import 'dart:io';
import 'dart:ui';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/utils/assets.dart';
import '../../../../../core/utils/cache_helper.dart';
import '../../../../../core/utils/media_handler.dart';

import '../../../../../core/utils/service_locator.dart';
import '../../../../login/presentation/views/login_view.dart';
import '../../manger/get_images_cubit/get_images_cubit.dart';
import 'image_picker_widget.dart';

class HomeViewBody extends StatefulWidget {
  const HomeViewBody({super.key});

  @override
  State<HomeViewBody> createState() => _HomeViewBodyState();
}

class _HomeViewBodyState extends State<HomeViewBody> {

  final MediaServiceInterface _mediaService = getIt<MediaServiceInterface>();
  File? imageFile;

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

  Future _getImage(AppImageSource appImageSource) async {
    final pickedImageFile =
    await _mediaService.uploadImage(context, appImageSource);

    if (pickedImageFile != null) {
      setState(() => imageFile = pickedImageFile );

    }
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    BlocProvider.of<GetImagesCubit>(context).fetchImages();

  }


  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: BlocBuilder<GetImagesCubit, GetImagesState>(
        builder: (context, state) {
          if(state is GetImagesLoading){
            return const Center(child: CircularProgressIndicator());


          }
          else if(state is GetImagesSuccess){
            return RefreshIndicator(
              onRefresh: () async{
                await BlocProvider.of<GetImagesCubit>(context).fetchImages();
              },
              child: Scaffold(
                body: Container(
                  width: double.infinity,
                  decoration: const BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage(
                            AssetsData.background2,
                          ),
                          fit: BoxFit.fill)),
                  child: Stack(
                    children: [
                      BackdropFilter(
                        filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
                        child: ClipPath(
                          clipper: WaveClipper(),
                          child: Center(
                            child: Container(
                              height: MediaQuery.of(context).size.height,
                              width: MediaQuery.of(context).size.width,
                              decoration:  BoxDecoration(
                                color: Colors.transparent.withOpacity(0.1),
                              ),
                              //MediaQuery.of(context).size.height,
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        top: 15.h,
                        right: 27.w,
                        child: const CircleAvatar(
                          maxRadius: 22,
                          backgroundImage: AssetImage(AssetsData.profile),
                          //child: Image.asset('assets/slider3.jpg'),
                        ),
                      ),
                      Positioned(
                          left: 20.w,
                          top: 25.h,
                          child: const Text(
                            'Welcome\nMina',
                            style: TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.w400,
                                color: Colors.black),
                            textAlign: TextAlign.left,
                          )),
                      Positioned(
                        top: 120.h,
                        left: 40.w,
                        child: CustomButton(
                          icon: Icons.arrow_back,
                          iconColor: Colors.red,
                          text: 'Log out',
                          onPressed: () {
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const LoginView(),
                              ),);
                            CacheHelper.removeLoginData();
                          },
                          blurColor: Colors.red,
                        ),
                      ),
                      Positioned(
                        top: 120.h,
                        right: 40.w,
                        child: CustomButton(
                          icon: Icons.arrow_upward,
                          iconColor: Colors.orangeAccent,
                          text: 'upLoad',
                          onPressed: () {
                            pickImageSource();
                          },
                          blurColor: Colors.orangeAccent,
                        ),
                      ),
                      Positioned(
                        top: 200.h,
                        right: 30.w,
                        left: 30.w,
                        child: SizedBox(
                          width: MediaQuery.of(context).size.width,
                          height: 680.h,
                          child: GridView.builder(
                              gridDelegate:
                              const SliverGridDelegateWithMaxCrossAxisExtent(
                                  mainAxisSpacing: 10,
                                  maxCrossAxisExtent: 120,
                                  childAspectRatio: 3 / 3,
                                  crossAxisSpacing: 20),
                              itemCount: state.imagesModel.data.images.length,
                              itemBuilder: (_, index) => Container(
                                decoration: BoxDecoration(
                                  boxShadow: const [
                                    BoxShadow(
                                      color: Colors.black26,
                                      offset: Offset(0.0, 1.0), //(x,y)
                                      blurRadius: 6.0,
                                    ),
                                  ],
                                  borderRadius: BorderRadius.circular(20),
                                  color: Colors.orangeAccent,
                                  image: DecorationImage(
                                    image: NetworkImage(
                                      state.imagesModel.data.images[index],), fit: BoxFit.fill,),

                                ),

                                // child:Expanded(child: Image.network( state.imagesModel.data.images[index],fit: BoxFit.values[4],)) ,
                              )),
                        ),

                      ),

                    ],
                  ),
                ),
              ),
            );


          }
          else  {
            return const Text('failed');
          }

        },
      ),
    );
  }
}

class WaveClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    path.lineTo(0, size.height);
    path.lineTo(size.width, size.height);
    path.lineTo(size.width, size.height - 780.h);
    path.quadraticBezierTo(size.width * 0.97, size.height - 809.h,
        size.width * 0.90, size.height - 803.h);
    path.quadraticBezierTo(size.width * 0.75, size.height - 790.h,
        size.width * 0.75, size.height - 860.h);
    path.quadraticBezierTo(size.width * 0.75, size.height - 880.h,
        size.width * 0.72, size.height - 900.h);
    path.lineTo(0.6, size.height-900);
    //path.quadraticBezierTo(size.width*0.6, size.height-710, size.width*0.59, size.height-730);
    // path.cubicTo(size.height, size.width, size.height, size.width, size.height, size.width);

    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper oldClipper) {
    // TODO: implement shouldReclip
    return true;
  }
}

class CustomButton extends StatelessWidget {
  const CustomButton({
    required this.blurColor,
    required this.text,
    required this.onPressed,
    required this.icon,
    required this.iconColor,
    super.key,
  });
  final String text;
  final void Function() onPressed;
  final IconData icon;
  final Color iconColor;
  final Color blurColor;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
          shape:
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)), backgroundColor: Colors.white),
      child: Row(
        //mainAxisAlignment: MainAxisAlignment,
        children: [
          Container(
            width: 25,
            height: 25,
            decoration: BoxDecoration(
                color: iconColor,
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                      color: blurColor.withOpacity(0.8),
                      blurRadius: 5,
                      offset: const Offset(-3, 1))
                ]),
            child: Icon(
              icon,
              size: 20,color: Colors.white,
            ),
          ),
          const SizedBox(
            width: 15,
          ),
          Text(
            text,
            style: const TextStyle(color: Colors.black),
          )
        ],
      ),
    );
  }
}
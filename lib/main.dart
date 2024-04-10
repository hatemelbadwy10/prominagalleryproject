import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:prominaagencygalleryproject/core/utils/themes.dart';
import 'package:prominaagencygalleryproject/features/home/presentation/views/home_view.dart';

import 'core/utils/cache_helper.dart';
import 'core/utils/service_locator.dart';
import 'features/login/presentation/views/login_view.dart';

void main()  async{
  WidgetsFlutterBinding.ensureInitialized();
  setupServiceLocator();
  CacheHelper.init();
  bool isFirstTime = await CacheHelper.checkFirstSeen();

  runApp( GalleryApp(isFirstTime: isFirstTime));
}

class GalleryApp extends StatelessWidget {
  final bool isFirstTime;
  const GalleryApp({super.key, required this.isFirstTime});
  @override
  Widget build(BuildContext context) {
  print('====================');
  print(CacheHelper.getToken().toString() );
  print('====================');
  return  ScreenUtilInit(
    designSize: const Size(463, 926),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: theme(context),
        home: isFirstTime ? const LoginView() : const HomeView(),
      ));
  }




}

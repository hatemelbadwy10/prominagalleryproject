import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:prominaagencygalleryproject/core/utils/themes.dart';
import 'package:prominaagencygalleryproject/core/utils/cache_helper.dart';
import 'package:prominaagencygalleryproject/features/home/presentation/views/home_view.dart';
import 'package:prominaagencygalleryproject/features/login/presentation/views/login_view.dart';

import 'core/utils/service_locator.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  setupServiceLocator();
  await CacheHelper.init();


  runApp(const GalleryApp());
}

class GalleryApp extends StatelessWidget {

  const GalleryApp({super.key, });

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(463, 926),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: theme(context),
        // Check if the user has logged out, if so, show the login view
        // Otherwise, show the appropriate view based on the login status
        home: CacheHelper.getToken().isNotEmpty? const HomeView(): const LoginView(),
      ),
    );
  }
}

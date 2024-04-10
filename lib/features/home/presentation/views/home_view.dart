import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:prominaagencygalleryproject/core/utils/api_services.dart';
import 'package:prominaagencygalleryproject/features/home/presentation/manger/get_images_cubit/get_images_cubit.dart';
import 'package:prominaagencygalleryproject/features/home/presentation/views/widgets/home_view_body.dart';
class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
      return BlocProvider(
        create: (BuildContext context) {
          return GetImagesCubit(ApiServices(Dio()));
        },
        child: const Scaffold(
          body: HomeViewBody(),
        ),
      );
  }
}

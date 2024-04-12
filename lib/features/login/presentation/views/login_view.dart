import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:prominaagencygalleryproject/features/login/presentation/views/widgets/login_view_body.dart';

import '../manger/auth_cubit.dart';
class LoginView extends StatelessWidget {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(

      create: (BuildContext context) {
        return AuthCubit();
      },
      child: const Scaffold(
        // resizeToAvoidBottomInset: false,

        body: LoginViewBody(),
      ),
    );
  }
}

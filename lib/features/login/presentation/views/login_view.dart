import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:prominaagencygalleryproject/features/login/manger/auth_cubit.dart';
import 'package:prominaagencygalleryproject/features/login/presentation/views/widgets/login_view_body.dart';
class LoginView extends StatelessWidget {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(

      create: (BuildContext context) {
        return AuthCubit();
      },
      child: const Scaffold(
        resizeToAvoidBottomInset: false,

        body: LoginViewBody(),
      ),
    );
  }
}

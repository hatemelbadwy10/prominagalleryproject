import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:prominaagencygalleryproject/core/utils/styles.dart';
import 'package:prominaagencygalleryproject/features/home/presentation/views/home_view.dart';
import 'package:prominaagencygalleryproject/features/login/manger/auth_cubit.dart';
import 'package:prominaagencygalleryproject/features/login/presentation/views/widgets/custom_button.dart';

import '../../../../../core/utils/assets.dart';
import 'custom_text_field.dart';

class LoginViewBody extends StatefulWidget {
  const LoginViewBody({super.key});

  @override
  State<LoginViewBody> createState() => _LoginViewBodyState();
}

class _LoginViewBodyState extends State<LoginViewBody> {
  final _form = GlobalKey<FormState>();
final TextEditingController _emailController =TextEditingController();
  final TextEditingController _passwordController =TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthCubit, AuthState>(
      listener: (context, state) {
        if(state is AuthAuthenticated){
          Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const HomeView()));
        }else if (state is AuthError) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(state.message)));

        }
        // TODO: implement listener
        },
      builder: (context, state) {
        return state is AuthLoading?
          const Center(child: CircularProgressIndicator(),):
         Container(
          width: MediaQuery
              .sizeOf(context)
              .width,
          decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage(AssetsData.background), fit: BoxFit.fill)),
          child: Padding(
            padding: EdgeInsets.only(top: 180.h),
            child: Form(
              key: _form,
              child: Column(
                children: [
                  Text(
                    'My\nGallery',
                    style: Styles.textStyle50,
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(
                    height: 40.h,
                  ),
                  ClipRRect(
                    borderRadius: const BorderRadius.all(Radius.circular(25)),
                    child: BackdropFilter(

                      filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
                      child: Container(
                        height: 460.h,
                        width: 388.w,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(25),
                          color: Colors.white.withOpacity(.7),
                        ),
                        child: Padding(
                          padding: EdgeInsets.symmetric(vertical: 48.h),
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 30.w),
                            child: Column(
                              children: [
                                Text(
                                  'LOG IN',
                                  style: Styles.textStyle30,
                                ),
                                SizedBox(height: 38.h),
                                 CustomTextField(
                                  hint: 'User Name',
                                  validatorWord: 'user name', textEditingController: _emailController,
                                ),
                                SizedBox(height: 38.h,),
                                 CustomTextField(
                                  hint: 'PassWord',
                                  validatorWord: 'Password',
                                  obscureText: true, textEditingController: _passwordController,
                                ),
                                SizedBox(height: 30.h,),
                                CustomButton(onPress: () {
                                  if (_form.currentState?.validate() == true) {
                                    String email = _emailController.text.trim();
                                    String password = _passwordController.text.trim();
                                    context.read<AuthCubit>().login(email,password,context);

                                  }
                                })

                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

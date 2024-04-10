
import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../core/utils/cache_helper.dart';
import '../../home/presentation/views/home_view.dart';
import '../models/login_model.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthInitial());
  final String baseUrl = "https://flutter.prominaagency.com/api";

  // final ServicesAuth _authService = ServicesAuth();
  Dio dio=Dio();
  Future <void>login(String email,String password,BuildContext context)async{
    try{
      emit(AuthLoading());
      final logInModel=LogInModel(email: email, password: password);
      Response response=await dio.post('$baseUrl/auth/login',data: logInModel.tojson());
      if(response.statusCode==200){
        final token = response.data['token'];
        await CacheHelper.markAsNotFirstSeen();
        CacheHelper.setToken(token);
        print('.....................................${token}');
        emit(AuthAuthenticated());
      }else {emit(AuthError('Login faild code is up to 200'));}
    }catch (e){
      emit(AuthError('an error in code in please try again'));
    }
  }
}

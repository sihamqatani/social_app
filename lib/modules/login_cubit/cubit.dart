import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/modules/login_cubit/state.dart';

class SocialLoginCubit extends Cubit<SocialLoginState> {
  SocialLoginCubit() : super(SocialLoginInitialState());
  static SocialLoginCubit get(context) => BlocProvider.of(context);
  //late ShopUserModel shopUserModel;

  void userLogin({required String email, required String password}) {
    emit(SocialLoginloadingState());
    FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: password)
        .then((value) {
      print(value.user?.email);
      emit(SocialLoginSuccessState( uId: value.user!.uid));
    }).catchError((error) {
      print('error of login${error.toString()}');
      emit(SocialLoginErrorState(error: error));
    });
  }

  IconData iconVisiblity = Icons.visibility;
  bool isPasword = true;
  void changPasswordVisibilty() {
    isPasword = !isPasword;
    iconVisiblity =
        isPasword ? Icons.visibility_off_outlined : Icons.visibility;
    emit(SocialLoginPasswordVisibilitysState());
  }
}

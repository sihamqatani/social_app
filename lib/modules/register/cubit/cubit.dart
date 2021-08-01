import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/models/social_user_model.dart';
import 'package:social_app/modules/register/cubit/state.dart';

class SocialRegisterCubit extends Cubit<SocialRegisterStates> {
  SocialRegisterCubit() : super(SocialRegisterInitialState());
  static SocialRegisterCubit get(context) => BlocProvider.of(context);
  //late ShopUserModel shopUserModel;

  void userRegister(
      {required String email,
      required String password,
      required String name,
      required String phone}) {
    print('hell2');
    emit(SocialRegisterLoadingState());
    FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email, password: password)
        .then((value) {
      print('hello');
      print(value.user);
      print(value.user?.email);
      print('the User UId::${value.user!.uid}');
      createUser(
          name: name,
          email: email,
          phone: phone,
          uId: value.user!.uid,
          isEmailVerified: false);
      // emit(SocialRegisterSuccessState());
    }).catchError((error) {
      print("firebaseerror${error.toString()}");
      emit(SocialRegisterErrorState(error: error));
    });
  }

  void createUser(
      {required String name,
      required String email,
      required phone,
      required String uId,
      required bool isEmailVerified}) {
    SocialUserModel userModel = SocialUserModel(
        name: name,
        email: email,
        phone: phone,
        uId: uId,
        isEmailVerified: isEmailVerified);
    FirebaseFirestore.instance
        .collection('Users')
        .doc(uId)
        .set(userModel.toMap())
        .then((value) {
      emit(SocialCreateUserSuccessState());
    }).catchError((error) {
      print('create user error::${error.toString()}');
      emit(SocialCreateUserErrorState(error: error));
    });
  }

  IconData iconVisiblity = Icons.visibility;
  bool isPasword = true;
  void changPasswordVisibilty() {
    isPasword = !isPasword;
    iconVisiblity =
        isPasword ? Icons.visibility_off_outlined : Icons.visibility;
    emit(SocialRegisterPasswordVisibilitysState());
  }
}

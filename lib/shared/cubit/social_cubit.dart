import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/chats/chat_screen.dart';
import 'package:social_app/models/social_user_model.dart';
import 'package:social_app/modules/feeds/feeds.dart';
import 'package:social_app/modules/setting/setting.dart';
import 'package:social_app/modules/users/users.dart';
import 'package:social_app/shared/constants.dart';
import 'package:social_app/shared/cubit/Social_state.dart';

class SocialCubit extends Cubit<SocialStates> {
  SocialCubit() : super(SocialInitialState());
  static SocialCubit get(context) => BlocProvider.of(context);
  SocialUserModel? model;
  int currentIndex = 0;
  List<Widget> screens = [
    FeedScreen(),
    UserScreen(),
    ChatScreen(),
    SettingScreen()
  ];
  List<String> titles = ['Home', 'Users', 'Chats', 'Setting'];
  void changBottomNav(int index) {
    currentIndex = index;
    emit(SocialBottomNavState());
  }

  void getUserData() {
    emit(SocialGetUserLoadingState());
    FirebaseFirestore.instance.collection('Users').doc(uId).get().then((value) {
      print(value.data());
      model = SocialUserModel.fromJson(value.data()!);
      emit(SocialGetUserSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(SocialGetUserErrorState(error: error));
    });
  }
}

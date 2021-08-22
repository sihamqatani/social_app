import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:social_app/chats/chat_screen.dart';
import 'package:social_app/models/social_user_model.dart';
import 'package:social_app/modules/feeds/feeds.dart';
import 'package:social_app/modules/setting/setting.dart';
import 'package:social_app/modules/users/users.dart';
import 'package:social_app/shared/constants/constants.dart';
import 'package:social_app/shared/cubit/Social_state.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

class SocialCubit extends Cubit<SocialStates> {
  SocialCubit() : super(SocialInitialState());
  static SocialCubit get(context) => BlocProvider.of(context);
  SocialUserModel? model;
  int currentIndex = 0;
  List<Widget> screens = [
    FeedScreen(),
    UserScreen(),
    ChatScreen(),
    UserScreen(),
    SettingScreen()
  ];
  List<String> titles = ['Feeds', 'Users', 'Chats', 'Chats', 'Setting'];
  void changBottomNav(int index) {
    if (index == 3) {
      emit(SocialNewPostState());
    } else {
      currentIndex = index;
      emit(SocialBottomNavState());
    }
  }

  File? image;
  final picker = ImagePicker();

  Future getImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      image = File(pickedFile.path);
      emit(SocialProfileImagePickedSuccesState());
    } else {
      print('No image selected.');
      emit(SocialProfileImagePickedErrorState());
    }
  }

  File? coverImage;
  final coverPicker = ImagePicker();

  Future getCoverImage() async {
    final pickedCoverFile =
        await coverPicker.getImage(source: ImageSource.gallery);

    if (pickedCoverFile != null) {
      coverImage = File(pickedCoverFile.path);
      emit(SocialCoverImagePickedSuccesState());
    } else {
      print('No image selected.');
      emit(SocialCoverImagePickedErrorState());
    }
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
  void uploadProfileImage(){
    firebase_storage.firebase_storage.instance.ref().child('Users/${Url.file( image.path.segmentPath.last)}').putFile(image);
  }
}

//import 'dart:html';
import 'dart:io';
import 'dart:core';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

import 'package:social_app/models/comments_model.dart';
import 'package:social_app/models/message_model.dart';
import 'package:social_app/models/post_model.dart';
import 'package:social_app/models/social_user_model.dart';
import 'package:social_app/modules/chats/chat_screen.dart';
import 'package:social_app/modules/feeds/feeds.dart';
import 'package:social_app/modules/setting/setting.dart';
import 'package:social_app/modules/users/users.dart';
import 'package:social_app/shared/constants/constants.dart';
import 'package:social_app/shared/cubit/Social_state.dart';
//import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
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
    //  if (index == 1) //getAllUsers();
    if (index == 3) {
      emit(SocialNewPostState());
    } else {
      currentIndex = index;
      emit(SocialBottomNavState());
    }
  }

//image picker
  File? image;
  final picker = ImagePicker();

  Future<void> getImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      image = File(pickedFile.path);
      emit(SocialProfileImagePickedSuccesState());
    } else {
      print('No image selected.');
      emit(SocialProfileImagePickedErrorState());
    }
  }

//cover imagePicker
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

//Get userData>>>
  void getUserData() {
    emit(SocialGetUserLoadingState());
    FirebaseFirestore.instance.collection('Users').doc(uId).get().then((value) {
      print(value.data());
      model = SocialUserModel.fromJson(value.data()!);
      emit(SocialGetUserSuccessState());
    }).catchError((error) {
      print('the error is ${error.toString()}');
      emit(SocialGetUserErrorState(error: error));
    });
  }

  //Get All Users.......
  List<SocialUserModel> socialAllUsersModel = [];
  void getAllUsers() {
    // if (socialAllUsersModel.length == 0)
    FirebaseFirestore.instance.collection('Users').get().then((value) {
      value.docs.forEach((element) {
        //if (element.data()['uId'] != model!.uId)
        socialAllUsersModel.add(SocialUserModel.fromJson(element.data()));
      });
      emit(SocialGetAllUserSuccessState());
    }).catchError((error) {
      emit(SocialGeAlltUserErrorState(error: error));
      print('get all users errors ${error.toString()}');
    });
  }

//upload profile image into storage of firebase
  // String profileImageUrl = '';
  // String coverImageUrl = '';
  void uploadProfileImage({
    required String name,
    required String phone,
    required String bio,
  }) {
    emit(SocialUpatUserLoadingState());
    firebase_storage.FirebaseStorage.instance
        .ref()
        .child('Users/${Uri.file(image!.path).pathSegments.last}')
        .putFile(image!)
        .then((value) {
      value.ref.getDownloadURL().then((String? value) {
        // emit(SocialUploadProfileImageSuccesState());
        updateUser(name: name, phone: phone, bio: bio, image: value);

        //profileImageUrl = value!;
      }).catchError((error) {
        emit(SocialUploadProfileImageErrorState());
      });
    }).catchError((onError) {
      emit(SocialUploadProfileImageErrorState());
    });
  }

//upload cover image into storage of firebase
  void uploadCoverImage({
    required String name,
    required String phone,
    required String bio,
  }) {
    emit(SocialUpatUserLoadingState());
    firebase_storage.FirebaseStorage.instance
        .ref()
        .child('Users/${Uri.file(coverImage!.path).pathSegments.last}')
        .putFile(coverImage!)
        .then((value) {
      value.ref.getDownloadURL().then((String? value) {
        // emit(SocialUploadCoverImageSuccesState());
        print(value);
        updateUser(name: name, phone: phone, bio: bio, cover: value);

        //coverImageUrl = value!;
      }).catchError((error) {
        emit(SocialUploadCoverImageErrorState());
        print('the error is ${error.toString()}');
      });
    }).catchError((onError) {
      emit(SocialUploadCoverImageErrorState());
      print('the error is ${onError.toString()}');
    });
  }

//update data of user.....
  void updateUser(
      {required String name,
      required String phone,
      required String bio,
      String? cover,
      String? image}) {
    SocialUserModel userModel = SocialUserModel(
      name: name,
      phone: phone,
      image: image ?? model?.image,
      cover: cover ?? model?.cover,
      bio: bio,
      isEmailVerified: false,
      email: model!.email,
      uId: model!.uId,
    );
    FirebaseFirestore.instance
        .collection('Users')
        .doc(model?.uId)
        .update(userModel.toMap())
        .then((value) {
      //  print('update${value.toString}');
      getUserData();
    }).catchError((error) {
      emit(SocialUpatUserErrorState());
    });
    //}
  }

  //Get  postImage....
  File? postImage;
  final pickerPost = ImagePicker();
  Future getPostImage() async {
    final pickedPostFile =
        await pickerPost.getImage(source: ImageSource.gallery);

    if (pickedPostFile != null) {
      postImage = File(pickedPostFile.path);
      emit(SocialCreatePostSucessState());
    } else {
      print('No image selected.');
      emit(SocialCreatePostErrorState());
    }
  }

  //Create new post>>>>>>>>
  void uploadNewPostImage({
    required String text,
    required String dateTime,
  }) {
    emit(SocialCreatePostLoadingState());
    firebase_storage.FirebaseStorage.instance
        .ref()
        .child('Posts/${Uri.file(postImage!.path).pathSegments.last}')
        .putFile(postImage!)
        .then((value) {
      value.ref.getDownloadURL().then((String? value) {
        // emit(SocialUploadCoverImageSuccesState());
        print(value);
        createNewPost(text: text, dateTime: dateTime, postImage: value);

        //coverImageUrl = value!;
      }).catchError((error) {
        emit(SocialCreatePostErrorState());
        print('the error of post  is ${error.toString()}');
      });
    }).catchError((onError) {
      emit(SocialCreatePostErrorState());
      print('the error is ${onError.toString()}');
    });
  }

  //post likes......
  void postLikes(String postId) {
    FirebaseFirestore.instance
        .collection('Posts')
        .doc(postId)
        .collection('Likes')
        .doc(model?.uId)
        .set({'Like': true}).then((value) {
      emit(SocialLikePostSuccessState());
    }).catchError((onError) {
      emit(SocialLikePostErrorState(error: onError));
      print('like post error is ${onError.toString()}');
    });
  }

  List<PostModel> posts = [];
  List<String> postId = [];
  List<int> likes = [];
  List<CommentsModel> comments = [];
  List<int> commentsNo = [];

  void getPosts() {
    FirebaseFirestore.instance.collection('Posts').get().then((value) {
      value.docs.forEach((element) {
        element.reference.collection('Likes').get().then((value) {
          likes.add(value.docs.length);

          posts.add(PostModel.fromJson(element.data()));
          print(posts.length);
          postId.add(element.id);
        }).catchError((onError) {});
      });
      emit(SocialGetPostSuccessState());
    }).catchError((error) {
      emit(SocialGetPostErrorState(error: error));
    });
  }

// remove imagePost.....
  void remoePostImage() {
    postImage = null;
    emit(SocialRemovePostImageState());
  }

  //create new post????
  void createNewPost({
    required String text,
    required String dateTime,
    String? postImage,
  }) {
    PostModel post = PostModel(
      name: model!.name,
      image: model!.image!,
      text: text,
      dateTime: dateTime,
      uId: model!.uId,
      imagePost: postImage ?? '',
    );

    FirebaseFirestore.instance
        .collection('Posts')
        .add(post.toMap())
        .then((value) {
      emit(SocialCreatePostSucessState());
    }).catchError((error) {
      emit(SocialCreatePostErrorState());
    });
    //}
  }

//create Comment ..........
  void createNewComment(String? text, String postId) {
    FirebaseFirestore.instance
        .collection('Posts')
        .doc(postId)
        .collection('comments')
        .doc()
        .set({'text': text, 'postId': postId, 'image': model?.image}).then(
            (value) {
      emit(SocialCommentsPostSuccessState());
      print('comment done ');
    }).catchError((onError) {});
    emit(SocialCommentsPostErrorState(error: onError.toString()));
    print('error of comment${onError.toString()}');
  }

  CommentsModel? commentModel;
  //Get Comment......
  void getComments(String postId) {
    FirebaseFirestore.instance
        .collection('Posts')
        .doc(postId)
        .collection('comments')
        .get()
        .then((value) {
      value.docs.forEach((element) {
        commentsNo.add(value.docs.length);
        commentModel = CommentsModel.fromJson(element.data());
        print('the model of commnt${commentModel.toString()}');
        comments.add(commentModel!);
        print(element.data().toString());
      });
      emit(SocialGetCommentSuccessState());
      print('the model of commnt ${commentModel.toString()}');
      print(comments.toString());
      print('comment get');
    }).catchError((error) {
      emit(SocialGetCommentErrorState(error: error.toString()));
      print('error get comment${error.toString()}');
    });

    // *****************************************************

    /*FirebaseFirestore.instance.collection('comments').get().then((value) {
      value.docs.forEach((element) {
        commentModel = CommentsModel.fromJson(element.data());
        comments.add(commentModel!);
        print('the model of commnt${commentModel.toString()}');
        print(element.data().toString());
      });
      emit(SocialGetCommentSuccessState());
      print('comments are:::${comments.toString()}');
      print('comment get');
    }).catchError((error) {
      emit(SocialGetCommentErrorState(error: error));
      print('get all comment errors ${error.toString()}');
    });*/
  }

//get message in chat.......
  void sendMessage({
    required String reciveId,
    required String dateTime,
    required String text,
  }) {
    MessageModel messageModel = MessageModel(
        senderId: model!.uId,
        dateTime: dateTime,
        reciveId: reciveId,
        text: text);
    //here when you want  to send message from my mobile...
    FirebaseFirestore.instance
        .collection('Users')
        .doc(model?.uId)
        .collection('Chats')
        .doc(reciveId)
        .collection('Messages')
        .add(messageModel.toMap())
        .then((value) {
      emit(SocialSendMessagesSuccessState());
      print('my message is sending');
    }).catchError((onError) {
      emit(SocialSendMessagesErrorState(error: onError));
    });
    // my friend's phone......
    FirebaseFirestore.instance
        .collection('Users')
        .doc(reciveId)
        .collection('Chats')
        .doc(model!.uId)
        .collection('Messages')
        .add(messageModel.toMap())
        .then((value) {
      emit(SocialSendMessagesSuccessState());
      print('your message is sending to another user ');
    }).catchError((onError) {
      emit(SocialSendMessagesErrorState(error: onError));
    });
  }

  //Now here i will get messages between me and my friend......
  List<MessageModel> messages = [];
  void getMessage({required String recivedId}) {
    FirebaseFirestore.instance
        .collection('Users')
        .doc(model!.uId)
        .collection('Chats')
        .doc(recivedId)
        .collection('Messages')
        .orderBy('dateTime')
        .snapshots()
        .listen((event) {
      messages = [];
      event.docs.forEach((element) {
        // messages = [];
        messages.add(MessageModel.fromJson(element.data()));
      });
      emit(SocialGetMessagesSuccessState());
    });
  }
}

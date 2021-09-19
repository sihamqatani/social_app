import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:social_app/shared/components/components.dart';
import 'package:social_app/shared/cubit/Social_state.dart';
import 'package:social_app/shared/cubit/social_cubit.dart';
import 'package:social_app/shared/themes/theme.dart';

class EditProfileScreen extends StatelessWidget {
  late var nameController = TextEditingController();
  late var bioController = TextEditingController();
  late var phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var userModel = SocialCubit.get(context).model;
        File? image = SocialCubit.get(context).image;
        File? coverImage = SocialCubit.get(context).coverImage;
        nameController.text = userModel!.name;
        bioController.text = userModel.bio;
        phoneController.text = userModel.phone;

        return Scaffold(
          appBar:
              defaultAppbar(context: context, title: 'Edit Profile', action: [
            TextButton(
              onPressed: () {
                SocialCubit.get(context).updateUser(
                    name: nameController.text,
                    phone: phoneController.text,
                    bio: bioController.text);
              },
              child: Text('Update'),
            ),
            SizedBox(
              width: 12,
            ),
          ]),
          body: SingleChildScrollView(
            child: Column(
              children: [
                if (state is SocialUpatUserLoadingState)
                  LinearProgressIndicator(),
                if (state is SocialUpatUserLoadingState)
                  SizedBox(
                    height: 10.0,
                  ),
                Container(
                  height: 180,
                  alignment: AlignmentDirectional.bottomCenter,
                  child: Stack(
                    alignment: AlignmentDirectional.bottomCenter,
                    children: [
                      Align(
                        alignment: AlignmentDirectional.topCenter,
                        child: Stack(
                          alignment: AlignmentDirectional.topEnd,
                          children: [
                            Container(
                              height: 150,
                              width: double.infinity,
                              decoration: BoxDecoration(
                                  image: DecorationImage(
                                      image: coverImage == null
                                          ? NetworkImage(userModel.cover!)
                                          : FileImage(coverImage)
                                              as ImageProvider,
                                      // 'https://image.freepik.com/free-photo/pink-tree-nami-island-korea_335224-522.jpg'),
                                      fit: BoxFit.cover),
                                  borderRadius: BorderRadius.only(
                                      topRight: Radius.circular(5.0),
                                      topLeft: Radius.circular(5.0))),
                            ),
                            IconButton(
                                onPressed: () {
                                  SocialCubit.get(context).getCoverImage();
                                },
                                icon: Icon(
                                  FontAwesomeIcons.camera,
                                  color: Colors.amber[900],
                                  size: 20,
                                )),
                          ],
                        ),
                      ),
                      Stack(
                        alignment: AlignmentDirectional.bottomEnd,
                        children: [
                          CircleAvatar(
                            radius: 62,
                            backgroundColor: themeApp.scaffoldBackgroundColor,
                            child: CircleAvatar(
                              backgroundImage: image == null
                                  ? NetworkImage('${userModel.image}')
                                  : FileImage(image) as ImageProvider,
                              // 'https://image.freepik.com/free-photo/modern-stylish-muslim-woman-hijab-leather-jacket-black-abaya-walking-city-street-talking-smartphone_285396-9431.jpg'),
                              radius: 60,
                              // backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                            ),
                          ),
                          IconButton(
                              onPressed: () {
                                SocialCubit.get(context).getImage();
                              },
                              icon: Icon(
                                FontAwesomeIcons.camera,
                                color: Colors.amber[900],
                                size: 20,
                              )),
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 10),
                if (SocialCubit.get(context).image != null ||
                    SocialCubit.get(context).coverImage != null)
                  Row(
                    children: [
                      if (SocialCubit.get(context).image != null)
                        Expanded(
                          child: Column(
                            children: [
                              TextButton(
                                  onPressed: () {
                                    SocialCubit.get(context).uploadProfileImage(
                                        name: nameController.text,
                                        phone: phoneController.text,
                                        bio: bioController.text);
                                  },
                                  child: Text('Upload Profile Image')),
                              if (state is SocialUpatUserLoadingState)
                                SizedBox(
                                  height: 6,
                                ),
                              if (state is SocialUpatUserLoadingState)
                                LinearProgressIndicator(),
                            ],
                          ),
                        ),
                      SizedBox(
                        width: 10,
                      ),
                      if (SocialCubit.get(context).coverImage != null)
                        Expanded(
                          child: Column(
                            children: [
                              TextButton(
                                  onPressed: () {
                                    SocialCubit.get(context).uploadCoverImage(
                                        name: nameController.text,
                                        phone: phoneController.text,
                                        bio: bioController.text);
                                  },
                                  child: Text('Upload Cover Image')),
                              if (state is SocialUpatUserLoadingState)
                                SizedBox(
                                  height: 6,
                                ),
                              if (state is SocialUpatUserLoadingState)
                                LinearProgressIndicator(),
                            ],
                          ),
                        ),
                    ],
                  ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: defaultFormField(
                      controller: nameController,
                      type: TextInputType.name,
                      validate: (String? value) {
                        if (value!.isEmpty) return 'You must enter your name';
                      },
                      label: 'name',
                      prefix: Icons.person),
                ),
                SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: defaultFormField(
                      controller: bioController,
                      type: TextInputType.text,
                      validate: (String? value) {
                        if (value!.isEmpty) return 'You must enter your Bio';
                      },
                      label: 'Bio',
                      prefix: Icons.info_rounded),
                ),
                SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: defaultFormField(
                      controller: phoneController,
                      type: TextInputType.text,
                      validate: (String? value) {
                        if (value!.isEmpty) return 'You must enter your phone';
                      },
                      label: 'phone',
                      prefix: Icons.phone_android),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:social_app/shared/components/components.dart';
import 'package:social_app/shared/cubit/Social_state.dart';
import 'package:social_app/shared/cubit/social_cubit.dart';
import 'package:social_app/shared/themes/theme.dart';

class EditProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var userModel = SocialCubit.get(context).model;
        return Scaffold(
          appBar:
              defaultAppbar(context: context, title: 'Edit Profile', action: [
            TextButton(
              onPressed: () {},
              child: Text('Update'),
            ),
            SizedBox(
              width: 12,
            ),
          ]),
          body: Column(
            children: [
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
                                    image: NetworkImage(userModel!.cover),
                                    // 'https://image.freepik.com/free-photo/pink-tree-nami-island-korea_335224-522.jpg'),
                                    fit: BoxFit.cover),
                                borderRadius: BorderRadius.only(
                                    topRight: Radius.circular(5.0),
                                    topLeft: Radius.circular(5.0))),
                          ),
                          IconButton(
                              onPressed: () {},
                              icon: Icon(FontAwesomeIcons.camera))
                        ],
                      ),
                    ),
                    Stack(
                      alignment: AlignmentDirectional.topEnd,
                      children: [
                        CircleAvatar(
                          radius: 62,
                          backgroundColor: themeApp.scaffoldBackgroundColor,
                          child: CircleAvatar(
                            backgroundImage: NetworkImage(userModel.image!),
                            // 'https://image.freepik.com/free-photo/modern-stylish-muslim-woman-hijab-leather-jacket-black-abaya-walking-city-street-talking-smartphone_285396-9431.jpg'),
                            radius: 60,
                            // backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(height: 5),
            ],
          ),
        );
      },
    );
  }
}

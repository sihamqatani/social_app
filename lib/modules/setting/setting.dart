import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:social_app/modules/edit_profile/edit_profile_screen.dart';
import 'package:social_app/shared/components/components.dart';
import 'package:social_app/shared/cubit/Social_state.dart';
import 'package:social_app/shared/cubit/social_cubit.dart';
import 'package:social_app/shared/themes/theme.dart';

class SettingScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var userModel = SocialCubit.get(context).model;
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Container(
                height: 180,
                alignment: AlignmentDirectional.bottomCenter,
                child: Stack(
                  alignment: AlignmentDirectional.bottomCenter,
                  children: [
                    Align(
                      alignment: AlignmentDirectional.topCenter,
                      child: Container(
                        height: 150,
                        width: double.infinity,
                        decoration: BoxDecoration(
                            image: DecorationImage(
                                image: NetworkImage('${userModel?.cover}'),
                                // 'https://image.freepik.com/free-photo/pink-tree-nami-island-korea_335224-522.jpg'),
                                fit: BoxFit.cover),
                            borderRadius: BorderRadius.only(
                                topRight: Radius.circular(5.0),
                                topLeft: Radius.circular(5.0))),
                      ),
                    ),
                    CircleAvatar(
                      radius: 62,
                      backgroundColor: themeApp.scaffoldBackgroundColor,
                      child: CircleAvatar(
                        backgroundImage: NetworkImage('${userModel?.image}'),
                        // 'https://image.freepik.com/free-photo/modern-stylish-muslim-woman-hijab-leather-jacket-black-abaya-walking-city-street-talking-smartphone_285396-9431.jpg'),
                        radius: 60,
                        // backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 5),
              Text('${userModel?.name}', style: themeApp.textTheme.subtitle1),
              SizedBox(height: 5),
              Text('${userModel?.bio}',
                  style: Theme.of(context).textTheme.caption),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Row(
                  children: [
                    Expanded(
                      child: InkWell(
                        onTap: () {},
                        child: Column(
                          children: [
                            Text(
                              'Posts',
                              style: themeApp.textTheme.subtitle2,
                            ),
                            Text(
                              '250',
                              style: themeApp.textTheme.caption,
                            ),
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      child: InkWell(
                        onTap: () {},
                        child: Column(
                          children: [
                            Text(
                              'Friends',
                              style: themeApp.textTheme.subtitle2,
                            ),
                            Text(
                              '114',
                              style: themeApp.textTheme.caption,
                            ),
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      child: InkWell(
                        onTap: () {},
                        child: Column(
                          children: [
                            Text(
                              'Follwers',
                              style: themeApp.textTheme.subtitle2,
                            ),
                            Text(
                              '90',
                              style: themeApp.textTheme.caption,
                            ),
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      child: InkWell(
                        onTap: () {},
                        child: Column(
                          children: [
                            Text(
                              'Photoes',
                              style: themeApp.textTheme.subtitle2,
                            ),
                            Text(
                              '175',
                              style: themeApp.textTheme.caption,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Row(
                children: [
                  Expanded(
                      child: OutlinedButton(
                    onPressed: () {},
                    child: Text('Add Photo'),
                    clipBehavior: Clip.antiAliasWithSaveLayer,
                  )),
                  SizedBox(width: 5),
                  OutlinedButton(
                      onPressed: () {
                        navigateTo(context, EditProfileScreen());
                      },
                      child: Icon(
                        FontAwesomeIcons.edit,
                        size: 15,
                      ))
                ],
              )
            ],
          ),
        );
      },
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/modules/new_post/new_post.dart';
import 'package:social_app/shared/components/components.dart';
import 'package:social_app/shared/cubit/Social_state.dart';
import 'package:social_app/shared/cubit/social_cubit.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialStates>(
      listener: (context, state) {
        if (state is SocialNewPostState) {
          navigateTo(context, NewPostScreen());
        }
      },
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            actions: [
              IconButton(onPressed: () {}, icon: Icon(Icons.search)),
              IconButton(onPressed: () {}, icon: Icon(Icons.notifications)),
            ],
            title: Text(SocialCubit.get(context)
                .titles[SocialCubit.get(context).currentIndex]),
          ),
          body: SocialCubit.get(context)
              .screens[SocialCubit.get(context).currentIndex],
          /*Conditional.single(
              context: (context),
              conditionBuilder: (context) =>
                  SocialCubit.get(context).model != null,
              widgetBuilder: (context) => Column(
                    children: [
                      Container(
                        color: Colors.amber,
                        height: 50,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: Row(
                            children: [
                              Icon(Icons.info),
                              SizedBox(
                                width: 5,
                              ),
                              Expanded(child: Text('please verify your email')),
                              SizedBox(
                                width: 20,
                              ),
                              //Spacer(),
                              defaultButton(
                                  function: () {},
                                  text: 'SEND',
                                  width: 100,
                                  background: Colors.amber),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
              fallbackBuilder: (context) =>
                  Center(child: CircularProgressIndicator())),*/
          bottomNavigationBar: BottomNavigationBar(
              currentIndex: SocialCubit.get(context).currentIndex,
              onTap: (index) {
                SocialCubit.get(context).changBottomNav(index);
              },
              items: [
                BottomNavigationBarItem(
                    icon: Icon(FontAwesomeIcons.home), label: 'Home'),
                BottomNavigationBarItem(
                    icon: Icon(FontAwesomeIcons.user), label: 'Users'),
                BottomNavigationBarItem(
                    icon: Icon(FontAwesomeIcons.comment), label: 'Chats'),
                BottomNavigationBarItem(
                    icon: Icon(FontAwesomeIcons.fileUpload), label: 'Post'),
                BottomNavigationBarItem(
                    icon: Icon(FontAwesomeIcons.userEdit), label: 'Setting'),
              ]),
        );
      },
    );
  }
}

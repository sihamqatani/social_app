import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/shared/cubit/Social_state.dart';
import 'package:social_app/shared/cubit/social_cubit.dart';
import 'package:social_app/shared/styles/icon_broken.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            actions: [
              IconButton(onPressed: () {}, icon: Icon(IconBroken.Search)),
              IconButton(onPressed: () {}, icon: Icon(IconBroken.Notification)),
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
                    icon: Icon(IconBroken.Home), label: 'Home'),
                BottomNavigationBarItem(
                    icon: Icon(IconBroken.User), label: 'Users'),
                BottomNavigationBarItem(
                    icon: Icon(IconBroken.Chat), label: 'Chat'),
                BottomNavigationBarItem(
                    icon: Icon(IconBroken.Setting), label: 'Setting'),
              ]),
        );
      },
    );
  }
}

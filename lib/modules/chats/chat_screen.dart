import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_conditional_rendering/flutter_conditional_rendering.dart';
import 'package:social_app/models/social_user_model.dart';
import 'package:social_app/modules/chats/chats_details.dart';
import 'package:social_app/shared/components/components.dart';
import 'package:social_app/shared/cubit/Social_state.dart';
import 'package:social_app/shared/cubit/social_cubit.dart';

class ChatScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return Conditional.single(
            context: context,
            conditionBuilder: (context) =>
                SocialCubit.get(context).socialAllUsersModel.length > 0,
            widgetBuilder: (context) => ListView.separated(
                itemBuilder: (context, index) => buildChatItem(
                    SocialCubit.get(context).socialAllUsersModel[index],
                    context),
                separatorBuilder: (context, index) => Container(
                      width: MediaQuery.of(context).size.width,
                      height: 1,
                    ),
                itemCount: SocialCubit.get(context).socialAllUsersModel.length),
            fallbackBuilder: (context) =>
                Center(child: CircularProgressIndicator()),
          );
        });
  }

  Widget buildChatItem(SocialUserModel userModel, BuildContext context) {
    return InkWell(
      onTap: () {
        navigateTo(context, ChatsDetails(user: userModel));
      },
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Row(
            // crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              CircleAvatar(
                radius: 16,
                backgroundImage: NetworkImage('${userModel.image}'),
                /*'https://as1.ftcdn.net/v2/jpg/02/96/20/94/1000_F_296209436_rSsK1SYwSv1NuKVxQXF0aAht2iDSyocf.jpg'),*/
              ),
              SizedBox(
                width: 15,
              ),
              Text('${userModel.name}'),
            ]),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_conditional_rendering/conditional.dart';
import 'package:social_app/models/message_model.dart';
import 'package:social_app/models/social_user_model.dart';
import 'package:social_app/shared/cubit/Social_state.dart';
import 'package:social_app/shared/cubit/social_cubit.dart';

class ChatsDetails extends StatelessWidget {
  SocialUserModel? user;
  ChatsDetails({this.user});
  var textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (BuildContext context) {
        SocialCubit.get(context).getMessage(recivedId: user!.uId);
        return BlocConsumer<SocialCubit, SocialStates>(
          listener: (context, state) {},
          builder: (context, state) {
            return Scaffold(
                backgroundColor: Colors.red[50],
                appBar: AppBar(
                  title: Row(
                    children: [
                      CircleAvatar(
                        radius: 17,
                        backgroundImage: NetworkImage('${user?.image}'),
                      ),
                      SizedBox(width: 15),
                      Text('${user?.name}')
                    ],
                  ),
                ),
                body: Conditional.single(
                    context: context,
                    conditionBuilder: (context) =>
                        SocialCubit.get(context).messages.length > 0,
                    widgetBuilder: (context) {
                      return Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Column(
                          children: [
                            Expanded(
                              child: ListView.separated(
                                  itemBuilder: (contex, index) {
                                    if (SocialCubit.get(context).model!.uId ==
                                        SocialCubit.get(context)
                                            .messages[index]
                                            .senderId)
                                      return buildMyMessage(
                                          SocialCubit.get(context)
                                              .messages[index]);
                                    return buildMessage(SocialCubit.get(context)
                                        .messages[index]);
                                  },
                                  separatorBuilder: (context, index) =>
                                      Container(
                                        width: double.infinity,
                                        height: 1,
                                      ),
                                  itemCount:
                                      SocialCubit.get(context).messages.length),
                            ),
                            // buildMessage(),
                            // buildMyMessage(),
                           // Spacer(),
                            Container(
                              clipBehavior: Clip.antiAliasWithSaveLayer,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(90),
                                  border: Border.all(color: Colors.red[200]!)),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: TextFormField(
                                      controller: textController,
                                      keyboardType: TextInputType.text,
                                      decoration: InputDecoration(
                                        fillColor: Colors.white,
                                        filled: true,
                                        hintText: 'Enter your message',
                                        hintStyle:
                                            TextStyle(color: Colors.red[200]),
                                        border: OutlineInputBorder(
                                          // width: 0.0 produces a thin "hairline" border
                                          borderRadius: BorderRadius.all(
                                            Radius.circular(90.0),
                                          ),
                                          borderSide: BorderSide.none,
                                          //borderSide: const BorderSide(),
                                        ),
                                      ),
                                    ),
                                  ),
                                  MaterialButton(
                                    onPressed: () {
                                      SocialCubit.get(context).sendMessage(
                                          reciveId: user!.uId,
                                          dateTime: DateTime.now().toString(),
                                          text: textController.text);
                                    },
                                    child: Icon(
                                      Icons.send,
                                      size: 15,
                                      color: Colors.red[400],
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                    fallbackBuilder: (context) => Center(
                          child: CircularProgressIndicator(),
                        )));
          },
        );
      },
    );
  }

  Widget buildMessage(MessageModel messageModel) {
    return Align(
        alignment: AlignmentDirectional.bottomStart,
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          child: Text(messageModel.text),
          decoration: BoxDecoration(
            color: Colors.blue[200],
            borderRadius: BorderRadiusDirectional.only(
              bottomEnd: Radius.circular(10),
              topStart: Radius.circular(10),
              topEnd: Radius.circular(10),
            ),
          ),
        ));
  }

  Widget buildMyMessage(MessageModel messageModel) {
    return Align(
        alignment: AlignmentDirectional.centerEnd,
        child: Container(
          // color: Colors.cyanAccent[200],
          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          child: Text(messageModel.text),
          // color: Colors.cyanAccent[200],
          decoration: BoxDecoration(
            color: Colors.amber[200],
            borderRadius: BorderRadiusDirectional.only(
              bottomStart: Radius.circular(10),
              topStart: Radius.circular(10),
              topEnd: Radius.circular(10),
            ),
          ),
        ));
  }
}

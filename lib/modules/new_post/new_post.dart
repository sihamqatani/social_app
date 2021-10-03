import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:social_app/shared/components/components.dart';
import 'package:social_app/shared/cubit/Social_state.dart';
import 'package:social_app/shared/cubit/social_cubit.dart';

class NewPostScreen extends StatelessWidget {
  var textController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
            appBar: defaultAppbar(context: context, title: 'Add Post', action: [
              TextButton(
                  onPressed: () {
                    var now = DateTime.now();
                    if (SocialCubit.get(context).postImage == null) {
                      SocialCubit.get(context)
                        ..createNewPost(
                            text: textController.text,
                            dateTime: now.toString());
                      print('hell1');
                    } else {
                      SocialCubit.get(context).uploadNewPostImage(
                          text: textController.text, dateTime: now.toString());
                      print('hello2');
                    }
                  },
                  child: Text('Post')),
            ]),
            body: Column(
              children: [
                Row(
                  children: [
                    CircleAvatar(
                      radius: 25,
                      backgroundImage: NetworkImage(
                          'https://as1.ftcdn.net/v2/jpg/02/96/20/94/1000_F_296209436_rSsK1SYwSv1NuKVxQXF0aAht2iDSyocf.jpg'),
                    ),
                    SizedBox(
                      width: 15,
                    ),
                    Text(
                      'Soma Abdullah',
                      style: Theme.of(context)
                          .textTheme
                          .subtitle1
                          ?.copyWith(height: 1.4),
                    ),
                    SizedBox(
                      width: 5,
                    ),
                  ],
                ),
                Expanded(
                    child: TextFormField(
                  controller: textController,
                  decoration: InputDecoration(
                    hintText: 'What is in your mind',
                    border: InputBorder.none,
                  ),
                )),
                if (SocialCubit.get(context).postImage != null)
                  Stack(
                    alignment: AlignmentDirectional.topEnd,
                    children: [
                      Container(
                        height: 150,
                        width: double.infinity,
                        decoration: BoxDecoration(
                            image: DecorationImage(
                                image: FileImage(
                                    SocialCubit.get(context).postImage!),

                                // 'https://image.freepik.com/free-photo/pink-tree-nami-island-korea_335224-522.jpg'),
                                fit: BoxFit.cover),
                            borderRadius: BorderRadius.circular(4)),
                      ),
                      IconButton(
                          onPressed: () {
                            SocialCubit.get(context).remoePostImage();
                          },
                          icon: Icon(
                            Icons.cancel,
                            color: Colors.amber[900],
                            size: 20,
                          )),
                    ],
                  ),
                Expanded(
                    child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextButton(
                        onPressed: () {
                          SocialCubit.get(context).getPostImage();
                        },
                        child: Row(
                          children: [
                            Icon(FontAwesomeIcons.images),
                            Text('Add Photo'),
                          ],
                        )),
                    TextButton(onPressed: () {}, child: Text('# tags'))
                  ],
                ))
              ],
            ));
      },
    );
  }
}

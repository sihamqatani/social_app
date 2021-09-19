import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_conditional_rendering/conditional.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:social_app/models/post_model.dart';
import 'package:social_app/shared/cubit/Social_state.dart';
import 'package:social_app/shared/cubit/social_cubit.dart';

class FeedScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialStates>(
        listener: (conrext, state) {},
        builder: (context, state) {
          return Conditional.single(
              context: context,
              conditionBuilder: (context) =>
                  SocialCubit.get(context).posts.length > 0 &&
                  SocialCubit.get(context).model != null,
              widgetBuilder: (context) {
                return SingleChildScrollView(
                  //physics: Scr,
                  child: Column(
                    children: [
                      Card(
                          margin: EdgeInsets.all(8),
                          elevation: 5,
                          clipBehavior: Clip.antiAliasWithSaveLayer,
                          child: Stack(
                              alignment: AlignmentDirectional.bottomEnd,
                              children: [
                                Image(
                                  fit: BoxFit.cover,
                                  height: 200,
                                  width: double.infinity,
                                  image: NetworkImage(
                                      'https://as1.ftcdn.net/v2/jpg/02/03/77/88/1000_F_203778892_ctopw9pJDwz5xtDHeZALs7p1ieGeieTB.jpg'),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    'Connect with your friends',
                                    style: TextStyle(color: Colors.white),
                                  ),
                                )
                              ])),
                      ListView.separated(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          separatorBuilder: (context, index) => SizedBox(
                                height: 5,
                              ),
                          itemCount: SocialCubit.get(context).posts.length,
                          itemBuilder: (context, index) {
                            return buildPostItem(
                                SocialCubit.get(context).posts[index],
                                context,
                                index);
                          }),
                      SizedBox(
                        height: 20,
                      )
                    ],
                  ),
                );
              },
              fallbackBuilder: (BuildContext context) {
                return Center(child: CircularProgressIndicator());
              });
        });
  }
}

void show(
  BuildContext ctx,
  int index,
) {
  showModalBottomSheet(
      elevation: 10,
      backgroundColor: Colors.white,
      context: ctx,
      builder: (ctx) => Column(children: [
            Row(
              children: [
                CircleAvatar(
                  radius: 16,
                  backgroundImage:
                      NetworkImage('${SocialCubit.get(ctx).model?.image}'),
                  /*'https://as1.ftcdn.net/v2/jpg/02/96/20/94/1000_F_296209436_rSsK1SYwSv1NuKVxQXF0aAht2iDSyocf.jpg'),*/
                ),
                SizedBox(
                  width: 5,
                ),
                Expanded(
                    child: TextFormField(
                  keyboardType: TextInputType.text,
                  validator: (value) {},
                  onFieldSubmitted: (value) {
                    print('onsubmitt');
                    SocialCubit.get(ctx).createNewComment(
                        commentController.text,
                        SocialCubit.get(ctx).postId[index]);
                  },
                  controller: commentController,
                  decoration: InputDecoration(
                      fillColor: Colors.white,
                      filled: true,
                      focusColor: Colors.red[300],
                      border: OutlineInputBorder(
                        // width: 0.0 produces a thin "hairline" border
                        borderRadius: BorderRadius.all(
                          Radius.circular(90.0),
                        ),
                        borderSide: BorderSide.none,
                        //borderSide: const BorderSide(),
                      ),
                      hintText: 'write your comment here',
                      hintStyle: TextStyle(color: Colors.red[200])),
                )),
              ],
            ),
          ]));
  /*Container(
            width: 300,
            height: 250,
            color: Colors.white54,
            alignment: Alignment.center,
            child: Text('Breathe in... Breathe out...'),
          ));*/
}

var commentController = TextEditingController();
Widget buildPostItem(PostModel post, context, index) {
  return Card(
    margin: EdgeInsets.symmetric(horizontal: 8),
    elevation: 5,
    clipBehavior: Clip.antiAliasWithSaveLayer,
    child: Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CircleAvatar(
                radius: 25,
                backgroundImage: NetworkImage('${post.image}'),
                // 'https://as1.ftcdn.net/v2/jpg/02/96/20/94/1000_F_296209436_rSsK1SYwSv1NuKVxQXF0aAht2iDSyocf.jpg'),
              ),
              SizedBox(
                width: 15,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          '${post.name}',
                          style: Theme.of(context)
                              .textTheme
                              .subtitle1
                              ?.copyWith(height: 1.4),
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Icon(
                          Icons.check_circle,
                          color: Colors.blue,
                          size: 16,
                        )
                      ],
                    ),
                    Text(
                      '${post.dateTime}',
                      style: Theme.of(context)
                          .textTheme
                          .caption
                          ?.copyWith(height: 1.4),
                    )
                  ],
                ),
              ),
              SizedBox(
                width: 20,
              ),
              IconButton(onPressed: () {}, icon: Icon(Icons.more_horiz)),
            ],
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: Container(
              width: double.infinity,
              height: 1,
              color: Colors.grey[400],
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 5),
            child: Text(
              '${post.text}',
              /* 'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry\'s standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book.'*/
              style: Theme.of(context).textTheme.subtitle2,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: Wrap(
              spacing: 1,
              children: [
                Container(
                  height: 20,
                  padding: EdgeInsets.zero,
                  //width: double.infinity,
                  child: MaterialButton(
                    child: Text(
                      '#Software',
                      style: TextStyle(color: Colors.blue),
                    ),
                    onPressed: () {},
                    minWidth: 1,
                  ),
                ),
                Container(
                  height: 20,
                  child: MaterialButton(
                    child: Text(
                      '#Software',
                      style: TextStyle(color: Colors.blue),
                    ),
                    onPressed: () {},
                    minWidth: 1,
                  ),
                ),
                Container(
                  height: 20,
                  child: MaterialButton(
                    child: Text(
                      '#Software',
                      style: TextStyle(color: Colors.blue),
                    ),
                    onPressed: () {},
                    minWidth: 1,
                  ),
                ),
              ],
            ),
          ),
          if (post.imagePost != '')
            Padding(
              padding: EdgeInsetsDirectional.only(top: 10),
              child: Container(
                width: double.infinity,
                height: 140,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: NetworkImage('${post.imagePost}'),
                        /*  'https://as1.ftcdn.net/v2/jpg/02/96/20/94/1000_F_296209436_rSsK1SYwSv1NuKVxQXF0aAht2iDSyocf.jpg'),*/
                        fit: BoxFit.cover),
                    borderRadius: BorderRadius.circular(5)),
              ),
            ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: Row(
              children: [
                Expanded(
                  child: InkWell(
                    onTap: () {},
                    child: Row(
                      children: [
                        Icon(
                          FontAwesomeIcons.heart,
                          size: 15,
                          color: Colors.red[900],
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Text('${SocialCubit.get(context).likes[index]}',
                            style: Theme.of(context)
                                .textTheme
                                .caption
                                ?.copyWith(color: Colors.grey)),
                      ],
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {},
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Icon(
                        FontAwesomeIcons.comment,
                        size: 15,
                        color: Colors.red[900],
                      ),
                      SizedBox(width: 5),
                      Text('0 comment',
                          style: Theme.of(context)
                              .textTheme
                              .caption
                              ?.copyWith(color: Colors.grey)),
                    ],
                  ),
                )
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(5.0),
            child: Container(
              width: double.infinity,
              height: 1,
              color: Colors.grey[400],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 5),
            child: Row(
              children: [
                Row(
                  // crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    CircleAvatar(
                      radius: 16,
                      backgroundImage: NetworkImage(
                          '${SocialCubit.get(context).model?.image}'),
                      /*'https://as1.ftcdn.net/v2/jpg/02/96/20/94/1000_F_296209436_rSsK1SYwSv1NuKVxQXF0aAht2iDSyocf.jpg'),*/
                    ),
                    SizedBox(
                      width: 15,
                    ),
                    InkWell(
                      child: Text('Write your comment ...'),
                      onTap: () {
                        print('booooo');
                        show(context, index);

                        //ModelBottomSheet(),
                        /*BottomSheet(
                          builder: (context) {
                            return Column(children: [
                              CircleAvatar(
                                radius: 16,
                                backgroundImage: NetworkImage(
                                    '${SocialCubit.get(context).model?.image}'),
                                /*'https://as1.ftcdn.net/v2/jpg/02/96/20/94/1000_F_296209436_rSsK1SYwSv1NuKVxQXF0aAht2iDSyocf.jpg'),*/
                              ),
                              SizedBox(
                                width: 15,
                              ),
                              Expanded(
                                child: defaultFormField(
                                  controller: commentController,
                                  type: TextInputType.text,
                                  validate: (value) {},
                                  label: 'write your input here',
                                  prefix: Icons.comment_bank_outlined,
                                ),
                              ),
                            ]);
                          },
                          onClosing: () {},
                        );*/
                      },
                    ),
                  ],
                ),
                Spacer(),
                Expanded(
                  child: InkWell(
                    onTap: () {
                      SocialCubit.get(context)
                          .postLikes(SocialCubit.get(context).postId[index]);
                      print('your like is done');
                    },
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Icon(
                          Icons.favorite_border,
                          size: 20,
                          color: Colors.red[900],
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Text('LIKE',
                            style: Theme.of(context)
                                .textTheme
                                .caption
                                ?.copyWith(color: Colors.grey)),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}

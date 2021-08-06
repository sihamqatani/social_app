import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class FeedScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      //physics: Scr,
      child: Column(
        children: [
          Card(
              margin: EdgeInsets.all(8),
              elevation: 5,
              clipBehavior: Clip.antiAliasWithSaveLayer,
              child:
                  Stack(alignment: AlignmentDirectional.bottomEnd, children: [
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
              itemCount: 10,
              itemBuilder: (context, intdex) {
                return buildPostItem(context);
              }),
          SizedBox(
            height: 20,
          )
        ],
      ),
    );
  }

  Widget buildPostItem(context) {
    return Card(
      margin: EdgeInsets.symmetric(horizontal: 8),
      elevation: 5,
      clipBehavior: Clip.antiAliasWithSaveLayer,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
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
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
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
                          Icon(
                            Icons.check_circle,
                            color: Colors.blue,
                            size: 16,
                          )
                        ],
                      ),
                      Text(
                        '16-Augest-2021 at 08:16 pm',
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
                'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry\'s standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book.',
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
            Container(
              width: double.infinity,
              height: 140,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: NetworkImage(
                          'https://as1.ftcdn.net/v2/jpg/02/96/20/94/1000_F_296209436_rSsK1SYwSv1NuKVxQXF0aAht2iDSyocf.jpg'),
                      fit: BoxFit.cover),
                  borderRadius: BorderRadius.circular(5)),
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
                          Text('200',
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
                        Text('100 comment',
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
                            'https://as1.ftcdn.net/v2/jpg/02/96/20/94/1000_F_296209436_rSsK1SYwSv1NuKVxQXF0aAht2iDSyocf.jpg'),
                      ),
                      SizedBox(
                        width: 15,
                      ),
                      Text('Write your comment ...'),
                    ],
                  ),
                  Spacer(),
                  Expanded(
                    child: InkWell(
                      onTap: () {},
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
}

import 'package:flutter/material.dart';
import 'package:social_app/shared/themes/theme.dart';

class SettingScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Stack(
          alignment: AlignmentDirectional.bottomCenter,
          children: [
            Container(
              height: 140,
              width: double.infinity,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: NetworkImage('https://image.freepik.com/free-photo/closeup-shot-burning-wood-beautiful-colors-fire_181624-14519.jpg'), fit: BoxFit.cover),
                  borderRadius: BorderRadius.only(
                      topRight: Radius.circular(5.0),
                      topLeft: Radius.circular(5.0))),
              child: CircleAvatar(
                radius: 60,
                backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                child: CircleAvatar(
                  backgroundImage: NetworkImage('https://image.freepik.com/free-photo/cheerful-curly-business-girl-wearing-glasses_176420-206.jpg'),
                  radius: 50,
                  backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

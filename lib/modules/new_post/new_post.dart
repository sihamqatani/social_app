import 'package:flutter/material.dart';
import 'package:social_app/shared/components/components.dart';

class NewPostScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: defaultAppbar(
        context: context,
        title: 'Add Post',
      ),
      body: Center(
        child: Text('new post'),
      ),
    );
  }
}

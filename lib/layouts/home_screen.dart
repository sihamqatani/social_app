import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_conditional_rendering/flutter_conditional_rendering.dart';
import 'package:social_app/shared/components/components.dart';
import 'package:social_app/shared/cubit/Social_state.dart';
import 'package:social_app/shared/cubit/social_cubit.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
            appBar: AppBar(),
            body: Conditional.single(
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
                                Expanded(
                                    child: Text('please verify your email')),
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
                        )
                      ],
                    ),
                fallbackBuilder: (context) =>
                    Center(child: CircularProgressIndicator())));
      },
    );
  }
}

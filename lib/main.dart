import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/layouts/home_screen.dart';

import 'package:social_app/modules/login_screen/social_login_screen.dart';
import 'package:social_app/shared/cubit/social_cubit.dart';
import 'package:social_app/shared/network/local/cashe_helper.dart';
import 'package:social_app/shared/themes/theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await CashHelper.init();
  String? uId = CashHelper.getData(key: 'uId');
  Widget widget;
  if (uId != null)
    widget = HomeScreen();
  else
    widget = SocialLoginScreen();

  runApp(SocialApp(
    startWidget: widget,
  ));
}

class SocialApp extends StatelessWidget {
  Widget startWidget;
  SocialApp({
    required this.startWidget,
  });
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SocialCubit()
        ..getUserData()
        ..getPosts(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: themeApp,
        darkTheme: darkThemeApp,
        home: startWidget,

        // home: SettingScreen(),
      ),
    );
  }
}

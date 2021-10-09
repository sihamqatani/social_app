import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/layouts/home_screen.dart';

import 'package:social_app/modules/login_screen/social_login_screen.dart';
import 'package:social_app/shared/components/components.dart';
import 'package:social_app/shared/cubit/social_cubit.dart';
import 'package:social_app/shared/network/local/cashe_helper.dart';
import 'package:social_app/shared/themes/theme.dart';

Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  print('When app in background:${message.data.toString()}');

  showToast(message: 'app in Background', state: ToastColorstate.SUCCESS);
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  var token = await FirebaseMessaging.instance.getToken();
  print('Token of device::>>>$token');
  FirebaseMessaging.onMessage.listen((event) {
    print('when open :${event.data.toString()}');
    showToast(message: 'On Message', state: ToastColorstate.SUCCESS);
  });
  FirebaseMessaging.onMessageOpenedApp.listen((event) {
    print('when app open in background:${event.data.toString()}');
    showToast(message: 'On Background', state: ToastColorstate.SUCCESS);
  });
  FirebaseMessaging.onBackgroundMessage((firebaseMessagingBackgroundHandler));

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
        ..getPosts()
        ..getAllUsers(),
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

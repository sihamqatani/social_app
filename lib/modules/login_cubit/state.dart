//import 'package:shop01_app/models/shop_model.dart';

abstract class SocialLoginState {}

class SocialLoginloadingState extends SocialLoginState {}

class SocialLoginInitialState extends SocialLoginState {}

class SocialLoginSuccessState extends SocialLoginState {
  final String uId;
  SocialLoginSuccessState({
    required this.uId,
  });
}

class SocialLoginErrorState extends SocialLoginState {
  final String error;
  SocialLoginErrorState({
    required this.error,
  });
}

class SocialLoginPasswordVisibilitysState extends SocialLoginState {}

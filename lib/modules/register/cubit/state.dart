abstract class SocialRegisterStates {}

class SocialRegisterLoadingState extends SocialRegisterStates {}

class SocialRegisterInitialState extends SocialRegisterStates {}

class SocialRegisterSuccessState extends SocialRegisterStates {}

class SocialRegisterErrorState extends SocialRegisterStates {
  String error;
  SocialRegisterErrorState({
    required this.error,
  });
}

class SocialCreateUserSuccessState extends SocialRegisterStates {}

class SocialCreateUserErrorState extends SocialRegisterStates {
  final String error;
  SocialCreateUserErrorState({
    required this.error,
  });
}

class SocialRegisterPasswordVisibilitysState extends SocialRegisterStates {}


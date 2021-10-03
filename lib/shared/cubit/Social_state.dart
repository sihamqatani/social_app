abstract class SocialStates {}

class SocialInitialState extends SocialStates {}

class SocialGetUserLoadingState extends SocialStates {}

class SocialGetUserSuccessState extends SocialStates {}

class SocialGetUserErrorState extends SocialStates {
  final String error;
  SocialGetUserErrorState({
    required this.error,
  });
}

class SocialGetAllUsersLoadingState extends SocialStates {}

class SocialGetAllUserSuccessState extends SocialStates {}

class SocialGeAlltUserErrorState extends SocialStates {
  final String error;
  SocialGeAlltUserErrorState({
    required this.error,
  });
}

class SocialBottomNavState extends SocialStates {}

class SocialNewPostState extends SocialStates {}

class SocialProfileImagePickedSuccesState extends SocialStates {}

class SocialProfileImagePickedErrorState extends SocialStates {}

class SocialCoverImagePickedSuccesState extends SocialStates {}

class SocialCoverImagePickedErrorState extends SocialStates {}

class SocialUploadProfileImageSuccesState extends SocialStates {}

class SocialUploadProfileImageErrorState extends SocialStates {}

class SocialUploadCoverImageSuccesState extends SocialStates {}

class SocialUploadCoverImageErrorState extends SocialStates {}

class SocialUpatUserErrorState extends SocialStates {}

class SocialUpatUserLoadingState extends SocialStates {}

//create post
class SocialCreatePostLoadingState extends SocialStates {}

class SocialCreatePostSucessState extends SocialStates {}

class SocialCreatePostErrorState extends SocialStates {}

class SocialRemovePostImageState extends SocialStates {}

class SocialGetPostrLoadingState extends SocialStates {}

class SocialGetPostSuccessState extends SocialStates {}

class SocialGetPostErrorState extends SocialStates {
  final String error;
  SocialGetPostErrorState({required this.error});
}

class SocialLikePostSuccessState extends SocialStates {}

class SocialLikePostErrorState extends SocialStates {
  final String error;
  SocialLikePostErrorState({required this.error});
}

class SocialCommentsPostSuccessState extends SocialStates {}

class SocialCommentsPostErrorState extends SocialStates {
  final String error;
  SocialCommentsPostErrorState({required this.error});
}

class SocialGetCommentSuccessState extends SocialStates {}

class SocialGetCommentErrorState extends SocialStates {
  final String error;
  SocialGetCommentErrorState({required this.error});
}

class SocialSendMessagesSuccessState extends SocialStates {}

class SocialSendMessagesErrorState extends SocialStates {
  final String error;
  SocialSendMessagesErrorState({
    required this.error,
  });
}

class SocialGetMessagesSuccessState extends SocialStates {}

class SocialGetMessagesErrorState extends SocialStates {
  final String error;
  SocialGetMessagesErrorState({
    required this.error,
  });
}

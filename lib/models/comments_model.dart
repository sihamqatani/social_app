class CommentsModel {
  String? text;
  late String profileImage;
  late String postId;
  CommentsModel(
      {required this.text, required this.postId, required this.profileImage});
  CommentsModel.fromJson(Map<String, dynamic> json) {
    text = json['text'];
    profileImage = json['profileImage'];
    postId = json['postId'];
  }
  Map<String, dynamic> toMap() {
    return {
      'text': text,
      'profileImage': profileImage,
      'postId': postId,
    };
  }
}

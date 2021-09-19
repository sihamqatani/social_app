class PostModel {
  late String name;
  late String uId;
  late String image;
  late String dateTime;
  late String text;
  late String imagePost;
  PostModel({
    required this.name,
    required this.uId,
    required this.image,
    required this.text,
    required this.imagePost,
    required this.dateTime,
  });
  PostModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    uId = json['uId'];
    image = json['image'];
    text = json['text'];
    imagePost = json['imagePost'];
    dateTime = json['dateTime'];
  }
  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'uId': uId,
      'image': image,
      'text': text,
      'imagePost': imagePost,
      'dateTime': dateTime,
    };
  }
}

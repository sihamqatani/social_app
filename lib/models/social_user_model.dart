class SocialUserModel {
  late String name;
  late String email;
  late String phone;
  late String uId;
  late bool isEmailVerified;
  String? image;
  String? cover;
  late String bio;

  SocialUserModel(
      {required this.name,
      required this.email,
      required this.phone,
      required this.uId,
      required this.isEmailVerified,
      required this.cover,
      required this.image,
      required this.bio});
  SocialUserModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    email = json['email'];
    phone = json['phone'];
    uId = json['uId'];
    isEmailVerified = json['isEmailVerified'];
    image = json['image'];
    cover = json['cover'];
    bio = json['bio'];
  }
  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'email': email,
      'phone': phone,
      'uId': uId,
      'isEmailVerified': isEmailVerified,
      'image': image,
      'cover': cover,
      'bio': bio,
    };
  }
}

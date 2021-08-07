class SocialUserModel {
  late String name;
  late String email;
  late String phone;
  late String uId;
  late bool isEmailVerified;
  String? image;
  SocialUserModel(
      {required this.name,
      required this.email,
      required this.phone,
      required this.uId,
      required this.isEmailVerified,
      this.image});
  SocialUserModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    email = json['email'];
    phone = json['phone'];
    uId = json['uId'];
    isEmailVerified = json['isEmailVerified'];
    image = json['image'];
  }
  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'email': email,
      'phone': phone,
      'uId': uId,
      'isEmailVerified': isEmailVerified,
      'image': image,
    };
  }
}

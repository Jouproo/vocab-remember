class UsersModel {

  String  ? name ;
  String ? email;
  String ? phone;
  String ? uId;
  String ? image;
  String ? cover;
  String ? bio;

  bool ? isEmailVerified;

  UsersModel({
     this.name,
    this.email,
    this.phone,
    this.uId,
    this.isEmailVerified,
    this.bio,
    this.cover,
    this.image
  });

  UsersModel.fromJson(Map<String, dynamic>json){
    name = json['name'];
    email = json['email'];
    phone = json['phone'];
    uId = json['uId'];
    image = json['image'];
    cover = json['cover'];
    bio = json['bio'];

    isEmailVerified = json['isEmailVerified'];
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'email': email,
      'uId': uId,
      'phone': phone,
      'isEmailVerified': isEmailVerified,
      'image': image,
      'cover': cover,
      'bio': bio,
    };
  }
}
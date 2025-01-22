// ignore_for_file: public_member_api_docs, sort_constructors_first

class UserAuthModel {
  String id;
  String accessToken;
  String refreshToken;

  String fName;
  String lName;
  String? phone;
  String email;
  String image;
  String role;
  String is_confirmed;

  UserAuthModel({
    required this.id,
    required this.accessToken,
    required this.refreshToken,
    required this.fName,
    required this.lName,
    required this.phone,
    required this.email,
    required this.role,
    required this.image,
    required this.is_confirmed,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'fName': fName,
      'lName': lName,
      'phone': phone,
      'email': email,
      'is_confirmed': is_confirmed,
      'role': role,
      'image': image,
      'accessToken': accessToken,
      'refreshToken': refreshToken,
    };
  }

  factory UserAuthModel.fromMap(Map<String, dynamic> map) {
    return UserAuthModel(
      is_confirmed: map["is_confirmed"],
      id: map['id'],
      fName: map['f_name'],
      lName: map['l_name'],
      phone: map['phone_number'],
      email: map['email_address'],
      role: map['role'],
      image: map['image'],
      accessToken: map["access_token"],
      refreshToken: map["refresh_token"],
    );
  }
}

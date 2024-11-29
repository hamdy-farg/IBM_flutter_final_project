// ignore_for_file: public_member_api_docs, sort_constructors_first

class UserModel {
  String id;
  String f_name;
  String l_name;
  String? phone;
  String email;
  String role;
  UserModel({
    required this.id,
    required this.f_name,
    required this.l_name,
    required this.phone,
    required this.email,
    required this.role,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'f_name': f_name,
      'l_name': l_name,
      'phone': phone,
      'email': email,
      'role': role,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      id: map['id'],
      f_name: map['f_name'],
      l_name: map['l_name'],
      phone: map['phone_number'],
      email: map['email_address'],
      role: map['role'],
    );
  }
}

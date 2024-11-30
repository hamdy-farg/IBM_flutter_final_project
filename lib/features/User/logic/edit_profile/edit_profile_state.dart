// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:dio/dio.dart';
import 'package:image_picker/image_picker.dart';

class EditProfileState {
  XFile? image;
  String? fName;
  String? lName;
  String? email;
  String? phone;
  bool? isLoading;
  String? message;
  String? imageLink;
  EditProfileState? profile;
  EditProfileState({
    this.image,
    this.fName,
    this.lName,
    this.email,
    this.phone,
    this.isLoading,
    this.message,
    this.profile,
    this.imageLink,
  });

  EditProfileState copyWith({
    XFile? image,
    String? fName,
    String? lName,
    String? email,
    String? phone,
    bool? isLoading,
    String? message,
    EditProfileState? profile,
    String? imageLink,
  }) {
    return EditProfileState(
      image: image ?? this.image,
      fName: fName ?? this.fName,
      lName: lName ?? this.lName,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      isLoading: isLoading ?? this.isLoading,
      message: message ?? this.message,
      profile: profile ?? this.profile,
      imageLink: imageLink ?? this.imageLink,
    );
  }

//
  Map<String, dynamic> toMap(MultipartFile? image) {
    return <String, dynamic>{
      'f_name': fName ?? "",
      'l_name': lName ?? "",
      'email_address': email ?? "",
      'phone_number': phone ?? "",
      "image": image ?? "",
    };
  }

  factory EditProfileState.fromMap(Map<String, dynamic> map) {
    return EditProfileState(
      imageLink: map['image'],
      fName: map['f_name'],
      lName: map['l_name'],
      email: map['email_address'],
      phone: map['phone_number'],
    );
  }
}

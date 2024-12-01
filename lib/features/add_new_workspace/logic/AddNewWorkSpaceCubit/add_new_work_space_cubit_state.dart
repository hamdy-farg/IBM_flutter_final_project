// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:dio/dio.dart';
import 'package:image_picker/image_picker.dart';

class AddNewWorkSpaceState {
  String? title;
  String? description;
  XFile? imageFile;
  String? imageLink;
  String? locaiton;
  bool? isLoading;
  String? errorMessage;
  AddNewWorkSpaceState? workSpace;

  AddNewWorkSpaceState({
    this.title,
    this.description,
    this.imageLink,
    this.imageFile,
    this.locaiton,
    this.isLoading,
    this.errorMessage,
    this.workSpace,
  });

  AddNewWorkSpaceState copyWith({
    String? title,
    String? description,
    XFile? imageFile,
    String? locaiton,
    bool? isLoading,
    String? errorMessage,
    AddNewWorkSpaceState? workSpace,
  }) {
    return AddNewWorkSpaceState(
      title: title ?? this.title,
      description: description ?? this.description,
      imageFile: imageFile ?? this.imageFile,
      locaiton: locaiton ?? this.locaiton,
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage ?? this.errorMessage,
      workSpace: workSpace ?? this.workSpace,
    );
  }

  Map<String, dynamic> toMap(MultipartFile? image) {
    return <String, dynamic>{
      'title': title ?? "",
      'description': description ?? "",
      'image': image ?? "",
      'location': locaiton ?? "",
    };
  }

  factory AddNewWorkSpaceState.fromMap(Map<String, dynamic> map) {
    return AddNewWorkSpaceState(
      title: map['title'],
      description: map['description'],
      imageLink: map["image"],
      locaiton: map['locaiton'],
    );
  }
}

// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:image_picker/image_picker.dart';

class AddNewWorkSpaceState {
  String? title;
  String? description;
  XFile? imageFile;
  String? imageLink;
  String? locaiton;
  AddNewWorkSpaceState({
    this.title,
    this.description,
    this.imageLink,
    this.imageFile,
    this.locaiton,
  });

  AddNewWorkSpaceState copyWith({
    String? title,
    String? description,
    XFile? imageFile,
    String? locaiton,
  }) {
    return AddNewWorkSpaceState(
      title: title ?? this.title,
      description: description ?? this.description,
      imageFile: imageFile ?? this.imageFile,
      locaiton: locaiton ?? this.locaiton,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'title': title,
      'description': description,
      'image': imageFile,
      'locaiton': locaiton,
    };
  }

  factory AddNewWorkSpaceState.fromMap(Map<String, dynamic> map) {
    return AddNewWorkSpaceState(
      title: map['title'] as String,
      description: map['description'] as String,
      imageLink: map["image"] as String,
      locaiton: map['locaiton'] as String,
    );
  }
}

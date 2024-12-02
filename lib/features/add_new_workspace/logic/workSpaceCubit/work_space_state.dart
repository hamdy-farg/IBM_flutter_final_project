// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:dio/dio.dart';
import 'package:ibm_flutter_final_project/features/workspace_status/data/model/work_space_model.dart';
import 'package:image_picker/image_picker.dart';

enum WorkSpaceStatus {
  edit,
  addNew,
}

class WorkSpaceState {
  String? title;
  String? description;
  XFile? imageFile;
  String? imageLink;
  String? locaiton;
  bool? isLoading;
  String? errorMessage;
  WorkSpaceState? workSpace;
  WorkSpaceStatus? workSpaceStatus;
  WorkSpaceModel? workSpaceModel;
  WorkSpaceState({
    this.title,
    this.description,
    this.imageLink,
    this.imageFile,
    this.locaiton,
    this.isLoading,
    this.errorMessage,
    this.workSpace,
    this.workSpaceStatus,
    this.workSpaceModel,
  });

  WorkSpaceState copyWith({
    String? title,
    String? description,
    XFile? imageFile,
    String? locaiton,
    bool? isLoading,
    String? errorMessage,
    WorkSpaceState? workSpace,
    WorkSpaceStatus? workSpaceStatus,
    WorkSpaceModel? workSpaceModel,
    String? imageLink,
  }) {
    return WorkSpaceState(
      title: title ?? this.title,
      description: description ?? this.description,
      imageFile: imageFile ?? this.imageFile,
      locaiton: locaiton ?? this.locaiton,
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage ?? this.errorMessage,
      workSpace: workSpace ?? this.workSpace,
      workSpaceStatus: workSpaceStatus ?? this.workSpaceStatus,
      workSpaceModel: workSpaceModel ?? this.workSpaceModel,
      imageLink: imageLink ?? this.imageLink,
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

  factory WorkSpaceState.fromMap(Map<String, dynamic> map) {
    return WorkSpaceState(
      title: map['title'],
      description: map['description'],
      imageLink: map["image"],
      locaiton: map['locaiton'],
    );
  }
}

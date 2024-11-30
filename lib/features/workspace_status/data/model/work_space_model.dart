// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class WorkSpaceModel {
  final String description;
  final String id;
  final String image;
  final String location;
  final String title;
  const WorkSpaceModel({
    required this.location,
    required this.description,
    required this.id,
    required this.image,
    required this.title,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'description': description,
      'id': id,
      'image': image,
      'title': title,
    };
  }

  factory WorkSpaceModel.fromMap(Map<String, dynamic> map) {
    return WorkSpaceModel(
      description: map['description'] as String,
      id: map['id'] as String,
      image: map['image'] as String,
      title: map['title'] as String,
      location: map['location'] as String
    );
  }


  @override
  String toString() {
    return 'WorkSpaceModel(description: $description, id: $id, image: $image, title: $title)';
  }
}

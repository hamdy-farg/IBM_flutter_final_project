// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:dio/dio.dart';
import 'package:image_picker/image_picker.dart';

class RoomModel {
  final String? id;
  final String? workSpaceId;
  final String? title;
  final String? description;
  final double? pricePerHour;
  final int? capacity;
  final String? startDate;
  final String? endDate;
  final String? startTime;
  final String? endTime;
  final String? imageLink;

  final XFile? imageFile;
  RoomModel({
    this.id,
    this.workSpaceId,
    this.title,
    this.description,
    this.pricePerHour,
    this.capacity,
    this.startDate,
    this.endDate,
    this.startTime,
    this.endTime,
    this.imageLink,
    this.imageFile,
  });

  RoomModel copyWith({
    String? id,
    String? workSpaceId,
    String? title,
    String? description,
    double? pricePerHour,
    int? capacity,
    String? startDate,
    String? endDate,
    String? startTime,
    String? endTime,
    String? imageLink,
  }) {
    return RoomModel(
      id: id ?? this.id,
      workSpaceId: workSpaceId ?? this.workSpaceId,
      title: title ?? this.title,
      description: description ?? this.description,
      pricePerHour: pricePerHour ?? this.pricePerHour,
      capacity: capacity ?? this.capacity,
      startDate: startDate ?? this.startDate,
      endDate: endDate ?? this.endDate,
      startTime: startTime ?? this.startTime,
      endTime: endTime ?? this.endTime,
      imageLink: imageLink ?? this.imageLink,
    );
  }

  Map<String, dynamic> toMap(MultipartFile? imageFile) {
    return <String, dynamic>{
      'room_id': id,
      'work_space_id': workSpaceId,
      'title': title,
      'description': description,
      'price_per_hour': pricePerHour,
      'capacity': capacity,
      'start_date': startDate,
      'end_date': endDate,
      'start_time': startTime,
      'end_time': endTime,
      'image': imageFile,
    };
  }

  factory RoomModel.fromLocalMap(
      Map<String, dynamic> map, String? workSpaceId) {
    return RoomModel(
      id: map['id'],
      workSpaceId: workSpaceId ?? map['work_space_id'],
      title: map['title'],
      description: map['description'],
      pricePerHour: map['price_per_hour'],
      capacity: int.parse(map['capacity']),
      startDate: map['start_date'],
      endDate: map['end_date'],
      startTime: map['start_time'],
      endTime: map['end_time'],
      imageFile: map['image'],
    );
  }
  factory RoomModel.fromApiMap(Map<String, dynamic> map) {
    return RoomModel(
      id: map['id'],
      workSpaceId: map['work_space_id'],
      title: map['title'],
      description: map['description'],
      pricePerHour: map['price_per_hour'],
      capacity: map['capacity'],
      startDate: map['start_date'],
      endDate: map['end_date'],
      startTime: map['start_time'],
      endTime: map['end_time'],
      imageLink: map['image'],
    );
  }
}

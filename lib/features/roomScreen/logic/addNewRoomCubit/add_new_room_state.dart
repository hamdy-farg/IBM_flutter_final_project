import 'package:ibm_flutter_final_project/features/roomScreen/data/models/room_model.dart';
import 'package:image_picker/image_picker.dart';

class RoomState {
  //  8
  String? title;
  String? description;
  XFile? image;
  String? capacity;
  String? startDate;
  double? pricePerHour;

  String? endDate;
  String? startTime;
  String? endTime;
  bool? isLoading;
  String? message;
  bool? selectedImageIsNull;
  RoomModel? room;
  DateTime? tommorw;
  bool? deleted;
  RoomState({
    this.title,
    this.description,
    this.image,
    this.capacity,
    this.startDate,
    this.endDate,
    this.endTime,
    this.startTime,
    this.isLoading,
    this.message,
    this.room,
    this.pricePerHour,
    this.selectedImageIsNull,
    this.tommorw,
    this.deleted,
  });

  RoomState copyWith({
    String? title,
    String? description,
    XFile? image,
    String? capacity,
    String? startDate,
    String? endDate,
    String? startTime,
    String? endTime,
    bool? isLoading,
    String? message,
    RoomModel? room,
    double? pricePerHour,
    bool? selectedImageIsNull,
    DateTime? tommorw,
    bool? deleted,
  }) {
    return RoomState(
      title: title ?? this.title,
      description: description ?? this.description,
      image: image ?? this.image,
      capacity: capacity ?? this.capacity,
      startDate: startDate ?? this.startDate,
      endDate: endDate ?? this.endDate,
      startTime: startTime ?? this.startTime,
      endTime: endTime ?? this.endTime,
      isLoading: isLoading ?? this.isLoading,
      message: message ?? this.message,
      room: room ?? this.room,
      pricePerHour: pricePerHour ?? this.pricePerHour,
      selectedImageIsNull: selectedImageIsNull ?? this.selectedImageIsNull,
      tommorw: tommorw ?? this.tommorw,
      deleted: deleted ?? this.deleted,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'title': title,
      'price_per_hour': pricePerHour,
      'description': description,
      'image': image,
      'start_date': startDate,
      'end_date': endDate,
      'start_time': startTime,
      'end_time': endTime,
      'capacity': capacity
    };
  }

  factory RoomState.fromMap(Map<String, dynamic> map) {
    return RoomState(
        title: map['title'],
        description: map['description'],
        image: map['image'],
        pricePerHour: map['price_per_hour'],
        endDate: map['endDate'],
        startDate: map['startDate'],
        capacity: map['capacity'],
        endTime: map['endDate'],
        startTime: map['startTime']);
  }
}

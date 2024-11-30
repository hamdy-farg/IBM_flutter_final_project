import 'package:image_picker/image_picker.dart';

class AddNewRoomState {
  //  8
  String? title;
  String? description;
  XFile? image;
  String? capacity;
  String? startDate;
  String? endDate;
  String? startTime;
  String? endTime;

  AddNewRoomState(
      {this.title,
      this.description,
      this.image,
      this.capacity,
      this.startDate,
      this.endDate,
      this.endTime,
      this.startTime});

  AddNewRoomState copyWith({
    String? title,
    String? description,
    XFile? image,
    String? capacity,
    String? startDate,
    String? endDate,
    String? startTime,
    String? endTime,
  })  
  {
    //!
//!!!!!!!!!!
    return AddNewRoomState(
        title: title ?? this.title,
        description: description ?? this.description,
        image: image ?? this.image,
        capacity: capacity ?? this.capacity,
        startDate: startDate ?? this.startDate,
        endDate: endDate ?? this.endDate,
        startTime: startTime ?? this.startTime,
        endTime: endTime ?? this.endTime);
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'title': title,
      'description': description,
      'image': image,
      'startDate': startDate,
      'endDate': endDate,
      'startTime': startTime,
      'endTime': endTime,
      'capacity': capacity
    };
  }

  factory AddNewRoomState.fromMap(Map<String, dynamic> map) {
    return AddNewRoomState(
        title: map['title'],
        description: map['description'],
        image: map['image'],
        endDate: map['endDate'],
        startDate: map['startDate'],
        capacity: map['capacity'],
        endTime: map['endDate'],
        startTime: map['startTime']);
  }
}

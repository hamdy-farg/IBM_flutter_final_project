// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class BookModel {
  String? clientId;
  String? id;
  String? roomId;
  double? price;
  String? date;
  String? startTime;
  String? endTime;
  String? status;
  String? roomImage;
  String? roomTitle;

  String? WorkSpaceTitle;

  BookModel({
    this.clientId,
    this.roomId,
    this.price,
    this.startTime,
    this.endTime,
    required this.status,
    required this.roomImage,
    this.id,
    this.date,
    this.WorkSpaceTitle,
    this.roomTitle,
  });

  BookModel copyWith({
    String? clientId,
    String? roomId,
    double? price,
    String? startTime,
    String? endTime,
    String? status,
    String? roomImage,
    String? id,
  }) {
    return BookModel(
        clientId: clientId ?? this.clientId,
        roomId: roomId ?? this.roomId,
        price: price ?? this.price,
        startTime: startTime ?? this.startTime,
        endTime: endTime ?? this.endTime,
        status: status ?? this.status,
        roomImage: roomImage ?? this.roomImage,
        id: id ?? this.id);
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'book_id': id,
      'date': date,
      'price': price,
      'start_time': startTime,
      'end_time': endTime,
      'status': status,
    };
  }

  factory BookModel.fromMap(Map<String, dynamic> map) {
    return BookModel(
      clientId: map['client_id'],
      roomId: map['room_id'],
      price: map['price'],
      date: map['date'],
      startTime: map['start_time'],
      endTime: map['end_time'],
      status: map['status'],
      roomImage: map['room_image'],
      id: map['id'],
      roomTitle: map['room_title'],
      WorkSpaceTitle: map['work_space_title'],
    );
  }

  String toJson() => json.encode(toMap());

  factory BookModel.fromJson(String source) =>
      BookModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'BookModel(clientId: $clientId, roomId: $roomId, price: $price, startTime: $startTime, endTime: $endTime, status: $status, roomImage: $roomImage)';
  }

  @override
  bool operator ==(covariant BookModel other) {
    if (identical(this, other)) return true;

    return other.clientId == clientId &&
        other.roomId == roomId &&
        other.price == price &&
        other.startTime == startTime &&
        other.endTime == endTime &&
        other.status == status &&
        other.roomImage == roomImage;
  }

  @override
  int get hashCode {
    return clientId.hashCode ^
        roomId.hashCode ^
        price.hashCode ^
        startTime.hashCode ^
        endTime.hashCode ^
        status.hashCode ^
        roomImage.hashCode;
  }
}

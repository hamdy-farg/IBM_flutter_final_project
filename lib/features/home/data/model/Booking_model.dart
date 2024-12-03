// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class UserBookingModel {
  String? clientId;
  String? roomId;
  double? price;
  String? date;
  String? startTime;
  String? endTime;
  UserBookingModel({
    this.clientId,
    this.roomId,
    this.price,
    this.date,
    this.startTime,
    this.endTime,
  });

  UserBookingModel copyWith({
    String? clientId,
    String? roomId,
    double? price,
    String? date,
    String? startTime,
    String? endTime,
  }) {
    return UserBookingModel(
      clientId: clientId ?? this.clientId,
      roomId: roomId ?? this.roomId,
      price: price ?? this.price,
      date: date ?? this.date,
      startTime: startTime ?? this.startTime,
      endTime: endTime ?? this.endTime,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'client_id': clientId,
      'room_id': roomId,
      'price': price,
      'date': date,
      'start_time': startTime,
      'end_time': endTime,
    };
  }

  factory UserBookingModel.fromMap(Map<String, dynamic> map) {
    return UserBookingModel(
      clientId: map['client_id'] as String,
      roomId: map['room_id'] as String,
      price: map['price'],
      date: map['date'] as String,
      startTime: map['start_time'] as String,
      endTime: map['end_time'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory UserBookingModel.fromJson(String source) =>
      UserBookingModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'UserBookingModel(clientId: $clientId, roomId: $roomId, price: $price, date: $date, startTime: $startTime, endTime: $endTime)';
  }

  @override
  bool operator ==(covariant UserBookingModel other) {
    if (identical(this, other)) return true;

    return other.clientId == clientId &&
        other.roomId == roomId &&
        other.price == price &&
        other.date == date &&
        other.startTime == startTime &&
        other.endTime == endTime;
  }

  @override
  int get hashCode {
    return clientId.hashCode ^
        roomId.hashCode ^
        price.hashCode ^
        date.hashCode ^
        startTime.hashCode ^
        endTime.hashCode;
  }
}

// ignore_for_file: public_member_api_docs, sort_constructors_first

class UserBookingModel {
  String? roomId;
  double? price;
  String? date;
  String? startTime;
  String? endTime;
  UserBookingModel({
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
      roomId: roomId ?? this.roomId,
      price: price ?? this.price,
      date: date ?? this.date,
      startTime: startTime ?? this.startTime,
      endTime: endTime ?? this.endTime,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'room_id': roomId,
      'price': price,
      'date': date,
      'start_time': startTime,
      'end_time': endTime,
    };
  }

  factory UserBookingModel.fromMap(Map<String, dynamic> map) {
    return UserBookingModel(
      roomId: map['room_id'] as String,
      price: map['price'],
      date: map['date'] as String,
      startTime: map['start_time'] as String,
      endTime: map['end_time'] as String,
    );
  }
}

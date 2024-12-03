// ignore_for_file: public_member_api_docs, sort_constructors_first
class BookRoomState {
  String? selectedDate;
  String? checkInHour;
  String? checkOutHour;
  BookRoomState({
    this.selectedDate,
    this.checkInHour,
    this.checkOutHour,
  });
  BookRoomState copyWith({
    String? selectedDate,
    String? checkInHour,
    String? checkOutHour,
  }) {
    return BookRoomState(
        selectedDate: selectedDate ?? this.selectedDate,
        checkInHour: checkInHour ?? this.checkInHour,
        checkOutHour: checkOutHour ?? this.checkOutHour);
  }
    Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'selectedDate': selectedDate,
      'checkInHour': checkInHour,
      'checkOutHour': checkOutHour,
     };
  }
    factory BookRoomState.fromMap(Map<String, dynamic> map) {
    return BookRoomState(
      selectedDate: map['selectedDate'] ,
      checkInHour: map['checkInHour'],
      checkOutHour: map["checkOutHour"] ,
     );
  }
}

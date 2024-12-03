// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'bookings_cubit.dart';

@immutable
sealed class BookingsState {}

class BookingsInitialState extends BookingsState {}

class BookingsIsLoadingState extends BookingsState {}

class BookingsSuccessState extends BookingsState {
  List<BookModel> bookedList;
  BookingsSuccessState({
    required this.bookedList,
  });
}

class BookingsFialState extends BookingsState {
  String erroMessage;
  BookingsFialState({
    required this.erroMessage,
  });
}

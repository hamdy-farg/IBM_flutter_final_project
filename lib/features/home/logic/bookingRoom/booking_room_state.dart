part of 'booking_room_cubit.dart';

@immutable
sealed class BookingRoomState {
  const BookingRoomState();
}

class BookingRoomInitialState extends BookingRoomState {}

class BookingRoomLoadingState extends BookingRoomState {}

class BookingRoomSuccessState extends BookingRoomState {
  final UserBookingModel userBookingModel;
  const BookingRoomSuccessState({required this.userBookingModel});
}

class BookingRoomFailState extends BookingRoomState {
  final String? errorMessage;
  const BookingRoomFailState({required this.errorMessage});
}

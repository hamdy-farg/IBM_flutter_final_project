// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'booking_cubit.dart';

@immutable
sealed class EditBookingState {}

class EditBookingInitialState extends EditBookingState {}

class EditBookingLoadingState extends EditBookingState {}

class EditBookingSuccessState extends EditBookingState {}

class EditBookingFailState extends EditBookingState {
  String errorMessage;
  EditBookingFailState({
    required this.errorMessage,
  });
}

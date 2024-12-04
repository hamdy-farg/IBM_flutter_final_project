import 'package:bloc/bloc.dart';
import 'package:cherry_toast/cherry_toast.dart';
import 'package:flutter/material.dart';
import 'package:ibm_flutter_final_project/core/networks/dio_consumer.dart';
import 'package:ibm_flutter_final_project/core/networks/dio_exceptions.dart';
import 'package:ibm_flutter_final_project/features/home/data/model/Booking_model.dart';
import 'package:ibm_flutter_final_project/features/home/data/repos/booking_repo.dart';

part 'booking_room_state.dart';

class BookingRoomCubit extends Cubit<BookingRoomState> {
  DioConsumer dio;
  BookingRoomCubit(this.dio) : super(BookingRoomInitialState());

  Future<void> makeBooking(UserBookingModel userBookingModel, context) async {
    emit(BookingRoomLoadingState());
    try {
      UserBookingModel userBookingModelResponce =
          await BookingUserRepo(dio).makeBooking(userBookingModel);

      emit(BookingRoomSuccessState(userBookingModel: userBookingModelResponce));
    } on ServerException catch (e) {
      CherryToast.error(
        title: Text(
          e.errorModel.message,
        ),
      ).show(context);

      emit(BookingRoomFailState(errorMessage: e.errorModel.message));
    }
  }
}

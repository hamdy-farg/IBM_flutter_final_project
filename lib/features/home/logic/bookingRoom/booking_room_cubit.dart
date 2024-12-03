import 'package:bloc/bloc.dart';
import 'package:ibm_flutter_final_project/core/networks/dio_consumer.dart';
import 'package:ibm_flutter_final_project/core/networks/dio_exceptions.dart';
import 'package:ibm_flutter_final_project/features/home/data/model/Booking_model.dart';
import 'package:ibm_flutter_final_project/features/home/data/repos/booking_repo.dart';
import 'package:meta/meta.dart';

part 'booking_room_state.dart';

class BookingRoomCubit extends Cubit<BookingRoomState> {
  DioConsumer dio;
  BookingRoomCubit(this.dio) : super(BookingRoomInitialState());

  void makeBooking(UserBookingModel userBookingModel) async {
    emit(BookingRoomLoadingState());
    try {
      UserBookingModel userBookingModelResponce =
          await BookingUserRepo(dio).makeBooking(userBookingModel);
          
      emit(BookingRoomSuccessState(userBookingModel: userBookingModelResponce));
    } on ServerException catch (e) {
      emit(BookingRoomFailState(errorMessage: e.errorModel.message));
    }
  }
}

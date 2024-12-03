import 'package:bloc/bloc.dart';
import 'package:ibm_flutter_final_project/core/di/dependancy_injection.dart';
import 'package:ibm_flutter_final_project/core/networks/dio_consumer.dart';
import 'package:ibm_flutter_final_project/core/networks/dio_exceptions.dart';
import 'package:ibm_flutter_final_project/features/adminControls/data/models/book.dart';
import 'package:ibm_flutter_final_project/features/adminControls/data/repos/book_repo.dart';
import 'package:ibm_flutter_final_project/features/adminControls/logic/bookingCubit/bookings_cubit.dart';
import 'package:meta/meta.dart';

part 'booking_state.dart';

class EditBookingCubit extends Cubit<EditBookingState> {
  DioConsumer dio;
  EditBookingCubit(this.dio) : super(EditBookingInitialState());

  void updatebooking(BookModel bookModel) async {
    emit(EditBookingLoadingState());
    try {
      final editStatus =
          await BookingsAdminRepo(dio).changeSatusOfBookings(bookModel);
      getIt<BookingsCubit>().getBookings();
      emit(EditBookingSuccessState());
    } on ServerException catch (e) {
      emit(EditBookingFailState(errorMessage: e.errorModel.message));
    }
  }
}

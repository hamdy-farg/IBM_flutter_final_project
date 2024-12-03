import 'package:bloc/bloc.dart';
import 'package:ibm_flutter_final_project/core/networks/dio_consumer.dart';
import 'package:ibm_flutter_final_project/core/networks/dio_exceptions.dart';
import 'package:ibm_flutter_final_project/features/adminControls/data/models/book.dart';
import 'package:ibm_flutter_final_project/features/adminControls/data/repos/book_repo.dart';
import 'package:meta/meta.dart';

part 'bookings_state.dart';

class BookingsCubit extends Cubit<BookingsState> {
  DioConsumer dio;
  BookingsCubit(this.dio) : super(BookingsInitialState());

  Future<void> getBookings() async {
    emit(BookingsIsLoadingState());
    try {
      List<BookModel> bookedList = await BookingsAdminRepo(dio).getBookings();
      emit(BookingsSuccessState(bookedList: bookedList));
    } on ServerException catch (e) {
      emit(BookingsFialState(erroMessage: e.errorModel.message));
    }
  }
}

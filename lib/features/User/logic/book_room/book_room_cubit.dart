import 'package:bloc/bloc.dart';
import 'package:ibm_flutter_final_project/features/User/logic/book_room/book_room_state.dart';

class BookRoomCubit extends Cubit<BookRoomState> {
  BookRoomCubit() : super(BookRoomState());

  void selectedDateChange(String? selectedDate) {
    emit(state.copyWith(selectedDate: selectedDate));
  }

  void checkInHourChange(String? checkInHour) {
    emit(state.copyWith(checkInHour: checkInHour));
  }

  void checkOutHourChange(String? checkOutHour) {
    emit(state.copyWith(checkOutHour: checkOutHour));
  }
}

import 'package:bloc/bloc.dart';
import 'package:ibm_flutter_final_project/features/User/logic/book_room/book_room_state.dart';

class BookRoomDataCubit extends Cubit<BookRoomState> {
  BookRoomDataCubit() : super(BookRoomState());

  void selectedDateChange(String? selectedDate) async {
    emit(state.copyWith(selectedDate: selectedDate));
  }

  void checkInHourChange(String? checkInHour) {
    state.checkInHour = checkInHour;
    emit(state.copyWith(checkInHour: checkInHour));
  }

  void checkOutHourChange(String? checkOutHour) {
    state.checkOutHour = checkOutHour;

    emit(state.copyWith(checkOutHour: checkOutHour));
  }

  void clearAll() {
    state.checkOutHour = null;
    emit(state.copyWith(checkOutHour: null));
    state.checkInHour = null;
    emit(state.copyWith(checkInHour: null));
    state.selectedDate = null;
    emit(state.copyWith(selectedDate: null));
    
  }
}

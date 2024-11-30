import 'package:bloc/bloc.dart';
import 'package:ibm_flutter_final_project/features/add-new-room/logic/cubit/add_new_room_state.dart';
import 'package:image_picker/image_picker.dart';

class AddNewRoomCubit extends Cubit<AddNewRoomState> {
  AddNewRoomCubit() : super(AddNewRoomState());

  void titleChange(String title) {
    emit(state.copyWith(title: title));
  }

  void descriptionChange(String description) {
      emit(state.copyWith(description: description));
  }

  void imageChange(XFile? image) {
    state.image = image;

      emit(state.copyWith(image: image));
  }

  void capacityChange(String capacity) {
      emit(state.copyWith(capacity: capacity));
  }

  void startDateChange(String startDate) {
      emit(state.copyWith(startDate: startDate));
  }

  void startTimeChange(String startTime) {
      emit(state.copyWith(startTime: startTime));
  }

  void endTimeChange(String endTime) {
      emit(state.copyWith(endTime: endTime));
  }

  void endDateChange(String endDate) {
      emit(state.copyWith(endDate: endDate));
  }

  void clearAll() {
    state.endDate = null;
    emit(state.copyWith(endTime: null));
    state.startDate = null;
    emit(state.copyWith(startDate: null));
    state.startTime = null;
    emit(state.copyWith(startTime: null));
    state.endTime = null;
    emit(state.copyWith(endTime: null));
    state.image = null;
    emit(state.copyWith(image: null));
    state.title = null;
    emit(state.copyWith(title: null));
    state.capacity = null;
    emit(state.copyWith(capacity: null));
  }
}

import 'package:bloc/bloc.dart';
import 'package:cherry_toast/cherry_toast.dart';
import 'package:flutter/material.dart';
import 'package:ibm_flutter_final_project/core/networks/dio_consumer.dart';
import 'package:ibm_flutter_final_project/core/networks/dio_exceptions.dart';
import 'package:ibm_flutter_final_project/features/roomScreen/data/models/room_model.dart';
import 'package:ibm_flutter_final_project/features/roomScreen/data/repos/rooms_repo.dart';
import 'package:ibm_flutter_final_project/features/roomScreen/logic/addNewRoomCubit/add_new_room_state.dart';
import 'package:image_picker/image_picker.dart';

class AddNewRoomCubit extends Cubit<AddNewRoomState> {
  DioConsumer dio;
  AddNewRoomCubit(this.dio) : super(AddNewRoomState());

  void titleChange(String? title) {
    emit(state.copyWith(title: title));
  }

  void descriptionChange(String? description) {
    emit(state.copyWith(description: description));
  }

  void pricePerHourChange(double? pricePerHour) {
    emit(state.copyWith(pricePerHour: pricePerHour));
  }

  void imageChange(XFile? image) {
    state.image = image;

    emit(state.copyWith(image: image));
  }

  void capacityChange(String? capacity) {
    emit(state.copyWith(capacity: capacity));
  }

  void startDateChange(String? startDate) {
    emit(state.copyWith(startDate: startDate));
  }

  void startTimeChange(String? startTime) {
    emit(state.copyWith(startTime: startTime));
  }

  void endTimeChange(String? endTime) {
    emit(state.copyWith(endTime: endTime));
  }

  void endDateChange(String? endDate) {
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
    state.isLoading = null;
    emit(state.copyWith(isLoading: null));
    state.message = null;
    emit(state.copyWith(message: null));
  }

  void AddNewRoom(RoomModel roomModel, BuildContext context) async {
    emit(state.copyWith(isLoading: true));
    try {
      RoomModel room = await AdminRoomsRepo(dio: dio).AddNewRooms(roomModel);
      state.isLoading = state.isLoading;
      emit(state.copyWith(isLoading: null));
      emit(state.copyWith(room: room));
    } on ServerException catch (e) {
      state.isLoading = state.isLoading;
      emit(state.copyWith(isLoading: null));
      CherryToast.error(
        title: Text("${e.errorModel.message}"),
      );
      emit(state.copyWith(message: e.errorModel.message));
    }
  }
}

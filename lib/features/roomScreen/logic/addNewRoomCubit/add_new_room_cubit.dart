import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:cherry_toast/cherry_toast.dart';
import 'package:flutter/material.dart';
import 'package:ibm_flutter_final_project/core/networks/dio_consumer.dart';
import 'package:ibm_flutter_final_project/core/networks/dio_exceptions.dart';
import 'package:ibm_flutter_final_project/features/roomScreen/data/models/room_model.dart';
import 'package:ibm_flutter_final_project/features/roomScreen/data/repos/rooms_repo.dart';
import 'package:ibm_flutter_final_project/features/roomScreen/logic/addNewRoomCubit/add_new_room_state.dart';
import 'package:image_picker/image_picker.dart';

class AddNewRoomCubit extends Cubit<RoomState> {
  DioConsumer dio;
  AddNewRoomCubit(this.dio) : super(RoomState());
  TextEditingController titleController = TextEditingController();
  TextEditingController capacityController = TextEditingController();
  TextEditingController pricePerHourController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  void readyToEdit(RoomModel room) {
    titleController.text = room.title ?? "";
    capacityController.text = room.capacity.toString() ?? "";
    pricePerHourController.text = room.pricePerHour.toString() ?? "";
    descriptionController.text = room.description ?? "";

    emit(state);
  }

  void selecteImageIsNullChange(bool? selectedImageIsNull) {
    state.selectedImageIsNull = selectedImageIsNull;
    emit(state.copyWith(selectedImageIsNull: selectedImageIsNull));
  }

  void titleChange(String? title) {
    log("${title}");
    emit(state.copyWith(title: title));
  }

  void descriptionChange(String? description) {
    log("${description}");

    emit(state.copyWith(description: description));
  }

  void pricePerHourChange(double? pricePerHour) {
    log("${pricePerHour}");

    emit(state.copyWith(pricePerHour: pricePerHour));
  }

  void imageChange(XFile? image) {
    state.image = image;
    log("${image}");

    emit(state.copyWith(image: image));
  }

  void capacityChange(String? capacity) {
    log("${capacity}");

    emit(state.copyWith(capacity: capacity));
  }

  void startDateChange(String? startDate) {
    log("${startDate}");

    emit(state.copyWith(startDate: startDate));
  }

  void deletedChange(bool? deleted) {
    log("${deleted}");
    state.deleted = deleted;
    emit(state.copyWith(deleted: deleted));
  }

  void tommorwChage(DateTime? tommorw) {
    log("${tommorw}");
    state.tommorw = tommorw;
    emit(state.copyWith(tommorw: tommorw));
  }

  void startTimeChange(String? startTime) {
    log("${startTime}");

    emit(state.copyWith(startTime: startTime));
  }

  void endTimeChange(String? endTime) {
    log("${endTime}");

    emit(state.copyWith(endTime: endTime));
  }

  void endDateChange(String? endDate) {
    log("${endDate}");

    emit(state.copyWith(endDate: endDate));
  }

  void clearAll() {
    titleController.text = "";
    capacityController.text = "";
    pricePerHourController.text = "";
    descriptionController.text = "";
    state.endDate = null;
    emit(state.copyWith(endTime: null));
    state.deleted = null;
    emit(state.copyWith(deleted: null));
    state.tommorw = null;
    emit(state.copyWith(tommorw: null));
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
    state.room = null;
    emit(state.copyWith(room: null));
  }

  void AddNewRoom(RoomModel roomModel, BuildContext context) async {
    emit(state.copyWith(isLoading: true));
    try {
      RoomModel room = await AdminRoomsRepo(dio: dio).AddNewRooms(roomModel);
      state.isLoading = null;
      emit(state.copyWith(isLoading: null));
      emit(state.copyWith(room: room));
    } on ServerException catch (e) {
      state.isLoading = null;
      emit(state.copyWith(isLoading: null));
      CherryToast.error(
        title: Text("${e.errorModel.message}"),
      );
      emit(state.copyWith(message: e.errorModel.message));
    }
  }

  void deleteRoom(String room_id, BuildContext context) async {
    emit(state.copyWith(isLoading: true));
    try {
      String room = await AdminRoomsRepo(dio: dio).deletRoom(room_id);
      state.isLoading = null;
      emit(state.copyWith(isLoading: null));
      emit(state.copyWith(deleted: true));
      CherryToast.error(title: Text("your room is deleted seccesfully"))
          .show(context);
    } on ServerException catch (e) {
      state.isLoading = null;
      emit(state.copyWith(isLoading: null));
      CherryToast.error(
        title: Text("${e.errorModel.message}"),
      );
      emit(state.copyWith(message: e.errorModel.message));
    }
  }

  void editRoom(RoomModel roomModel, BuildContext context) async {
    emit(state.copyWith(isLoading: true));
    try {
      RoomModel room = await AdminRoomsRepo(dio: dio).updateRoom(roomModel);
      state.isLoading = null;
      emit(state.copyWith(isLoading: null));
      emit(state.copyWith(room: room));
    } on ServerException catch (e) {
      state.isLoading = null;
      emit(state.copyWith(isLoading: null));
      CherryToast.error(
        title: Text("${e.errorModel.message}"),
      ).show(context);
      emit(state.copyWith(message: e.errorModel.message));
    }
  }
}

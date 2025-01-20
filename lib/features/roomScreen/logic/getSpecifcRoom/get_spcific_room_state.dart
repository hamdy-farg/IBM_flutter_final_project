// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:ibm_flutter_final_project/features/roomScreen/data/models/room_model.dart';

class GetSpcificRoomState {}

class AdminRoomsInitial extends GetSpcificRoomState {}

class GetSpcificRoomStateSeuccess extends GetSpcificRoomState {
  RoomModel roomModel;
  GetSpcificRoomStateSeuccess({
    required this.roomModel,
  });
}

class GetSpcificRoomStateFial extends GetSpcificRoomState {
  String errorMessage;
  GetSpcificRoomStateFial({
    required this.errorMessage,
  });
}

class GetSpcificRoomStateLoading extends GetSpcificRoomState {}

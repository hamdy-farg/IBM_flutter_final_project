// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:ibm_flutter_final_project/core/helpers/utils.dart';
import 'package:ibm_flutter_final_project/core/networks/dio_consumer.dart';
import 'package:ibm_flutter_final_project/core/networks/dio_exceptions.dart';
import 'package:ibm_flutter_final_project/core/networks/end_point.dart';
import 'package:ibm_flutter_final_project/features/roomScreen/data/models/room_model.dart';

class AdminRoomsRepo {
  DioConsumer dio;
  AdminRoomsRepo({
    required this.dio,
  });

  Future<String> deletRoom(String roomId) async {
    try {
      String accessToken = await getAccessToken(dio);
      Map<String, dynamic> RoomsResponce = await dio.delete(
          EndPoint.deleteRoom, accessToken,
          isFormData: true, data: {"room_id": roomId});

      return RoomsResponce["message"];
    } on ServerException catch (e) {
      rethrow;
    }
  }

  Future<List<RoomModel>> fetchRooms(String WorkSpaceId) async {
    try {
      log("enterd repo");
      String accessToken = await getAccessToken(dio);
      Map<String, dynamic> RoomsResponce = await dio.post(
          EndPoint.workSpaceRooms, accessToken,
          isFormData: true, data: {"work_space_id": WorkSpaceId});

      log("$RoomsResponce");
      List<RoomModel> rooms = (RoomsResponce["rooms"] as List<dynamic>)
          .map((room) => RoomModel.fromApiMap(room))
          .toList();
      return rooms;
    } on ServerException catch (e) {
      rethrow;
    }
  }

  Future<RoomModel> AddNewRooms(RoomModel room) async {
    try {
      MultipartFile? multipartFile;
      if (room.imageFile != null) {
        multipartFile = await MultipartFile.fromFile(
          room.imageFile!.path,
          filename: room.imageFile!.name,
        );
      }
      Map<String, dynamic> roomMap = room.toMap(multipartFile);
      roomMap.remove("room_id");
      String accessToken = await getAccessToken(dio);
      Map<String, dynamic> RoomsResponce = await dio.post(
        EndPoint.addRoom,
        accessToken,
        isFormData: true,
        data: roomMap,
      );
      return RoomModel.fromApiMap(
        RoomsResponce,
      );
    } on ServerException catch (e) {
      rethrow;
    }
  }

  Future<RoomModel> updateRoom(RoomModel room) async {
    try {
      MultipartFile? multipartFile;
      if (room.imageFile != null) {
        multipartFile = await MultipartFile.fromFile(
          room.imageFile!.path,
          filename: room.imageFile!.name,
        );
      }

      Map<String, dynamic> roomMap = room.toMap(multipartFile);
      log("$roomMap");
      roomMap.removeWhere((key, value) => value == null); //***** */
      String accessToken = await getAccessToken(dio);
      Map<String, dynamic> RoomsResponce = await dio.put(
        EndPoint.addRoom,
        accessToken,
        isFormData: true,
        data: roomMap,
      );
      return RoomModel.fromApiMap(
        RoomsResponce,
      );
    } on ServerException catch (e) {
      rethrow;
    }
  }
}

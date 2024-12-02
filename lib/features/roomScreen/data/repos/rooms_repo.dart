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

  Future<List<RoomModel>> fetchRooms(String WorkSpaceId) async {
    try {
      String accessToken = await getAccessToken(dio);
      Map<String, dynamic> RoomsResponce = await dio.post(
          EndPoint.workSpaceRooms, accessToken,
          isFormData: true, data: {"work_space_id": WorkSpaceId});
      log("$RoomsResponce");
      List<RoomModel> rooms = (RoomsResponce["rooms"] as List<dynamic>)
          .map((room) => RoomModel.fromMap(room))
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
      String accessToken = await getAccessToken(dio);
      Map<String, dynamic> RoomsResponce = await dio.post(
          EndPoint.addRoom, accessToken,
          isFormData: true, data: room.toMap(multipartFile));
      return RoomModel.fromMap(RoomsResponce);
    } on ServerException catch (e) {
      rethrow;
    }
  }
}

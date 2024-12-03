import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:ibm_flutter_final_project/core/networks/dio_consumer.dart';
import 'package:ibm_flutter_final_project/core/networks/dio_exceptions.dart';
import 'package:ibm_flutter_final_project/features/roomScreen/data/models/room_model.dart';
import 'package:ibm_flutter_final_project/features/roomScreen/data/repos/rooms_repo.dart';
import 'package:meta/meta.dart';

part 'admin_rooms_state.dart';

class AdminRoomsCubit extends Cubit<AdminRoomsState> {
  DioConsumer dio;
  AdminRoomsCubit(this.dio) : super(AdminRoomsInitial());
  Future<void> fetchRooms(String workSpaceId) async {
    emit(AdminRoomsLoading());
    try {
      log("begen to go to repo");
      List<RoomModel> rooms =
          await AdminRoomsRepo(dio: dio).fetchRooms(workSpaceId);
      log("rooms${rooms}");
      emit(AdminRoomsSeuccess(roomModel: rooms));
    } on ServerException catch (e) {
      emit(AdminRoomsFial(errorMessage: e.errorModel.message));
    }
  }
}

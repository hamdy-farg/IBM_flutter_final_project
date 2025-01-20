import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ibm_flutter_final_project/core/networks/dio_consumer.dart';
import 'package:ibm_flutter_final_project/core/networks/dio_exceptions.dart';
import 'package:ibm_flutter_final_project/features/roomScreen/data/models/room_model.dart';
import 'package:ibm_flutter_final_project/features/roomScreen/data/repos/rooms_repo.dart';
import 'package:ibm_flutter_final_project/features/roomScreen/logic/getSpecifcRoom/get_spcific_room_state.dart';

class GetSpecificRoomCubit extends Cubit<GetSpcificRoomState> {
  DioConsumer dio;
  GetSpecificRoomCubit(this.dio) : super(GetSpcificRoomState());
  void fetchSpecificRoom(String workSpaceId) async {
    emit(GetSpcificRoomStateLoading());
    try {
      RoomModel room =
          await AdminRoomsRepo(dio: dio).fetchSpecificRoom(workSpaceId);
      emit(GetSpcificRoomStateSeuccess(roomModel: room));
    } on ServerException catch (e) {
      emit(
        GetSpcificRoomStateFial(errorMessage: e.errorModel.message),
      );
    }
  }
}

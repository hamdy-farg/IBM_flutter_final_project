import 'package:bloc/bloc.dart';
import 'package:ibm_flutter_final_project/core/networks/dio_consumer.dart';
import 'package:ibm_flutter_final_project/core/networks/dio_exceptions.dart';
import 'package:ibm_flutter_final_project/features/home/data/repos/work_space_rooms_repo.dart';
import 'package:ibm_flutter_final_project/features/roomScreen/data/models/room_model.dart';
import 'package:meta/meta.dart';

part 'work_space_rooms_state.dart';

class WorkSpaceRoomsCubit extends Cubit<WorkSpaceRoomsState> {
  DioConsumer dio;
  WorkSpaceRoomsCubit(this.dio) : super(WorkSpaceRoomsInitialState());

  Future<void> getWorkSpaceRooms(String workSpaceId) async {
    emit(WorkSpaceRoomsLoadingState());

    try {
      List<RoomModel> roomModelsList =
          await WorkSpaceRoomsRepo(dio).getWorkSpaceRooms(workSpaceId);
      emit(WorkSpaceRoomsSuccessState(roomModelList: roomModelsList));
    } on ServerException catch (e) {
      emit(WorkSpaceRoomsFialState(errorMessage: e.errorModel.message));
    }
  }
}

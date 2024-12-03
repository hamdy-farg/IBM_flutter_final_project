import 'package:bloc/bloc.dart';
import 'package:ibm_flutter_final_project/core/networks/dio_consumer.dart';
import 'package:ibm_flutter_final_project/core/networks/dio_exceptions.dart';
import 'package:ibm_flutter_final_project/features/home/data/repos/home_repo.dart';
import 'package:ibm_flutter_final_project/features/roomScreen/data/models/room_model.dart';
import 'package:meta/meta.dart';

part 'hoom_rooms_state.dart';

class HomeRoomsCubit extends Cubit<HomeRoomsState> {
  DioConsumer dio;
  HomeRoomsCubit(this.dio) : super(HomeRoomInitialState());
  Future<void> getRooms() async {
    emit(HomeRoomLoadingState());
    try {
      List<RoomModel> roomList = await HomeRepo(dio).getRooms();
      emit(HomeRoomSuccesState(roomModelList: roomList));
    } on ServerException catch (e) {
      emit(HomeRoomFialState(errorMessage: e.errorModel.message));
    }
  }
}

import 'package:ibm_flutter_final_project/core/helpers/utils.dart';
import 'package:ibm_flutter_final_project/core/networks/dio_consumer.dart';
import 'package:ibm_flutter_final_project/core/networks/dio_exceptions.dart';
import 'package:ibm_flutter_final_project/core/networks/end_point.dart';
import 'package:ibm_flutter_final_project/features/roomScreen/data/models/room_model.dart';
import 'package:ibm_flutter_final_project/features/workspace_status/data/model/work_space_model.dart';

class HomeRepo {
  final DioConsumer dio;
  const HomeRepo(this.dio);

  Future<List<RoomModel>> getRooms() async {
    try {
      String accessToken = await getAccessToken(dio);

      Map<String, dynamic> getWorkSpaceResponce = await dio.get(
        EndPoint.allRooms,
        accessToken,
      );

      List<RoomModel> roomModelList = (getWorkSpaceResponce["rooms"] as List)
          .map(
            (wokSpace) => RoomModel.fromApiMap(wokSpace),
          )
          .toList();

      return roomModelList;
    } on ServerException catch (e) {
      rethrow;
    }
  }

  Future<List<WorkSpaceModel>> getWorkSpaces() async {
    try {
      String accessToken = await getAccessToken(dio);

      Map<String, dynamic> getWorkSpaceResponce = await dio.get(
        EndPoint.allWorkspacce,
        accessToken,
      );

      List<WorkSpaceModel> workSpaceModelList =
          (getWorkSpaceResponce["workSpaces"] as List)
              .map((wokSpace) => WorkSpaceModel.fromMap(wokSpace))
              .toList();

      return workSpaceModelList;
    } on ServerException catch (e) {
      rethrow;
    }
  }
}

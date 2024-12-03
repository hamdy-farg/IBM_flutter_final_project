import 'package:ibm_flutter_final_project/core/helpers/utils.dart';
import 'package:ibm_flutter_final_project/core/networks/dio_consumer.dart';
import 'package:ibm_flutter_final_project/core/networks/dio_exceptions.dart';
import 'package:ibm_flutter_final_project/core/networks/end_point.dart';
import 'package:ibm_flutter_final_project/features/roomScreen/data/models/room_model.dart';

class WorkSpaceRoomsRepo {
  DioConsumer dio;
  WorkSpaceRoomsRepo(this.dio);

  Future<List<RoomModel>> getWorkSpaceRooms(String workSpaceId) async {
    try {
      String accessToken = await getAccessToken(dio);
      Map<String, dynamic> data = await dio.post(
          EndPoint.workSpaceRooms, accessToken,
          data: {"work_space_id": workSpaceId}, isFormData: true);
          
      List<RoomModel> WorkSpaceRoomsList = (data["rooms"] as List)
          .map((room) => RoomModel.fromApiMap(room))
          .toList();

      return WorkSpaceRoomsList;
    } on ServerException catch (e) {
      rethrow;
    }
  }
}

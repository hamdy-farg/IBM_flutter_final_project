// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:ibm_flutter_final_project/core/helpers/utils.dart';
import 'package:ibm_flutter_final_project/core/networks/dio_consumer.dart';
import 'package:ibm_flutter_final_project/core/networks/dio_exceptions.dart';
import 'package:ibm_flutter_final_project/core/networks/end_point.dart';
import 'package:ibm_flutter_final_project/features/workspace_status/data/model/work_space_model.dart';

class ClientWorkSpaceRepo {
  DioConsumer dio;
  ClientWorkSpaceRepo(
    this.dio,
  );
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

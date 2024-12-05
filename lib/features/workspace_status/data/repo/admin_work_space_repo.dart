import 'dart:developer';

import 'package:ibm_flutter_final_project/core/helpers/utils.dart';
import 'package:ibm_flutter_final_project/core/networks/dio_consumer.dart';
import 'package:ibm_flutter_final_project/core/networks/dio_exceptions.dart';
import 'package:ibm_flutter_final_project/core/networks/end_point.dart';
import 'package:ibm_flutter_final_project/core/networks/model/error_model.dart';
import 'package:ibm_flutter_final_project/features/workspace_status/data/model/work_space_model.dart';

class AdminWorkSpacesRepo {
  final DioConsumer dio;
  const AdminWorkSpacesRepo(this.dio);
  Future fetchWorkSpaces() async {
    try {
      List<WorkSpaceModel> workSpacesList = [];
      String accessToken = await getAccessToken(dio);
      final data = await dio.get(EndPoint.adminWorkSpaces, accessToken);
      if (data["workSpaces"] != null) {
        for (Map<String, dynamic> workSpace in data["workSpaces"]) {
          workSpacesList.add(WorkSpaceModel.fromMap(workSpace));
        }
      }
      if (workSpacesList.isEmpty) {
        throw ServerException(
            errorModel:
                ErrorModel(message: "Click on Add new work space", code: 401));
      }
      return workSpacesList;
    } on ServerException catch (e) {
      rethrow;
    }
  }
}

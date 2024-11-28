import 'dart:developer';

import 'package:ibm_flutter_final_project/core/helpers/cach_helper.dart';
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
      await CacheHelper.sharedPreferences.setString("refresh_token",
          "Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJmcmVzaCI6ZmFsc2UsImlhdCI6MTczMjc1MjA2NSwianRpIjoiN2ZmN2Y4ZWYtYTVmNS00YmRkLTkxYzEtOTM2MDIwMmY0ZDgxIiwidHlwZSI6InJlZnJlc2giLCJzdWIiOiJmNzg2NmQ0ZDU3MmU0YjEyYmU2OTc0MjQ0ZjI0YTJlNiIsIm5iZiI6MTczMjc1MjA2NSwiY3NyZiI6ImNlZWNjNGM1LWM5MjQtNGU5Zi1iMjMxLWM4ZDA2ZDk5NGY2MiIsImV4cCI6MTczNTM0NDA2NSwiaXNfYWRtaW4iOnRydWV9.NT8xtum5tmtwU_Cq_JRPoowVSDfzjC-DgwOycrTAdPk");
      final String? refreshToken =
          CacheHelper.sharedPreferences.getString("refresh_token");

      if (refreshToken != null) {
        Map<String, dynamic> accessTokenResponce =
            await dio.post("refresh", refreshToken);
        String accessToken = "Bearer ${accessTokenResponce["access_token"]}";
        final data = await dio.get(EndPoint.adminWorkSpaces, accessToken);
        for (Map<String, dynamic> workSpace in data["workSpaces"]) {
          workSpacesList.add(WorkSpaceModel.fromMap(workSpace));
        }
        return workSpacesList;
      }
      throw ServerException(
          errorModel: ErrorModel(
              message: "you need to get your refresh token", code: 401));
    } on Exception catch (e) {
      log("$e");
      rethrow;
    }
  }
}

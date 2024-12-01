// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:dio/dio.dart';
import 'package:ibm_flutter_final_project/core/helpers/utils.dart';
import 'package:ibm_flutter_final_project/core/networks/dio_consumer.dart';
import 'package:ibm_flutter_final_project/core/networks/dio_exceptions.dart';
import 'package:ibm_flutter_final_project/core/networks/end_point.dart';
import 'package:ibm_flutter_final_project/features/add_new_workspace/logic/AddNewWorkSpaceCubit/add_new_work_space_cubit_state.dart';

class AddNewWorkSpaceRepo {
  DioConsumer dio;
  AddNewWorkSpaceRepo({
    required this.dio,
  });

  Future<AddNewWorkSpaceState> addNewWorkSpace(
      AddNewWorkSpaceState workSpace) async {
    try {
      MultipartFile? multipartFile;
      if (workSpace.imageFile != null) {
        multipartFile = await MultipartFile.fromFile(
          workSpace.imageFile!.path,
          filename: workSpace.imageFile!.name,
        );
      }
      String accessToken = await getAccessToken(dio);

      
      final addNewWorkspaceResponce = await dio.post(
          EndPoint.addWorkSpace, accessToken,
          data: workSpace.toMap(multipartFile), isFormData: true);
      AddNewWorkSpaceState workSpaceData =
          AddNewWorkSpaceState.fromMap(addNewWorkspaceResponce);
      return workSpaceData;
    } on ServerException catch (e) {
      rethrow;
    }
  }
}

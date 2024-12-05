// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:ibm_flutter_final_project/features/workspace_status/data/model/work_space_model.dart';

class GetAdminWorkSpacesState {
  const GetAdminWorkSpacesState();
}

class GetAdminWorkSpacesInitState extends GetAdminWorkSpacesState {
  const GetAdminWorkSpacesInitState();
}

class GetAdminWorkSpacesLoudingState extends GetAdminWorkSpacesState {}

class GetAdminWorkSpacesSuccessState extends GetAdminWorkSpacesState {
  List<WorkSpaceModel> workSpaceModeList;
  GetAdminWorkSpacesSuccessState({
    required this.workSpaceModeList,
  });
}

class GetAdminWorkSpacesFialierState extends GetAdminWorkSpacesState {
  String message;
  GetAdminWorkSpacesFialierState({
    required this.message,
  });
}

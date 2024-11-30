// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:ibm_flutter_final_project/features/workspace_status/data/model/work_space_model.dart';

class GetAdminWorkSpacesInitState {
  const GetAdminWorkSpacesInitState();
}

class GetAdminWorkSpacesLoudingState extends GetAdminWorkSpacesInitState {}

class GetAdminWorkSpacesSuccessState extends GetAdminWorkSpacesInitState {
  List<WorkSpaceModel>? workSpaceModeList;
  GetAdminWorkSpacesSuccessState({
    this.workSpaceModeList,
  });
}

class GetAdminWorkSpacesFialierState extends GetAdminWorkSpacesInitState {
  String message;
  GetAdminWorkSpacesFialierState({
    required this.message,
  });
}

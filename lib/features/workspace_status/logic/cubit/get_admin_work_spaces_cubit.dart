import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:ibm_flutter_final_project/core/networks/dio_consumer.dart';
import 'package:ibm_flutter_final_project/core/networks/dio_exceptions.dart';
import 'package:ibm_flutter_final_project/features/workspace_status/data/model/work_space_model.dart';
import 'package:ibm_flutter_final_project/features/workspace_status/data/repo/admin_work_space_repo.dart';
import 'package:ibm_flutter_final_project/features/workspace_status/logic/cubit/get_admin_work_spaces_state.dart';

class   GetAdminWorkSpacesCubit extends Cubit<GetAdminWorkSpacesInitState> {
  DioConsumer dio;
  GetAdminWorkSpacesCubit(this.dio)
      : super(const GetAdminWorkSpacesInitState());

  Future<void> fetchData() async {
    emit(GetAdminWorkSpacesLoudingState());

    try {
      List<WorkSpaceModel> workSpaces =
          await AdminWorkSpacesRepo(dio).fetchWorkSpaces();

      emit(GetAdminWorkSpacesSuccessState(workSpaceModeList: workSpaces));
    } on ServerException catch (e) {
      log("$e");
      emit(GetAdminWorkSpacesFialierState(message: e.errorModel.message));
    }
  }
}

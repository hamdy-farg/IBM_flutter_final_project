import 'package:bloc/bloc.dart';
import 'package:ibm_flutter_final_project/core/networks/dio_consumer.dart';
import 'package:ibm_flutter_final_project/core/networks/dio_exceptions.dart';
import 'package:ibm_flutter_final_project/features/home/data/repos/home_repo.dart';
import 'package:ibm_flutter_final_project/features/workspace_status/data/model/work_space_model.dart';
import 'package:meta/meta.dart';

part 'home_state.dart';

class HomeWorkSpaceCubit extends Cubit<HomeWorkSpaceState> {
  DioConsumer dio;
  HomeWorkSpaceCubit(this.dio) : super(HomeWorkSpaceInitialState());
  Future<void> getWorkSpace() async {
    emit(HomeWorkSpaceLoadingState());
    try {
      List<WorkSpaceModel> workSpaceList = await HomeRepo(dio).getWorkSpaces();
      emit(HomeWorkSpaceSuccesState(workSpaceModelList: workSpaceList));
    } on ServerException catch (e) {
      emit(HomeWorkSpaceFialState(errorMessage: e.errorModel.message));
    }
  }
}

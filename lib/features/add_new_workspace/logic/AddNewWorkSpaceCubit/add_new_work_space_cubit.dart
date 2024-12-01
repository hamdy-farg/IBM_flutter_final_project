import 'package:bloc/bloc.dart';
import 'package:cherry_toast/cherry_toast.dart';
import 'package:flutter/material.dart';
import 'package:ibm_flutter_final_project/core/networks/dio_consumer.dart';
import 'package:ibm_flutter_final_project/core/networks/dio_exceptions.dart';
import 'package:ibm_flutter_final_project/features/add_new_workspace/date/repos/add_new_work_space_repo.dart';
import 'package:ibm_flutter_final_project/features/add_new_workspace/logic/AddNewWorkSpaceCubit/add_new_work_space_cubit_state.dart';
import 'package:image_picker/image_picker.dart';

class AddNewWorkSpaceCubit extends Cubit<AddNewWorkSpaceState> {
  DioConsumer dio;
  AddNewWorkSpaceCubit(this.dio) : super(AddNewWorkSpaceState());

  void titleChange(String? title) {
    state.title = title;
    emit(state.copyWith(title: title));
  }

  void descriptionChange(String? description) {
    state.description = description;
    emit(state.copyWith(description: description));
  }

  void imageChange(XFile? imageFile) {
    state.imageFile = imageFile;
    emit(state.copyWith(imageFile: imageFile));
  }

  void locationChange(String? location) {
    state.locaiton = location;

    emit(state.copyWith(locaiton: location));
  }

  void clearAll() {
    state.imageFile = null;
    state.locaiton = null;
    state.title = null;
    state.description = null;
    state.isLoading = null;
    state.errorMessage = null;
    state.workSpace = null;
    // emit(state.copyWith(locaiton: null));
    // emit(state.copyWith(isLoading: null));
    // emit(state.copyWith(errorMessage: null));

    // emit(state.copyWith(imageFile: null));
    // emit(state.copyWith(workSpace: null));
    // emit(state.copyWith(title: null));
    // emit(state.copyWith(description: null));
  }

  Future<void> addNewWorkSpace(
      AddNewWorkSpaceState addNewWorkSpace, BuildContext context) async {
    emit(state.copyWith(isLoading: true));
    try {
      AddNewWorkSpaceState? workSpace =
          await AddNewWorkSpaceRepo(dio: dio).addNewWorkSpace(addNewWorkSpace);
      Future.delayed(const Duration(seconds: 4));
      state.isLoading = null;
      emit(state.copyWith(isLoading: null));
      emit(state.copyWith(workSpace: workSpace));
    } on ServerException catch (e) {
      CherryToast.error(
        title: Text(e.errorModel.message),
      ).show(context);
      state.isLoading = null;
      emit(state.copyWith(isLoading: null));
    }
  }
}

import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:cherry_toast/cherry_toast.dart';
import 'package:flutter/material.dart';
import 'package:ibm_flutter_final_project/core/di/dependancy_injection.dart';
import 'package:ibm_flutter_final_project/core/networks/dio_consumer.dart';
import 'package:ibm_flutter_final_project/core/networks/dio_exceptions.dart';
import 'package:ibm_flutter_final_project/features/add_new_workspace/date/repos/add_new_work_space_repo.dart';
import 'package:ibm_flutter_final_project/features/add_new_workspace/logic/workSpaceCubit/work_space_state.dart';
import 'package:ibm_flutter_final_project/features/workspace_status/data/model/work_space_model.dart';
import 'package:ibm_flutter_final_project/features/workspace_status/logic/cubit/get_admin_work_spaces_cubit.dart';
import 'package:image_picker/image_picker.dart';

class WorkSpaceCubit extends Cubit<WorkSpaceState> {
  DioConsumer dio;
  WorkSpaceCubit(this.dio) : super(WorkSpaceState());
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  void isEdit(WorkSpaceModel workSpace, context) async {
    // emit(state.copyWith(workSpaceStatus: WorkSpaceStatus.edit));
    state.workSpaceStatus = WorkSpaceStatus.edit;
    titleController.text = workSpace.title ?? "";
    descriptionController.text = workSpace.description ?? "";
    state.imageLink = workSpace.image ?? "";
    emit(state.copyWith(imageLink: workSpace.image));
    state.locaiton = workSpace.location;
    emit(state);
  }

  void titleChange(String? title) {
    emit(state.copyWith(title: title));
  }

  void placeHolderWorkSpaceChange(WorkSpaceModel workSpaceModel) {
    emit(state.copyWith(workSpaceModel: workSpaceModel));
  }

  void workSpaceStatusChange(WorkSpaceStatus? status) {
    emit(state.copyWith(workSpaceStatus: status));
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
    state.imageLink = null;
    state.imageFile = null;
    state.workSpaceModel = null;
    emit(state.copyWith(imageFile: null));
    emit(state.copyWith(imageFile: null));
    emit(state.copyWith(locaiton: null));
    emit(state.copyWith(title: null));
    emit(state.copyWith(description: null));
    emit(state.copyWith(isLoading: null));
    emit(state.copyWith(workSpaceModel: null));
    emit(state.copyWith(workSpace: null));
    titleController.text = "";
    descriptionController.text = "";
  }

  Future<void> deleteNewWorkSpace(
      BuildContext context, String workSpaceId) async {
    emit(state.copyWith(isLoading: true));
    try {
      WorkSpaceState? workSpace =
          await WorkSpaceRepo(dio: dio).deleteNewWorkSpace(workSpaceId);
      state.isLoading = null;
      emit(state.copyWith(isLoading: null));
      emit(state.copyWith(workSpace: workSpace));
      CherryToast.success(
        title: const Text("deleted successfully"),
      ).show(context);
    } on ServerException catch (e) {
      CherryToast.error(
        title: Text(e.errorModel.message),
      ).show(context);
      state.isLoading = null;
      emit(state.copyWith(isLoading: null));
    }
  }

  Future<void> editNewWorkSpace(WorkSpaceState newWorkSpace,
      BuildContext context, String workSpaceId) async {
    emit(state.copyWith(isLoading: true));
    try {
      log("image state ${newWorkSpace.imageFile}");

      WorkSpaceState? workSpace = await WorkSpaceRepo(dio: dio)
          .updateWorkSpace(newWorkSpace, workSpaceId);
      state.isLoading = null;

      emit(state.copyWith(isLoading: null));
      emit(state.copyWith(workSpace: workSpace));

      CherryToast.success(
        title: const Text("edited successfully"),
      ).show(context);
      await getIt<GetAdminWorkSpacesCubit>().fetchData();
    } on ServerException catch (e) {
      CherryToast.error(
        title: Text(e.errorModel.message),
      ).show(context);

      await getIt<GetAdminWorkSpacesCubit>().fetchData();

      state.isLoading = null;
      emit(state.copyWith(isLoading: null));
    }
  }

  Future<void> addNewWorkSpace(
      WorkSpaceState addNewWorkSpace, BuildContext context) async {
    emit(state.copyWith(isLoading: true));
    try {
      WorkSpaceState? workSpace =
          await WorkSpaceRepo(dio: dio).addNewWorkSpace(addNewWorkSpace);
      state.isLoading = null;
      emit(state.copyWith(isLoading: null));
      emit(state.copyWith(workSpace: workSpace));
      CherryToast.success(
        title: const Text("added successfully"),
      ).show(context);
      await getIt<GetAdminWorkSpacesCubit>().fetchData();
    } on ServerException catch (e) {
      log("------------------------------");
      state.isLoading = null;
      emit(state.copyWith(isLoading: null));

      CherryToast.error(
        title: Text(e.errorModel.message),
      ).show(context);
      await getIt<GetAdminWorkSpacesCubit>().fetchData();
    }
  }
}

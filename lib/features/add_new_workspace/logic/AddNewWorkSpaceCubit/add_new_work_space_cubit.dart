import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:ibm_flutter_final_project/features/add_new_workspace/logic/AddNewWorkSpaceCubit/add_new_work_space_cubit_state.dart';
import 'package:image_picker/image_picker.dart';

class AddNewWorkSpaceCubit extends Cubit<AddNewWorkSpaceState> {
  AddNewWorkSpaceCubit() : super(AddNewWorkSpaceState());

  void titleChange(String title) {
    emit(state.copyWith(title: title));
  }

  void descriptionChange(String description) {
    log(description);
    emit(state.copyWith(description: description));
  }

  void imageChange(XFile? imageFile) {
    state.imageFile = imageFile;
    emit(state.copyWith(imageFile: imageFile));
  }

  void locationChange(String location) {
    emit(state.copyWith(locaiton: location));
  }
}

import 'package:bloc/bloc.dart';
import 'package:ibm_flutter_final_project/features/add_new_workspace/logic/AddNewWorkSpaceCubit/add_new_work_space_cubit_state.dart';
import 'package:image_picker/image_picker.dart';

class AddNewWorkSpaceCubit extends Cubit<AddNewWorkSpaceState> {
  AddNewWorkSpaceCubit() : super(AddNewWorkSpaceState());

  // Method to pick an image from the gallery

  void titleChange(String title) {
    emit(AddNewWorkSpaceState.copyWith(title: title));
  }

  void descriptionChange(String description) {
    emit(AddNewWorkSpaceState.copyWith(description: description));
  }

  void imageChange(XFile imageFile) {
    emit(AddNewWorkSpaceState.copyWith(imageFile: imageFile));
  }

  void locationChange(String location) {
    emit(AddNewWorkSpaceState.copyWith(locaiton: location));
  }
}

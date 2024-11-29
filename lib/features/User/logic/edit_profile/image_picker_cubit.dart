import 'package:bloc/bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:meta/meta.dart';

part 'image_picker_state.dart';

class ImagePickerCubit extends Cubit<ImagePickerState> {
  ImagePickerCubit() : super(ImagePickerInitial());

  final ImagePicker _imagePicker = ImagePicker();

  Future<void> pickImage() async {
    try {
      final PickedImage =
          await _imagePicker.pickImage(source: ImageSource.gallery);
      if (PickedImage != null) {
        emit(ImageLoadedState(imagePath: (PickedImage.path)));
      } else {
        emit(ImageErrorState(errorMassage: 'No Image selected'));
      }
    } catch (e) {
      emit(ImageErrorState(errorMassage: e.toString()));
    }
  }
}

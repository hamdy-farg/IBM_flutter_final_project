import 'dart:io';
import 'package:bloc/bloc.dart';
import 'package:image_picker/image_picker.dart';

class ImagePickerCubit extends Cubit<File?> {
  final ImagePicker _picker = ImagePicker();

  ImagePickerCubit() : super(null);

  // Method to pick an image from the gallery
  Future<void> pickImage() async {
    try {
      final XFile? pickedFile = await _picker.pickImage(source: ImageSource.gallery);
      if (pickedFile != null) {
        emit(File(pickedFile.path));  // Update the state with the picked image
      }
    } catch (e) {
      print("Error picking image: $e");
    }
  }

  // Method to reset the image state (optional)
  void resetImage() {
    emit(null);  // Reset the image to null (no image selected)
  }
}

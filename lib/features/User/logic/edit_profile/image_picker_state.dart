part of 'image_picker_cubit.dart';

@immutable
abstract class ImagePickerState {}

class ImagePickerInitial extends ImagePickerState {}

class ImageLoadedState extends ImagePickerState {
  final String imagePath;

  ImageLoadedState({required this.imagePath});
}

class ImageErrorState extends ImagePickerState {
  final String errorMassage;

  ImageErrorState({required this.errorMassage});
}

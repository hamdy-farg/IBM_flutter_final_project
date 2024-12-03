// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'home_cubit.dart';

@immutable
sealed class HomeWorkSpaceState {
  const HomeWorkSpaceState();
}

class HomeWorkSpaceInitialState extends HomeWorkSpaceState {}

class HomeWorkSpaceLoadingState extends HomeWorkSpaceState {}

class HomeWorkSpaceFialState extends HomeWorkSpaceState {
  final String errorMessage;
  const HomeWorkSpaceFialState({
    required this.errorMessage,
  });
}

class HomeWorkSpaceSuccesState extends HomeWorkSpaceState {
  final List<WorkSpaceModel> workSpaceModelList;
  const HomeWorkSpaceSuccesState({
    required this.workSpaceModelList,
  });
}

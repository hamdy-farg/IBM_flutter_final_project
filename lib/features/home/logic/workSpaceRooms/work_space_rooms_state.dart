part of 'work_space_rooms_cubit.dart';

@immutable
sealed class WorkSpaceRoomsState {
  const WorkSpaceRoomsState();
}

class WorkSpaceRoomsInitialState extends WorkSpaceRoomsState {}

class WorkSpaceRoomsLoadingState extends WorkSpaceRoomsState {}

class WorkSpaceRoomsSuccessState extends WorkSpaceRoomsState {
  final List<RoomModel> roomModelList;
  const WorkSpaceRoomsSuccessState({required this.roomModelList});
}

class WorkSpaceRoomsFialState extends WorkSpaceRoomsState {
  final String errorMessage;
  const WorkSpaceRoomsFialState({required this.errorMessage});
}

part of 'hoom_rooms_cubit.dart';

@immutable
sealed class HoomRoomsState {
  const HoomRoomsState();
}

class HomeRoomInitialState extends HoomRoomsState {}

class HomeRoomLoadingState extends HoomRoomsState {}

class HomeRoomFialState extends HoomRoomsState {
  final String errorMessage;
  const HomeRoomFialState({
    required this.errorMessage,
  });
}

class HomeRoomSuccesState extends HoomRoomsState {
  final List<RoomModel> workSpaceModelList;
  const HomeRoomSuccesState({
    required this.workSpaceModelList,
  });
}

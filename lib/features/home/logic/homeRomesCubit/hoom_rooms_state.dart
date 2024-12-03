part of 'hoom_rooms_cubit.dart';

@immutable
sealed class HomeRoomsState {
  const HomeRoomsState();
}

class HomeRoomInitialState extends HomeRoomsState {}

class HomeRoomLoadingState extends HomeRoomsState {}

class HomeRoomFialState extends HomeRoomsState {
  final String errorMessage;
  const HomeRoomFialState({
    required this.errorMessage,
  });
}

class HomeRoomSuccesState extends HomeRoomsState {
  final List<RoomModel> roomModelList;
  const HomeRoomSuccesState({
    required this.roomModelList,
  });
}

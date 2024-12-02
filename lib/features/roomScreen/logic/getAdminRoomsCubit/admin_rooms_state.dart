// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'admin_rooms_cubit.dart';

@immutable
sealed class AdminRoomsState {}

class AdminRoomsInitial extends AdminRoomsState {}

class AdminRoomsSeuccess extends AdminRoomsState {
  List<RoomModel> roomModel;
  AdminRoomsSeuccess({
    required this.roomModel,
  });
}

class AdminRoomsFial extends AdminRoomsState {
  String errorMessage;
  AdminRoomsFial({
    required this.errorMessage,
  });
}

class AdminRoomsLoading extends AdminRoomsState {}

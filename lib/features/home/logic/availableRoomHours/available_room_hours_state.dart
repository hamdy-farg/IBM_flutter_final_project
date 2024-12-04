part of 'available_room_hours_cubit.dart';

@immutable
sealed class AvailableRoomHoursState {
  const AvailableRoomHoursState();
}

class AvailableRoomHoursInitialState extends AvailableRoomHoursState {
  const AvailableRoomHoursInitialState();
}

class AvailableRoomHoursLoadingState extends AvailableRoomHoursState {}

class AvailableRoomHoursSuccessState extends AvailableRoomHoursState {
  final List<Map<String, dynamic>> AvailableHoursList;
  const AvailableRoomHoursSuccessState({required this.AvailableHoursList});
}

class AvailableRoomHoursFialState extends AvailableRoomHoursState {
  final String errorMessage;
  const AvailableRoomHoursFialState({required this.errorMessage});
}
